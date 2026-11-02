"""Terminal portability checks using temporary homes and an isolated tmux server."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


REPO = Path(__file__).resolve().parents[1]


class TerminalConfigTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="dotfiles-terminal-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.home = self.root / "home"
        self.home.mkdir()
        self.bin = self.home / ".local/bin"
        self.bin.mkdir(parents=True)
        self.env = {
            "HOME": str(self.home), "PATH": "/usr/bin:/bin",
            "LANG": "C.UTF-8", "TERM": "xterm-256color",
        }

    def run_command(self, *command, expected=0):
        result = subprocess.run(
            command, cwd=self.root, env=self.env, text=True,
            capture_output=True, check=False, timeout=15,
        )
        self.assertEqual(result.returncode, expected, result.stdout + result.stderr)
        self.assertEqual(result.stderr, "")
        return result

    def shell(self, code):
        return self.run_command(
            "/bin/zsh", "-f", "-c", 'source "$1"; ' + code,
            "zsh", str(REPO / ".zshrc"),
        )

    def executable(self, name, body):
        script = self.bin / name
        script.write_text("#!/bin/sh\n" + body + "\n")
        script.chmod(0o755)
        return script

    @unittest.skipUnless(os.uname().sysname == "Linux", "Linux environment")
    def test_linux_paths_and_aliases(self):
        self.env["XDG_DATA_HOME"] = str(self.root / "custom data")
        result = self.shell(
            'print -r -- "$PNPM_HOME"; '
            '(( ${path[(Ie)/opt/homebrew/opt/ruby/bin]} == 0 )) || exit 1; '
            '(( ! ${+aliases[sim]} && ! ${+aliases[bb]} && ! ${+aliases[bbb]} ))'
        )
        self.assertEqual(result.stdout.strip(), str(self.root / "custom data/pnpm"))

    def test_fd_fallback_runs_fdfind(self):
        self.executable("fdfind", 'printf "fdfind:%s\\n" "$1"')
        result = self.shell('eval "fd example"')
        self.assertEqual(result.stdout, "fdfind:example\n")

    def test_real_fd_takes_precedence(self):
        self.executable("fdfind", "exit 1")
        self.executable("fd", 'printf "fd:%s\\n" "$1"')
        result = self.shell('eval "fd example"')
        self.assertEqual(result.stdout, "fd:example\n")

    @unittest.skipUnless(shutil.which("vim"), "vim is required")
    def test_vim_loads_configuration(self):
        self.run_command("vim", "-N", "-i", "NONE", "-n", "-es", "-u", str(REPO / ".vimrc"), "+qa!")
        self.assertTrue((self.home / ".vim/undodir").is_dir())

    @unittest.skipUnless(shutil.which("tmux"), "tmux is required")
    def test_tmux_loads_and_reloads_configuration(self):
        socket = str(self.root / "tmux.sock")
        tmux = [shutil.which("tmux"), "-S", socket]
        self.addCleanup(subprocess.run, tmux + ["kill-server"], env=self.env, capture_output=True)
        # Start without config, then source explicitly: startup can hide config errors.
        self.run_command(*tmux, "-f", "/dev/null", "new-session", "-d", "-s", "check", "/bin/sh")
        for _ in range(2):
            self.run_command(*tmux, "source-file", str(REPO / ".tmux.conf"))
        result = self.run_command(*tmux, "show-options", "-gv", "set-clipboard")
        self.assertEqual(result.stdout.strip(), "on")
        result = self.run_command(*tmux, "show-options", "-gqv", "allow-passthrough")
        self.assertIn(result.stdout.strip(), ("", "on"))

    def test_default_tmux_init_without_fastfetch(self):
        self.executable("tmux", "exit 0")
        self.env["PATH"] = str(self.bin)  # Only the stub; fastfetch is absent.
        self.run_command("/bin/bash", str(REPO / ".tmux_init"))

    def test_default_tmux_init_with_fastfetch(self):
        self.executable("tmux", "exit 0")
        self.executable("fastfetch", "printf 'machine info\\n'")
        self.env["PATH"] = str(self.bin)
        result = self.run_command("/bin/bash", str(REPO / ".tmux_init"))
        self.assertEqual(result.stdout, "machine info\n")


if __name__ == "__main__":
    unittest.main()
