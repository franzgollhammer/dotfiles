"""Exercise numbered menus with temporary homes, repositories, and command stubs."""

from pathlib import Path
import subprocess
import tempfile
import unittest

REPO = Path(__file__).resolve().parents[1]


class SelectionHelperTests(unittest.TestCase):
    def setUp(self):
        temp = tempfile.TemporaryDirectory(prefix="dotfiles-menu-tests-")
        self.addCleanup(temp.cleanup)
        self.root = Path(temp.name).resolve()
        self.home = self.root / "home with spaces"
        self.dev = self.home / "dev"
        self.dev.mkdir(parents=True)
        self.bin = self.root / "bin"
        self.bin.mkdir()
        self.log = self.root / "calls"
        self.env = {
            "HOME": str(self.home), "DEV": str(self.dev),
            "PATH": str(self.bin) + ":/usr/bin:/bin", "LC_ALL": "C",
            "CALL_LOG": str(self.log),
            "GIT_CONFIG_NOSYSTEM": "1", "GIT_CONFIG_GLOBAL": "/dev/null",
        }

    def run_command(self, command, text="", cwd=None, **env):
        return subprocess.run(
            command, input=text, cwd=cwd or self.root,
            env=dict(self.env, **env), text=True, capture_output=True,
            check=False, timeout=10,
        )

    def run_helper(self, name, *args, **kwargs):
        return self.run_command([str(REPO / "scripts" / name), *args], **kwargs)

    def run_shell(self, command, **kwargs):
        return self.run_command(
            ["/bin/zsh", "-f", "-c", 'source "$1"; ' + command,
             "zsh", str(REPO / ".zshrc")], **kwargs,
        )

    def assert_success(self, result):
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def recorder(self, path, body=""):
        path.write_text(
            '#!/bin/bash\n# Record arguments for isolated menu checks.\n'
            'printf "%s\\0" "$@" >> "$CALL_LOG"\n'
            'printf "\\n" >> "$CALL_LOG"\n' + body
        )
        path.chmod(0o755)

    def calls(self):
        if not self.log.exists():
            return []
        return [line.split("\0")[:-1] for line in self.log.read_text().splitlines()]

    def git(self, repo, *args):
        result = self.run_command(["git", "-C", str(repo), *args])
        self.assert_success(result)
        return result.stdout.strip()

    def make_repo(self):
        repo = self.root / "repository with spaces"
        repo.mkdir()
        self.git(repo, "init", "-q", "-b", "main")
        self.git(repo, "-c", "user.name=Menu Tests", "-c", "user.email=tests@example.invalid",
                 "commit", "-q", "--allow-empty", "-m", "Initial")
        return repo

    def test_project_navigation_selection_and_direct_argument(self):
        project = self.dev / "project with spaces"
        project.mkdir()
        (self.dev / "not a directory").write_text("skip")
        command = 'd; result=$?; print -r -- "$PWD"; exit "$result"'
        result = self.run_shell(command, text="invalid\n99\n1\n")
        self.assert_success(result)
        self.assertEqual(result.stdout, str(project) + "\n")
        direct = self.run_shell('d "project with spaces" && print -r -- "$PWD"')
        self.assert_success(direct)
        self.assertEqual(direct.stdout, str(project) + "\n")

    def test_editor_receives_selected_project_as_one_argument(self):
        project = self.dev / "project with spaces"
        project.mkdir()
        self.recorder(self.bin / "editor-stub")
        result = self.run_shell('EDITOR=editor-stub; c', text="invalid\n1\n")
        self.assert_success(result)
        self.assertEqual(self.calls(), [[str(project)]])

    def test_project_menus_handle_empty_choices_and_cancel(self):
        self.recorder(self.bin / "editor-stub")
        for populated in (False, True):
            if populated:
                (self.dev / "project").mkdir()
            for function in ("d", "c"):
                with self.subTest(function=function, populated=populated):
                    result = self.run_shell(
                        'EDITOR=editor-stub; ' + function
                        + '; result=$?; print -r -- "$PWD"; exit "$result"',
                        text="invalid\n" if populated else "",
                    )
                    self.assertEqual(result.returncode, 1, result.stderr)
                    self.assertEqual(result.stdout, str(self.root) + "\n")
                    self.assertEqual(self.calls(), [])

    def test_worktree_selection_preserves_spaces_and_newlines(self):
        repo = self.make_repo()
        worktree = self.root / "worktree with spaces\nand a newline"
        self.git(repo, "worktree", "add", "-q", "-b", "feature", str(worktree))
        command = 'wt; result=$?; print -r -- "$PWD"; exit "$result"'
        cancelled = self.run_shell(command, cwd=repo)
        self.assertEqual(cancelled.returncode, 1, cancelled.stderr)
        self.assertEqual(cancelled.stdout, str(repo) + "\n")
        selected = self.run_shell(command, cwd=repo, text="invalid\n2\n")
        self.assert_success(selected)
        self.assertEqual(selected.stdout, str(worktree) + "\n")

    def test_branch_menu_handles_empty_choices_cancel_and_selection(self):
        repo = self.make_repo()
        empty = self.run_helper("b", cwd=repo)
        self.assertEqual(empty.returncode, 1, empty.stderr)
        self.git(repo, "remote", "add", "origin", str(self.root / "unused remote"))
        self.git(repo, "update-ref", "refs/remotes/origin/feature", "HEAD")
        self.git(repo, "symbolic-ref", "refs/remotes/origin/HEAD", "refs/remotes/origin/feature")
        self.assert_success(self.run_helper("b", cwd=repo, text="99\n"))
        self.assertEqual(self.git(repo, "branch", "--show-current"), "main")
        self.assert_success(self.run_helper("b", cwd=repo, text="invalid\n1\n"))
        self.assertEqual(self.git(repo, "branch", "--show-current"), "feature")

    def test_branch_direct_argument_still_switches(self):
        repo = self.make_repo()
        self.git(repo, "branch", "feature")
        self.assert_success(self.run_helper("b", "feature", cwd=repo))
        self.assertEqual(self.git(repo, "branch", "--show-current"), "feature")

    def test_helper_menu_selects_only_executables_and_handles_spaces(self):
        scripts = self.root / "custom scripts"
        scripts.mkdir()
        (scripts / "a nonexecutable file").write_text("skip")
        (scripts / "a directory").mkdir()
        self.recorder(scripts / "helper with spaces", 'printf "ran helper\\n"\n')
        result = self.run_helper("scr", text="invalid\n1\n", SCRIPTS=str(scripts))
        self.assert_success(result)
        self.assertEqual(result.stdout, "ran helper\n")
        self.assertEqual(len(self.calls()), 1)

    def test_helper_menu_handles_empty_choices_and_cancel(self):
        scripts = self.root / "custom scripts"
        scripts.mkdir()
        empty = self.run_helper("scr", SCRIPTS=str(scripts))
        self.assertEqual(empty.returncode, 1, empty.stderr)
        self.recorder(scripts / "helper")
        self.assert_success(self.run_helper("scr", text="99\n", SCRIPTS=str(scripts)))
        self.assertEqual(self.calls(), [])

    def test_session_menu_creates_session_in_selected_project(self):
        project = self.dev / "project with spaces"
        project.mkdir()
        self.recorder(self.bin / "tmux", 'if [ "$1" = has-session ]; then exit 1; fi\n')
        result = self.run_helper("tmux_session", text="invalid\n1\n")
        self.assert_success(result)
        self.assertEqual(self.calls(), [
            ["has-session", "-t", "=project_with_spaces"],
            ["new-session", "-ds", "project_with_spaces", "-c", str(project)],
            ["send-keys", "-t", "=project_with_spaces", "tmux_init", "C-m"],
            ["attach-session", "-t", "=project_with_spaces"],
        ])

    def test_session_menu_handles_empty_choices_and_cancel(self):
        self.recorder(self.bin / "tmux")
        empty = self.run_helper("tmux_session")
        self.assertEqual(empty.returncode, 1, empty.stderr)
        (self.dev / "project").mkdir()
        for text in ("", "99\n"):
            with self.subTest(text=text):
                result = self.run_helper("tmux_session", text=text, SELECTED_DIR="stale")
                self.assert_success(result)
                self.assertEqual(self.calls(), [])


if __name__ == "__main__":
    unittest.main()
