# Dotfiles

Personal macOS dev environment config.

## Quick Setup

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone repo
git clone https://github.com/franzgollhammer/dotfiles.git ~/dev/dotfiles

# 3. Create symlinks
./scripts/build_symlinks

# 4. Install packages
xargs brew install < brew/formula.txt
xargs brew install --cask < brew/cask.txt
```

## What's Included

| Category | Files |
|----------|-------|
| Shell | `.zshrc`, `starship.toml` |
| Tmux | `.tmux.conf`, `.tmux_init` |
| Herdr | `herdr/config.toml` |
| Editors | `nvim/`, `vscode/`, `cursor/`, `zed/` |
| Terminals | `ghostty/`, `wezterm/` (config + ported themes), `kitty/` (config + ported themes + icon + quick access terminal), `warp/` (settings, keybindings, themes, launch configs), `iterm/` (themes) |
| Tools | `fzf/` (theme), `raycast/` (script commands) |
| Packages | `brew/formula.txt`, `brew/cask.txt` |

## Scripts

Located in `scripts/`, added to PATH via `.zshrc`:

| Script | Description |
|--------|-------------|
| `agent-notify` | Native terminal notification when a coding agent needs input or finishes (Ghostty/WezTerm via OSC 777, kitty via OSC 99) |
| `build_symlinks` | Link dotfiles to home dir |
| `brew_update` | Update brew + export package lists |
| `install_wezterm_icon` | Swap WezTerm.app's icon for `wezterm/icon/wezterm.icns` (rerun after WezTerm updates) |
| `install_kitty_icon` | Point kitty at `kitty/icon/kitty-{dark,light}.icns` and flush the Dock cache (`--bundle` to patch kitty.app too) |
| `b` / `list_branches` | Browse branches (fzf picker / pretty list) |
| `gm` (repo root) | fzf-pick a branch and merge it |
| `tmux_session`, `tmux_init` | Create/attach tmux sessions, run `.tmux_init` |
| `code_*`, `cursor_*` | Export/install/uninstall VS Code and Cursor extensions |
| `lazy_nvm` | Lazy-load nvm for faster shell startup |
| `goentr`, `goentrtest` | Rerun `go run` / `go test` on file changes (entr) |
| `pf-init` | Open Planfred dev tabs in Ghostty |
| `scr` | fzf-pick a script from `$SCRIPTS` and run it |
| `set_default_app` | Set Cursor as default app for common file types (duti) |
| `ts` / `isosec` | Copy date / UTC timestamp to clipboard |
| `kill_node`, `kill_mongo`, `kill_all` | Kill processes |
| `mongodb_export` | mongoexport/mongoimport reference |
| `vm` | Start VMware VM from `$vmFile` |

Worktrees are handled by three zsh functions in `.zshrc`, not by scripts —
they have to `cd` the calling shell, which a script cannot do:

| Function | Description |
|----------|-------------|
| `wt [query]` | Jump to any worktree git knows |
| `wta [branch]` | Add one under `$GIT_WORKTREE_DIR/<repo>/<branch>` and cd in |
| `wtr` | Remove one (never the main worktree) |

## Customization

Copy example files and modify:
```bash
cp example.env .env
cp example.tmux_init .tmux_init
```
