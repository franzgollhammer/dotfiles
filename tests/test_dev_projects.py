"""Workspace navigation without touching the live home or tmux server."""

import os
from pathlib import Path
import subprocess
import tempfile
import unittest


REPO = Path(__file__).resolve().parents[1]


class DevProjectsTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="dotfiles-projects-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.dev = self.root / "dev with spaces"
        self.dev.mkdir()
        self.env = dict(os.environ, DEV=str(self.dev), TMUX="")

    def repo(self, relative):
        path = self.dev / relative
        (path / ".git").mkdir(parents=True)
        return path

    def run_list(self):
        result = subprocess.run([str(REPO / "scripts/dev_projects")],
                                env=self.env, capture_output=True, text=True, check=True)
        return result.stdout.splitlines()

    def test_lists_src_local_and_scratch_only(self):
        target = self.repo("src/github.com/planmanager/planfred")
        self.repo("src/github.com/franzgollhammer/ucsl-app")
        self.repo("src/gitlab.com/group/tool")
        self.repo("local/notes")
        (self.dev / "scratch/try out").mkdir(parents=True)
        # Old layout, loose folders, worktrees and links stay out of the list.
        self.repo("planmanager/legacy")
        self.repo("legacy-repo")
        self.repo("worktrees/github.com/planmanager/planfred/feature")
        (self.dev / "playground").mkdir()
        (self.dev / "local/linked").symlink_to(target, target_is_directory=True)
        (self.dev / "src/github.com/planmanager/alias").symlink_to(
            target, target_is_directory=True)
        self.assertEqual(self.run_list(), [
            "github.com/franzgollhammer/ucsl-app\tsrc/github.com/franzgollhammer/ucsl-app",
            "github.com/planmanager/planfred\tsrc/github.com/planmanager/planfred",
            "gitlab.com/group/tool\tsrc/gitlab.com/group/tool",
            "local/notes\tlocal/notes",
            "scratch/try out\tscratch/try out",
        ])

    def test_empty_dev_root_lists_nothing(self):
        self.assertEqual(self.run_list(), [])

    def run_tmux_session(self, choice, sessions=""):
        """Run tmux_session with stand-ins for fzf and tmux; return the tmux calls.

        `sessions` is what `tmux list-sessions` prints. A new session gets id $9.
        """
        bin_dir = self.root / "bin"
        if not bin_dir.exists():
            bin_dir.mkdir()
            for name, body in {
                # Pick the line whose label, the only column fzf would show, matches.
                "fzf": "awk -F'\\t' -v choice=\"$CHOICE\" '$1 == choice'",
                # One call per line, arguments separated by \037: formats hold tabs.
                "tmux": "printf '%s\\037' \"$@\" >> \"$TMUX_LOG\"; echo >> \"$TMUX_LOG\"\n"
                        "case $1 in\n"
                        "  list-sessions) printf '%s' \"$TMUX_SESSIONS\" ;;\n"
                        "  new-session) echo '$9' ;;\n"
                        "esac",
            }.items():
                script = bin_dir / name
                script.write_text("#!/bin/sh\n" + body + "\n")
                script.chmod(0o755)
        log = self.root / "tmux.log"
        log.write_text("")
        env = dict(self.env, PATH=str(bin_dir) + os.pathsep + os.environ["PATH"],
                   TMUX_LOG=str(log), CHOICE=choice, TMUX_SESSIONS=sessions)
        subprocess.run([str(REPO / "scripts/tmux_session")], env=env,
                       capture_output=True, text=True, check=True)
        return [line.split("\037")[:-1] for line in log.read_text().splitlines()]

    def test_tmux_session_is_named_after_the_path_below_dev(self):
        projects = [
            ("github.com/one/repo.name", "src/github.com/one/repo.name"),
            ("github.com/one/repo_name", "src/github.com/one/repo_name"),
            ("github.com/two/repo.name", "src/github.com/two/repo.name"),
            ("github.com/one/repo%2Ename", "src/github.com/one/repo%2Ename"),
            ("gitlab.com/one/repo", "src/gitlab.com/one/repo"),
            ("local/one_shared", "local/one_shared"),
            ("scratch/try out", "scratch/try out"),
        ]
        for _, path in projects:
            self.repo(path)
        for label, path in projects:
            self.assertEqual(self.run_tmux_session(label), [
                ["list-sessions", "-F", "#{session_id}\t#{session_path}\t#{session_name}"],
                ["new-session", "-dP", "-F", "#{session_id}", "-s", path,
                 "-c", str(self.dev / path)],
                ["send-keys", "-t", "$9", "tmux_init", "C-m"],
                ["attach-session", "-t", "$9"],
            ], label)

    def test_tmux_session_reuses_only_the_matching_session(self):
        path, sibling = "src/github.com/one/repo.name", "src/github.com/one/repo_name"
        here, there = str(self.dev / path), str(self.dev / sibling)
        self.repo(path)
        self.repo(sibling)
        # tmux before 3.7 stored both names as src/github_com/one/repo_name.
        legacy = "src/github_com/one/repo_name"
        cases = [
            ("$1\t%s\t%s\n" % (here, path), "$1"),
            ("$1\t%s\t%s\n$3\t%s\t%s\n" % (there, sibling, here, legacy), "$3"),
            ("$2\t%s\t%s\n" % (there, legacy), None),
            ("$2\t%s\t%s\n" % (here, sibling), None),
        ]
        for sessions, expected in cases:
            calls = self.run_tmux_session("github.com/one/repo.name", sessions)
            if expected:
                self.assertEqual(calls[1:], [["attach-session", "-t", expected]], sessions)
            else:
                self.assertEqual(calls[1][:6], ["new-session", "-dP", "-F",
                                                "#{session_id}", "-s", path], sessions)

    def run_d(self, command):
        home = self.root / "home"
        home.mkdir(exist_ok=True)
        env = dict(self.env, HOME=str(home), PATH="/usr/bin:/bin")
        # Stand-in for fzf: record the arguments, pick the first line that
        # contains the query, fail like fzf when nothing matches.
        fzf = ("fzf() { print -r -- \"$*\" >&2; local q=${@[(r)--query=*]#--query=}; "
               "awk -F'\\t' -v q=\"$q\" 'index($1, q) { print; found = 1; exit } "
               "END { exit !found }'; }; ")
        return subprocess.run([
            "/bin/zsh", "-f", "-c",
            'source "$1"; export DEV="$2"; ' + fzf + command + "; pwd -P",
            "zsh", str(REPO / ".zshrc"), str(self.dev),
        ], env=env, capture_output=True, text=True)

    def test_d_enters_the_project_picked_in_fzf(self):
        target = self.repo("src/github.com/planmanager/planfred")
        self.repo("src/github.com/franzgollhammer/dotfiles")
        for command in ("d planfred", "d planmanager/planfred"):
            result = self.run_d(command)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout.strip(), str(target.resolve()), command)
            self.assertIn("--query=" + command[2:], result.stderr)
            # A single match must still be confirmed in the picker.
            self.assertNotIn("--select-1", result.stderr)
        first = self.run_d("d")
        self.assertEqual(first.stdout.strip(),
                         str((self.dev / "src/github.com/franzgollhammer/dotfiles").resolve()))

    def test_d_stays_put_when_nothing_is_picked(self):
        self.repo("src/github.com/planmanager/planfred")
        result = self.run_d("cd /; d missing")
        self.assertEqual(result.stdout.strip(), "/")

    def test_d_dot_goes_to_the_dev_root(self):
        result = self.run_d("d .")
        self.assertEqual(result.stdout.strip(), str(self.dev.resolve()))


if __name__ == "__main__":
    unittest.main()
