# Dotfiles

Personal macOS development environment: zsh, Starship, tmux, Neovim, editors,
terminal configurations, and helper scripts. Some paths and commands assume
macOS; this is not a portable Linux workstation installer.

## Setup

Install Xcode Command Line Tools (`xcode-select --install`) and
[Homebrew](https://docs.brew.sh/Installation), following its shell PATH instructions.
Then clone into a permanent location:

```sh
git clone https://github.com/franzgollhammer/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles

# Preview every link before changing your home directory.
./scripts/setup_dotfiles --dry-run

# Install when destinations are empty or already point to this checkout.
./scripts/setup_dotfiles
```

Existing files, directories, or different symlinks cause the entire preflight to
fail without changes. To preserve them as adjacent `.dotfiles-backup.*` files
and install the links, run:

```sh
./scripts/setup_dotfiles --dry-run --backup
./scripts/setup_dotfiles --backup
```

Repeated runs leave correct links alone. Backups are never intentionally
reused or removed. To restore one, remove only the installed symlink at its
original path, then move the corresponding backup back into place. An I/O error
during installation can leave earlier links installed; fix the cause and rerun.

The script finds the checkout from its own location, so it works from any
working directory and ignores a stale `DOTFILES` environment variable. Links
point to that checkout: keep it in place, and avoid installing from a temporary
worktree you intend to delete. After loading `.zshrc`, invoke `setup_dotfiles`
from any directory; it is the single entry point for synchronizing these links.

By default, config links use `XDG_CONFIG_HOME`, falling back to `~/.config`.
To inspect or install into an isolated destination:

```sh
./scripts/setup_dotfiles --home /tmp/dotfiles-demo --dry-run
./scripts/setup_dotfiles --home /tmp/dotfiles-demo
```

`--home` must be absolute and uses `<home>/.config`, ignoring `XDG_CONFIG_HOME`.
The linker does not install packages, create secrets, replace the login shell,
patch application icons, or change system preferences.

## Shell and application prerequisites

Install the tools you use. A useful starting set for this configuration is:

```sh
brew install starship fzf tmux neovim ripgrep fd lazygit fastfetch cmatrix
brew install --cask font-fira-code-nerd-font font-jetbrains-mono-nerd-font font-hack-nerd-font
```

The shell uses [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh#manual-installation)
and its fzf plugin, with Starship providing the prompt. If these directories do
not already exist, install Oh My Zsh and the optional
[zsh-autosuggestions plugin](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md):

```sh
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

Missing Oh My Zsh, autosuggestions, or Starship do not stop shell startup.
Install Node.js separately if needed; `.zshrc` loads nvm when `~/.nvm/nvm.sh`
exists. Neovim requires 0.11+ and downloads plugins on first launch; its language
servers and parsers also need their respective runtimes/build tools.

`brew/formula.txt` and `brew/cask.txt` are machine inventory snapshots, including
transitive dependencies and potentially retired or renamed packages. Review
those lists instead of treating them as a guaranteed fresh-machine install
manifest. `brew_update` upgrades installed packages and refreshes both lists.

## Managed links

Paths below use the default `~/.config` location unless stated otherwise.

| Source | Destination |
| --- | --- |
| `.zshrc`, `.tmux.conf` | Same filenames in `~` |
| `starship.toml` | `~/.config/starship.toml` |
| `nvim/`, `ghostty/`, `wezterm/` | Matching directories in `~/.config/` |
| `warp/` | `~/.warp` |
| `zed/keymap.json`, `zed/settings.json` | Matching files in `~/.config/zed/` |
| `kitty/*.conf`, `kitty/themes/*.conf` | Matching files under `~/.config/kitty/` |
| `kitty/icon/kitty-dark.icns` | `~/.config/kitty/kitty.app.icns` |
| `vscode/settings.json`, `vscode/keybindings.json` | Matching files in `~/Library/Application Support/Code/User/` |

Kitty, Zed, and VS Code are linked file by file so unrelated local settings,
themes, and state survive. Whole-directory links for the other applications mean
changes within those directories can affect the checkout; inspect `git status`
before committing. Warp launch configurations contain personal project paths
under `/Users/fg/dev`; adapt them before using them on another machine.

Additional files are opt-in:

- `iterm/themes/`: import the `.itermcolors` presets in iTerm2.
- `fzf/steel-dark.sh`: source it after Oh My Zsh to use the steel palette.
- `vscode/vscode-extensions.txt` and `cursor/cursor-extensions.txt`: separate
  extension inventories. With each editor's CLI installed, use
  `xargs -n 1 code --install-extension < vscode/vscode-extensions.txt` or
  `xargs -n 1 cursor --install-extension < cursor/cursor-extensions.txt`.
- `ghostty/icons/`, `kitty/icon/`, `wezterm/icon/`: optional app icons.

## Local customization

Copy the environment example only when `.env` does not already exist:

```sh
cp -n example.env .env
```

`.zshrc` loads and exports this checkout's `.env`; keep credentials there rather
than in tracked files. `.env`, `.env.*`, logs, and setup backups are ignored.
Opening a new shell after setup sets `DOTFILES` to the symlinked checkout and
adds its `scripts/` directory to `PATH`.

For tmux, `tmux_init` uses the first executable file in this order:
`./.tmux_init`, `~/.tmux_init`, then `$DOTFILES/.tmux_init`. Keep the tracked
fallback intact. Copy `example.tmux_init` into a project's `.tmux_init` (or
`~/.tmux_init`), adapt the commands, and run `chmod +x` on the copy.

## Helpers

Commands in `scripts/` become available after loading `.zshrc`.

| Command | Purpose |
| --- | --- |
| `setup_dotfiles` | Preview or create configuration links |
| `brew_update` | Update Homebrew packages and export inventories |
| `agent-notify` | Terminal notifications for agent hooks; see `agent-notify --help` |
| `b`, `list_branches` | Pick/switch branches or list them with commit metadata |
| `tmux_session`, `tmux_init` | Pick a project, attach/create a session, run its init file |
| `scr` | Pick and execute a helper with fzf |
| `goentr`, `goentrtest` | Rerun `go run .` or `go test .` using entr |
| `ts`, `isosec` | Copy a date or compact UTC timestamp to the macOS clipboard |
| `kill_node`, `kill_mongo`, `kill_all` | Stop the corresponding development processes |
| `set_default_app` | Associate common source-file extensions with Cursor using duti |
| `vm` | Control a VMware VM; requires vmrun and the `vmFile` environment variable |
| `install_kitty_icon`, `install_wezterm_icon` | Apply optional macOS icons; these can modify app bundles/caches and restart Dock or Finder |

Worktree navigation lives in `.zshrc`: `wt` picks a worktree of the current
repository; `wtr` picks worktrees to remove and offers branch deletion; `wta` is
an alias for `git worktree add` and takes ordinary Git arguments. The `WT`
environment variable points to `~/dev/worktrees`.

## Validation

The `Dotfiles checks` GitHub Actions workflow runs shell syntax checks,
ShellCheck on the maintained setup/helpers, and the full automated safety suite
on macOS and Linux. Run the full suite through GitHub Actions, not locally.
For local edits, use narrow checks such as:

```sh
bash -n scripts/setup_dotfiles
shellcheck scripts/setup_dotfiles
zsh -n .zshrc
./scripts/setup_dotfiles --home /tmp/dotfiles-preview --dry-run
git diff --check
```

The safety suite exercises temporary destinations, reruns, conflicts, backups,
custom paths, and missing sources. It does not launch GUI applications, install
plugins/packages, or exercise the live home directory.
