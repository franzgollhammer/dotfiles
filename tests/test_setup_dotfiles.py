"""Setup safety checks. Run the full suite in GitHub Actions, not on a live home."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

REPO = Path(__file__).resolve().parents[1]


class SetupDotfilesTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="dotfiles-tests-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.target = self.root / "home with spaces"
        self.env = {"HOME": str(self.target), "PATH": "/usr/bin:/bin", "LC_ALL": "C"}

    def setup_command(self, *args, expected=0, repo=REPO, home_option=True, script=None):
        command = [str(script or repo / "scripts/setup_dotfiles")]
        if home_option:
            command += ["--home", str(self.target)]
        result = subprocess.run(
            command + list(args), cwd=self.root, env=self.env,
            text=True, capture_output=True, check=False,
        )
        self.assertEqual(result.returncode, expected, result.stdout + result.stderr)
        return result

    def expected_links(self, config=None, repo=REPO):
        config = config or self.target / ".config"
        pairs = {
            self.target / ".zshrc": repo / ".zshrc",
            self.target / ".tmux.conf": repo / ".tmux.conf",
            self.target / ".warp": repo / "warp",
            config / "starship.toml": repo / "starship.toml",
        }
        for app in ("nvim", "ghostty"):
            pairs[config / app] = repo / app
        for name in ("keymap.json", "settings.json"):
            pairs[config / "zed" / name] = repo / "zed" / name
        for name in ("settings.json", "keybindings.json"):
            pairs[self.target / "Library/Application Support/Code/User" / name] = repo / "vscode" / name
        return pairs

    def minimal_links(self, config=None, repo=REPO):
        config = config or self.target / ".config"
        return {
            self.target / ".zshrc": repo / ".zshrc",
            self.target / ".tmux.conf": repo / ".tmux.conf",
            config / "starship.toml": repo / "starship.toml",
            config / "nvim": repo / "nvim",
        }

    def assert_links(self, **kwargs):
        for target, source in self.expected_links(**kwargs).items():
            self.assertTrue(target.is_symlink(), str(target))
            self.assertEqual(target.resolve(), source.resolve())
        self.assertFalse((self.target / ".config/herdr").exists())
        self.assertFalse((self.target / ".tmux_init").exists())

    def test_dry_run_does_not_create_home(self):
        self.setup_command("--dry-run")
        self.assertFalse(self.target.exists())

    def test_install_and_rerun_preserve_links_and_local_state(self):
        local_theme = self.target / ".config/zed/themes/personal.json"
        local_theme.parent.mkdir(parents=True)
        local_theme.write_text("personal theme")
        self.setup_command()
        self.assert_links()
        initial = {path: path.lstat().st_ino for path in self.expected_links()}
        self.setup_command("--backup")
        self.assertEqual(initial, {path: path.lstat().st_ino for path in initial})
        self.assertEqual(local_theme.read_text(), "personal theme")
        self.assertFalse(list(self.target.rglob("*.dotfiles-backup.*")))

    def test_minimal_profile_links_terminal_configuration_only(self):
        self.setup_command("--profile", "minimal")
        for target, source in self.minimal_links().items():
            self.assertTrue(target.is_symlink(), str(target))
            self.assertEqual(target.resolve(), source.resolve())
        for path in (
            self.target / ".warp",
            self.target / ".config/ghostty",
            self.target / ".config/zed",
            self.target / "Library/Application Support/Code/User/settings.json",
        ):
            self.assertFalse(path.exists() or path.is_symlink(), str(path))

    def test_full_profile_completes_an_existing_minimal_installation(self):
        self.setup_command("--profile", "minimal")
        initial = {path: path.lstat().st_ino for path in self.minimal_links()}
        self.setup_command("--profile", "full")
        self.assert_links()
        self.assertEqual(initial, {path: path.lstat().st_ino for path in initial})

    def test_conflicts_abort_before_creating_any_links(self):
        # Use a late target to catch scripts that only check conflicts as they write.
        conflict = self.target / "Library/Application Support/Code/User/settings.json"
        conflict.parent.mkdir(parents=True)
        conflict.write_text("original settings")
        self.setup_command(expected=1)
        self.assertEqual(conflict.read_text(), "original settings")
        self.assertFalse((self.target / ".zshrc").exists())
        self.assertFalse((self.target / ".config").exists())

    def test_backup_preserves_file_directory_and_dangling_symlink(self):
        self.target.mkdir()
        rc = self.target / ".zshrc"
        rc.write_text("original shell config")
        nvim = self.target / ".config/nvim"
        nvim.mkdir(parents=True)
        (nvim / "local.lua").write_text("personal editor config")
        tmux = self.target / ".tmux.conf"
        tmux.symlink_to("missing-config")
        self.setup_command("--backup")
        self.assert_links()
        backups = list(self.target.glob(".zshrc.dotfiles-backup.*"))
        self.assertEqual(len(backups), 1)
        self.assertEqual(backups[0].read_text(), "original shell config")
        editor_backups = list(nvim.parent.glob("nvim.dotfiles-backup.*"))
        self.assertEqual(len(editor_backups), 1)
        self.assertEqual((editor_backups[0] / "local.lua").read_text(), "personal editor config")
        link_backups = list(self.target.glob(".tmux.conf.dotfiles-backup.*"))
        self.assertEqual(len(link_backups), 1)
        self.assertEqual(os.readlink(link_backups[0]), "missing-config")

    def test_dry_run_with_backup_preserves_conflicts(self):
        self.target.mkdir()
        (self.target / ".zshrc").write_text("keep me")
        self.setup_command("--dry-run", "--backup")
        self.assertEqual((self.target / ".zshrc").read_text(), "keep me")
        self.assertEqual([p.name for p in self.target.iterdir()], [".zshrc"])

    def test_wrong_symlink_is_preserved_without_backup(self):
        self.target.mkdir()
        existing = self.root / "existing config"
        existing.write_text("keep target")
        (self.target / ".zshrc").symlink_to(existing)
        self.setup_command(expected=1)
        self.assertEqual(os.readlink(self.target / ".zshrc"), str(existing))
        self.assertEqual(existing.read_text(), "keep target")

    def test_dangling_symlink_is_a_conflict(self):
        self.target.mkdir()
        (self.target / ".tmux.conf").symlink_to("missing")
        self.setup_command(expected=1)
        self.assertEqual(os.readlink(self.target / ".tmux.conf"), "missing")
        self.assertFalse((self.target / ".zshrc").exists())

    def test_parent_file_aborts_even_with_backup(self):
        self.target.mkdir()
        (self.target / ".config").write_text("not a directory")
        self.setup_command("--backup", expected=1)
        self.assertEqual((self.target / ".config").read_text(), "not a directory")
        self.assertFalse((self.target / ".zshrc").exists())

    def test_dangling_parent_aborts_even_with_backup(self):
        self.target.mkdir()
        (self.target / ".config").symlink_to("missing")
        self.setup_command("--backup", expected=1)
        self.assertEqual(os.readlink(self.target / ".config"), "missing")
        self.assertFalse((self.target / ".zshrc").exists())

    def test_default_home_honors_xdg_config_home(self):
        config = self.root / "custom config"
        self.env["XDG_CONFIG_HOME"] = str(config)
        self.setup_command(home_option=False)
        self.assert_links(config=config)
        self.assertFalse((self.target / ".config").exists())

    def test_home_option_does_not_touch_inherited_xdg_directory(self):
        other_config = self.root / "real config"
        self.env["XDG_CONFIG_HOME"] = str(other_config)
        self.setup_command()
        self.assert_links()
        self.assertFalse(other_config.exists())

    def test_checkout_with_spaces_ignores_stale_dotfiles_env(self):
        checkout = self.root / "checkout with spaces"
        shutil.copytree(REPO, checkout, ignore=shutil.ignore_patterns(".git", ".claude", "__pycache__"))
        self.env["DOTFILES"] = str(self.root / "wrong checkout")
        self.setup_command(repo=checkout)
        self.assert_links(repo=checkout)

    def test_missing_source_fails_without_creating_home(self):
        checkout = self.root / "incomplete checkout"
        shutil.copytree(REPO, checkout, ignore=shutil.ignore_patterns(".git", ".claude", "__pycache__"))
        (checkout / "starship.toml").unlink()
        self.setup_command(repo=checkout, expected=1)
        self.assertFalse(self.target.exists())

    def test_symlinked_entry_point(self):
        entry = self.root / "setup"
        entry.symlink_to(REPO / "scripts/setup_dotfiles")
        self.setup_command(script=entry)
        self.assert_links()

    def test_help_and_invalid_arguments_do_not_write(self):
        self.setup_command("--help")
        self.setup_command("--unknown", expected=2)
        self.setup_command("--home", expected=2)
        self.setup_command("--home", "relative/path", expected=2)
        self.setup_command("--profile", expected=2)
        self.setup_command("--profile", "desktop", expected=2)
        self.env["XDG_CONFIG_HOME"] = "relative/config"
        self.setup_command(home_option=False, expected=2)
        self.assertFalse(self.target.exists())

    def test_shell_resolves_checkout_without_optional_dependencies(self):
        self.setup_command()
        self.env["XDG_CONFIG_HOME"] = str(self.root / "custom config")
        result = subprocess.run(
            ["/bin/zsh", "-f", "-c", 'source "$1"; printf "%s\\n" "$DOTFILES" "$XDG_CONFIG_HOME"',
             "zsh", str(self.target / ".zshrc")],
            env=self.env, text=True, capture_output=True, check=False,
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stderr, "")
        self.assertEqual(result.stdout.splitlines(), [str(REPO), self.env["XDG_CONFIG_HOME"]])


if __name__ == "__main__":
    unittest.main()
