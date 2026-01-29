# Dotfiles

Personal macOS dev environment config.

## Quick Setup

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone repo
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dev/dotfiles

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
| Terminals | `ghostty/`, `warp/` |
| Packages | `brew/formula.txt`, `brew/cask.txt` |

## Scripts

Located in `scripts/`, added to PATH via `.zshrc`:

| Script | Description |
|--------|-------------|
| `build_symlinks` | Link dotfiles to home dir |
| `tmux_session` | Create/attach tmux sessions |
| `lazy_nvm` | Lazy-load nvm for faster shell startup |
| `brew_update` | Update brew + export package lists |
| `cursor_export_extensions` | Export Cursor extensions |
| `kill_node` / `kill_mongo` | Kill processes |

## Customization

Copy example files and modify:
```bash
cp example.env .env
cp example.tmux_init .tmux_init
```
