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
| Editors | `nvim/`, `vscode/`, `cursor/`, `zed/` |
| Terminals | `ghostty/`, `warp/` (settings, keybindings, themes, launch configs), `iterm/` (themes) |
| Tools | `fzf/` (theme) |
| Packages | `brew/formula.txt`, `brew/cask.txt` |

## Scripts

Located in `scripts/`, added to PATH via `.zshrc`:

| Script | Description |
|--------|-------------|
| `build_symlinks` | Link dotfiles to home dir |
| `brew_update` | Update brew + export package lists |
| `b` / `list_branches` | Browse branches (fzf picker / pretty list) |
| `gm` (repo root) | fzf-pick a branch and merge it |
| `wt` / `tmux_worktree` | fzf worktree picker / tmux sessionizer for worktrees |
| `tmux_session`, `tmux_init` | Create/attach tmux sessions, run `.tmux_init` |
| `tmux_list`, `tmux_cleanup`, `tmux_rename`, `tmux_quick_window` | Manage tmux sessions/windows |
| `zoxide_tmux_session`, `zoxide_tmux_session_find` | Jump to a zoxide dir as a tmux session |
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

## Customization

Copy example files and modify:
```bash
cp example.env .env
cp example.tmux_init .tmux_init
```
