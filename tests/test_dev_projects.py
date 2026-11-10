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
            "franzgollhammer/ucsl-app\tsrc/github.com/franzgollhammer/ucsl-app",
            "gitlab.com/group/tool\tsrc/gitlab.com/group/tool",
            "local/notes\tlocal/notes",
            "planmanager/planfred\tsrc/github.com/planmanager/planfred",
            "scratch/try out\tscratch/try out",
        ])

    def test_empty_dev_root_lists_nothing(self):
        self.assertEqual(self.run_list(), [])

    def test_tmux_receives_canonical_directory_and_workspace_session_name(self):
        projects = [
            ("one/shared-repository-long-name", "src/github.com/one/shared-repository-long-name",
             "one_shared-repository-long-name"),
            ("two/shared-repository-long-name", "src/github.com/two/shared-repository-long-name",
             "two_shared-repository-long-name"),
            ("local/one_shared", "local/one_shared", "local_one%5Fshared"),
            ("one/repo.name", "src/github.com/one/repo.name", "one_repo%2Ename"),
            ("one/repo_name", "src/github.com/one/repo_name", "one_repo%5Fname"),
            ("one/repo%2Ename", "src/github.com/one/repo%2Ename", "one_repo%252Ename"),
            ("gitlab.com/one/repo", "src/gitlab.com/one/repo", "gitlab%2Ecom_one_repo"),
        ]
        for _, path, _ in projects:
            self.repo(path)
        bin_dir = self.root / "bin"
        bin_dir.mkdir()
        log = self.root / "tmux.log"
        for name, body in {
            # Pick the line whose label, the only column fzf would show, matches.
            "fzf": "awk -F'\\t' -v choice=\"$CHOICE\" '$1 == choice'",
            "tmux": 'printf "%s\\n" "$@" >> "$TMUX_LOG"; '
                    '[ "$1" != has-session ]',
        }.items():
            script = bin_dir / name
            script.write_text("#!/bin/sh\n" + body + "\n")
            script.chmod(0o755)
        self.env.update(PATH=str(bin_dir) + os.pathsep + os.environ["PATH"],
                        TMUX_LOG=str(log))
        for choice, path, session in projects:
            self.env["CHOICE"] = choice
            log.write_text("")
            subprocess.run([str(REPO / "scripts/tmux_session")], env=self.env,
                           capture_output=True, text=True, check=True)
            args = log.read_text().splitlines()
            self.assertIn(str(self.dev / path), args)
            self.assertIn(session, args)

    def run_d(self, command):
        home = self.root / "home"
        home.mkdir(exist_ok=True)
        env = dict(self.env, HOME=str(home), PATH="/usr/bin:/bin")
        return subprocess.run([
            "/bin/zsh", "-f", "-c",
            'source "$1"; export DEV="$2"; '
            "fzf() { awk -F'\\t' '$1 == \"planmanager/planfred\"'; }; "
            + command + "; pwd -P",
            "zsh", str(REPO / ".zshrc"), str(self.dev),
        ], env=env, capture_output=True, text=True)

    def test_d_enters_repository_by_picker_label_and_path(self):
        target = self.repo("src/github.com/planmanager/planfred")
        for command in ("d", "d planmanager/planfred",
                        "d src/github.com/planmanager/planfred"):
            result = self.run_d(command)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout.strip(), str(target.resolve()), command)

    def test_d_rejects_unknown_project_without_moving(self):
        self.repo("src/github.com/planmanager/planfred")
        result = self.run_d("cd /; d planmanager/missing")
        self.assertIn("d: no project planmanager/missing", result.stderr)
        self.assertEqual(result.stdout.strip(), "/")


if __name__ == "__main__":
    unittest.main()
