# Dotfiles

Personal macOS development environment: zsh, Starship, tmux, Vim,
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

# On the personal Mac, also link Ghostty and Warp.
./scripts/setup_dotfiles --profile full --dry-run
./scripts/setup_dotfiles --profile full
```

Existing files, directories, or different symlinks cause the entire preflight to
fail without changes. To preserve them as adjacent `.dotfiles-backup.*` files
and install the links, run:

```sh
./scripts/setup_dotfiles --dry-run --backup
./scripts/setup_dotfiles --backup
```

To discard conflicting files and symlinks instead, without a backup, use
`--force`. It never deletes directories: a conflicting directory such as
`~/.config/ghostty` still aborts the run and needs `--backup`. `--force` and
`--backup` cannot be combined.

```sh
./scripts/setup_dotfiles --dry-run --force
./scripts/setup_dotfiles --force
```

Two profiles select how much is linked. `--profile minimal` is the default and
installs only the terminal set — `.zshrc`, `.tmux.conf`, `.vimrc`, and
`starship.toml` — which is what a machine reached over SSH needs.
`--profile full` installs everything below, including graphical application
configuration. Both profiles share the same preflight, backup, and rerun
behavior, and running the full profile later on a minimal machine adds the
remaining links without touching the existing ones.

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

## Remote machines over SSH

On a remote Mac (for example a Mac mini used only through `ssh` and tmux),
install the terminal tools and the minimal profile. Nothing here needs a
graphical session, and the linker leaves the machine's own application settings
untouched:

```sh
brew install starship tmux ripgrep fd lazygit

# Oh My Zsh with the autosuggestions plugin; the prompt comes from Starship.
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

git clone https://github.com/franzgollhammer/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./scripts/setup_dotfiles --profile minimal --dry-run
./scripts/setup_dotfiles --profile minimal
```

`.zshrc` sets `EDITOR` and `VISUAL` to `vim` locally and over SSH, so
`c`, `dot`, and `play` open a terminal editor. The `sim` alias for the local
Xcode Simulator stays defined but has nothing to open there. `.env` is
optional: create it only for credentials the remote machine actually uses. tmux
copies with `pbcopy`, which reaches the clipboard of the remote machine, not the
one in front of you; use your terminal's own copy mode for that.

## Shell and application prerequisites

Install the tools you use. A useful starting set for this configuration is:

```sh
brew install starship tmux ripgrep fd lazygit fastfetch cmatrix
brew install --cask font-fira-code-nerd-font font-jetbrains-mono-nerd-font font-hack-nerd-font
```

The shell uses [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh#manual-installation)
with Starship providing the prompt. If these directories do not already exist,
install Oh My Zsh and the optional
[zsh-autosuggestions plugin](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md):

```sh
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

Missing Oh My Zsh, autosuggestions, or Starship do not stop shell startup.
Install Node.js separately if needed; `.zshrc` loads nvm when `~/.nvm/nvm.sh`
exists. `.vimrc` targets the Vim 9 that ships with macOS and uses no plugins;
`:grep` uses ripgrep when it is installed.

`brew/formula.txt` and `brew/cask.txt` are machine inventory snapshots, including
transitive dependencies and potentially retired or renamed packages. Review
those lists instead of treating them as a guaranteed fresh-machine install
manifest. `brew_update` upgrades installed packages and refreshes both lists.

## Managed links

Paths below use the default `~/.config` location unless stated otherwise.

| Source | Destination | Profile |
| --- | --- | --- |
| `.zshrc`, `.tmux.conf`, `.vimrc` | Same filenames in `~` | minimal |
| `starship.toml` | `~/.config/starship.toml` | minimal |
| `ghostty/` | `~/.config/ghostty` | full |
| `warp/` | `~/.warp` | full |

Whole-directory links for Ghostty and Warp mean
changes within those directories can affect the checkout; inspect `git status`
before committing. Warp launch configurations contain personal project paths
under `/Users/fg/dev`; adapt them before using them on another machine.

Additional files are opt-in:

- `iterm/themes/`: import the `.itermcolors` presets in iTerm2.
- `ghostty/icons/`: optional app icons.

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

### Agent notifications

Use the agents' built-in terminal notifications. Claude Code uses its default
notification channel when `preferredNotifChannel` is unset. Codex TUI
notifications default to enabled, with `notification_method = "auto"` and
`notification_condition = "unfocused"`. Leave these notification overrides unset
to follow each agent's defaults. See the
[Claude Code terminal guide](https://code.claude.com/docs/en/terminal-config)
and the [OpenAI Docs configuration reference](https://developers.openai.com/codex/config-reference/).

Agent settings live outside this repository and are not managed by
`setup_dotfiles`. If migrating from the retired `agent-notify` helper, remove
only its commands from `~/.claude/settings.json` hooks and
`~/.codex/hooks.json`, and remove its callback from `notify` in
`~/.codex/config.toml`. Preserve unrelated hooks and application integrations;
if `notify` is a computer-use wrapper, remove only the `--previous-notify`
argument and its associated custom command. Restart existing agent sessions to
ensure cached hooks are refreshed. Deleting the helper alone does not update
local settings. For OpenCode, move
`~/.config/opencode/plugins/agent-notify.js` outside the plugin directory;
local plugins there load automatically at startup. See the
[OpenCode plugin guide](https://opencode.ai/v2/docs/plugins).

The existing Ghostty notification settings and tmux bell/passthrough settings
support native notifications. Actual banners depend on terminal support, focus,
and macOS notification permissions.

## Helpers

Commands in `scripts/` become available after loading `.zshrc`.

| Command | Purpose |
| --- | --- |
| `setup_dotfiles` | Preview or create configuration links (`--profile full` adds graphical applications) |
| `brew_update` | Update Homebrew packages and export inventories |
| `b`, `list_branches` | Pick/switch branches or list them with commit metadata |
| `tmux_session`, `tmux_init` | Pick a project, attach/create a session, run its init file |
| `tmux_pr_title` | Rename the tmux window to the worktree branch and PR number (requires gh) |
| `scr` | Pick and execute a helper from a numbered menu |
| `goentr`, `goentrtest` | Rerun `go run .` or `go test .` using entr |
| `ts`, `isosec` | Copy a date or compact UTC timestamp to the macOS clipboard |
| `kill_node`, `kill_mongo`, `kill_all` | Stop the corresponding development processes |
| `vm` | Control a VMware VM; requires vmrun and the `vmFile` environment variable |

`b`, `scr`, and `tmux_session` use numbered menus. The shell functions `d` and `c`
also show a project menu when called without an argument. Enter a number to
select an item, or press Ctrl-D to cancel.

Worktree navigation lives in `.zshrc`: `wt` picks a worktree of the current
repository from a numbered menu; `wtr` picks worktrees to remove and offers
branch deletion; `wta` is an alias for `git worktree add` and takes ordinary Git
arguments. The `WT` environment variable points to `~/dev/worktrees`.

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
./scripts/setup_dotfiles --home /tmp/dotfiles-preview --profile full --dry-run
git diff --check
```

The safety suite exercises temporary destinations, reruns, conflicts, backups,
custom paths, and missing sources. It does not launch GUI applications, install
plugins/packages, or exercise the live home directory.
