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

    def test_workspace_repos_without_compatibility_links_or_worktrees(self):
        target = self.repo("planmanager/planfred")
        self.repo("franzgollhammer/ucsl-app")
        self.repo("local/scratch")
        self.repo("legacy-repo")
        self.repo("worktrees/project/feature")
        (self.dev / "playground").mkdir()
        (self.dev / "planfred-app").symlink_to(target, target_is_directory=True)
        result = subprocess.run([str(REPO / "scripts/dev_projects")],
                                env=self.env, capture_output=True, text=True, check=True)
        self.assertEqual(result.stdout.splitlines(), [
            "franzgollhammer/ucsl-app", "legacy-repo", "local/scratch",
            "planmanager/planfred", "playground",
        ])

    def test_tmux_receives_canonical_directory_and_workspace_session_name(self):
        projects = [
            ("one/shared-repository-long-name", "one_shared-repository-long-name"),
            ("two/shared-repository-long-name", "two_shared-repository-long-name"),
            ("one_shared-repository-long-name", "one%5Fshared-repository-long-name"),
            ("one/repo.name", "one_repo%2Ename"),
            ("one/repo_name", "one_repo%5Fname"),
            ("one/repo%2Ename", "one_repo%252Ename"),
        ]
        for choice, _ in projects:
            self.repo(choice)
        bin_dir = self.root / "bin"
        bin_dir.mkdir()
        log = self.root / "tmux.log"
        for name, body in {
            "fzf": 'cat >/dev/null; printf "%s\\n" "$CHOICE"',
            "tmux": 'printf "%s\\n" "$@" >> "$TMUX_LOG"; '
                    '[ "$1" != has-session ]',
        }.items():
            script = bin_dir / name
            script.write_text("#!/bin/sh\n" + body + "\n")
            script.chmod(0o755)
        self.env.update(PATH=str(bin_dir) + os.pathsep + os.environ["PATH"],
                        TMUX_LOG=str(log))
        for choice, session in projects:
            self.env["CHOICE"] = choice
            subprocess.run([str(REPO / "scripts/tmux_session")], env=self.env,
                           capture_output=True, text=True, check=True)
            args = log.read_text().splitlines()
            self.assertIn(str(self.dev / choice), args)
            self.assertIn(session, args)

    def test_d_picker_enters_workspace_repository(self):
        target = self.repo("planmanager/planfred")
        home = self.root / "home"
        home.mkdir()
        env = dict(self.env, HOME=str(home), PATH="/usr/bin:/bin")
        result = subprocess.run([
            "/bin/zsh", "-f", "-c",
            'source "$1"; export DEV="$2"; '
            'fzf() { cat >/dev/null; print -r -- planmanager/planfred; }; d; pwd -P',
            "zsh", str(REPO / ".zshrc"), str(self.dev),
        ], env=env, capture_output=True, text=True, check=True)
        self.assertEqual(result.stdout.strip(), str(target.resolve()))


if __name__ == "__main__":
    unittest.main()
