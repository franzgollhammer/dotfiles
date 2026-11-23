# Dotfiles

Personal development environment: zsh, Starship, tmux, Vim, terminal
configurations, and helper scripts. The terminal setup supports macOS,
Ubuntu 22.04/24.04/26.04, and Debian 12/13, both locally and over SSH.
The full profile adds personal macOS Ghostty settings.

## Setup

### macOS prerequisites

Install Xcode Command Line Tools (`xcode-select --install`) and
[Homebrew](https://docs.brew.sh/Installation), following its shell PATH instructions.
Install the terminal tools listed under [Shell and application prerequisites](#shell-and-application-prerequisites).

### Ubuntu and Debian prerequisites

Install the shared terminal tools from the distribution repositories:

```sh
sudo apt update
sudo apt install ca-certificates zsh tmux vim git fzf ripgrep fd-find bsdextrautils procps psmisc ncurses-term
```

On Ubuntu, enable the `universe` repository if apt cannot find packages such as
`fd-find` or `fzf`. `bsdextrautils` supplies `column` for the branch and worktree
pickers; `procps` and `psmisc` supply the process helpers; `ncurses-term` supplies additional
terminal descriptions. Install `vim`, rather than relying on a minimal image's
`vim-tiny`.

Starship, lazygit, fastfetch, Oh My Zsh, and autosuggestions are optional.
Package availability varies by release, so install them separately from the
baseline above. Check availability with `apt-cache policy starship lazygit fastfetch`.
[Starship is packaged in Debian 13+ and Ubuntu 25.04+](https://starship.rs/guide/#step-1-install-starship);
for older releases, use an upstream installation method if you want its prompt.
See the upstream installation instructions for
[lazygit](https://github.com/jesseduffield/lazygit#installation) and
[fastfetch](https://github.com/fastfetch-cli/fastfetch#installation).
Without them, zsh keeps its standard prompt and tmux initialization skips
machine information. Install Oh My Zsh and autosuggestions using the optional
commands under [Shell and application prerequisites](#shell-and-application-prerequisites).

### Link configuration

After installing your platform's prerequisites, clone into a permanent location:

```sh
git clone https://github.com/franzgollhammer/dotfiles.git ~/dev/src/github.com/franzgollhammer/dotfiles
cd ~/dev/src/github.com/franzgollhammer/dotfiles

# Preview every link before changing your home directory.
./scripts/dotfiles_setup --dry-run

# Install when destinations are empty or already point to this checkout.
./scripts/dotfiles_setup

# On the personal Mac, also link Ghostty.
./scripts/dotfiles_setup --profile full --dry-run
./scripts/dotfiles_setup --profile full
```

Start `zsh` to use the linked configuration. To make it the login shell, run
`chsh -s "$(command -v zsh)"`, then log out and back in. The linker never changes
the login shell.

Existing files, directories, or different symlinks cause the entire preflight to
fail without changes. To preserve them as adjacent `.dotfiles-backup.*` files
and install the links, run:

```sh
./scripts/dotfiles_setup --dry-run --backup
./scripts/dotfiles_setup --backup
```

To discard conflicting files and symlinks instead, without a backup, use
`--force`. It never deletes directories: a conflicting directory such as
`~/.config/ghostty` still aborts the run and needs `--backup`. `--force` and
`--backup` cannot be combined.

```sh
./scripts/dotfiles_setup --dry-run --force
./scripts/dotfiles_setup --force
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
worktree you intend to delete. After loading `.zshrc`, invoke `dotfiles_setup`
from any directory; it is the single entry point for synchronizing these links.

By default, config links use `XDG_CONFIG_HOME`, falling back to `~/.config`.
To inspect or install into an isolated destination:

```sh
./scripts/dotfiles_setup --home /tmp/dotfiles-demo --dry-run
./scripts/dotfiles_setup --home /tmp/dotfiles-demo
```

`--home` must be absolute and uses `<home>/.config`, ignoring `XDG_CONFIG_HOME`.
The linker does not install packages, create secrets, replace the login shell,
patch application icons, or change system preferences.

## Remote machines over SSH

### Remote Mac

On a remote Mac (for example a Mac mini used only through `ssh` and tmux),
install the terminal tools and the minimal profile. Nothing here needs a
graphical session, and the linker leaves the machine's own application settings
untouched:

```sh
brew install starship fzf tmux ripgrep fd lazygit fastfetch

# Oh My Zsh with the autosuggestions plugin; the prompt comes from Starship.
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
git clone https://github.com/zsh-users/zsh-autosuggestions.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

git clone https://github.com/franzgollhammer/dotfiles.git ~/dev/src/github.com/franzgollhammer/dotfiles
cd ~/dev/src/github.com/franzgollhammer/dotfiles
./scripts/dotfiles_setup --profile minimal --dry-run
./scripts/dotfiles_setup --profile minimal
```

### Remote Linux (Ubuntu or Debian)

Follow [Ubuntu and Debian prerequisites](#ubuntu-and-debian-prerequisites), then
install the default minimal profile as described under [Link configuration](#link-configuration).
The same setup works on a local terminal or a cloud server reached through SSH;
neither needs Homebrew or a graphical session.

Debian and Ubuntu install fd as `fdfind`; `.zshrc` aliases `fd` to it when no
`fd` command exists. Outside macOS, `PNPM_HOME` is
`${XDG_DATA_HOME:-~/.local/share}/pnpm`, the Homebrew Ruby path is skipped, and
the `sim`, `bb`, and `bbb` aliases are not defined. `brew_update_packages` and
`brew_export_packages` stay on `PATH` but need Homebrew. tmux 3.2a on Ubuntu 22.04 skips
the newer `allow-passthrough` option; older tmux already permits passthrough.

### On every remote machine

`.zshrc` sets `EDITOR` and `VISUAL` to `vim` locally and over SSH, so `c`,
`dot`, and `play` open a terminal editor. `.env` is optional: create it only for
credentials the remote machine actually uses. tmux copy mode sends copied text
to the terminal in front of you through OSC 52 (`set-clipboard on`), so it
reaches the local clipboard over SSH when the terminal allows clipboard writes.

## Shell and application prerequisites

Install the tools you use. A useful starting set for this configuration is:

```sh
brew install starship fzf tmux ripgrep fd lazygit fastfetch
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
exists, and otherwise from the Homebrew `nvm` formula, whose loader links nvm
into `~/.nvm` on first use. `.vimrc` uses no plugins and supports the
distribution Vim packages; `:grep` uses ripgrep when it is installed.

`brew/formula.txt` and `brew/cask.txt` are machine inventory snapshots, including
transitive dependencies and potentially retired or renamed packages. Review
those lists instead of treating them as a guaranteed fresh-machine install
manifest. `brew_update_packages` upgrades and cleans up installed packages;
`brew_export_packages` refreshes both lists.

## Managed links

Paths below use the default `~/.config` location unless stated otherwise.

| Source | Destination | Profile |
| --- | --- | --- |
| `.zshrc`, `.tmux.conf`, `.vimrc` | Same filenames in `~` | minimal |
| `starship.toml` | `~/.config/starship.toml` | minimal |
| `ghostty/` | `~/.config/ghostty` | full |

The whole-directory Ghostty link means changes within that directory can affect
the checkout; inspect `git status` before committing.

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

### Environment variables

The linked `.zshrc` initializes and exports these variables; no manual exports
are required for the default layout. Running `dotfiles_setup` does not change
the environment of the calling shell: start a new zsh session after linking.

| Variable | Default |
| --- | --- |
| `DEV` | `$HOME/dev` |
| `DOTFILES` | Checkout resolved through the `.zshrc` symlink |
| `SCRIPTS` | `$DOTFILES/scripts`, also added to `PATH` |
| `WT` | `$DEV/worktrees` |
| `LOCAL_BIN` | `$HOME/.local/bin` |
| `NVM_DIR`, `BUN_INSTALL` | `$HOME/.nvm`, `$HOME/.bun` |

The installer does not create `DEV` or `WT`; navigation helpers need their target
directories to exist. Keep `.env` for credentials: it loads after `WT` and `PATH`
have been calculated, so changing path variables there does not update their
dependent values. `XDG_CONFIG_HOME` can be exported before both setup and shell
startup to select a different configuration directory.

### tmux initialization

For tmux, `tmux_init_session` uses the first executable file in this order:
`./.tmux_init`, `~/.tmux_init`, then `$DOTFILES/.tmux_init`. Keep the tracked
fallback intact; it names the first window `MAIN` and runs `fastfetch`. Copy
`example.tmux_init` into a project's `.tmux_init` (or `~/.tmux_init`), adapt the
commands, and run `chmod +x` on the copy.

### Terminal keys

Ghostty keeps both Option keys available for macOS character input, including
Option+L for `@` on the Austrian layout. In tmux, press Ctrl+b then w or click
the session name to open the session, window, and pane tree fully expanded.
Ctrl+Shift+Arrow resizes panes by five cells without the prefix. Shift+Arrow
remains available to applications running inside tmux.
After updating, reload tmux with Ctrl+b then r and Ghostty with
Command+Shift+Comma.

### Agent notifications

Use the agents' built-in terminal notifications. Claude Code uses its default
notification channel when `preferredNotifChannel` is unset. Codex TUI
notifications default to enabled, with `notification_method = "auto"` and
`notification_condition = "unfocused"`. Leave these notification overrides unset
to follow each agent's defaults. See the
[Claude Code terminal guide](https://code.claude.com/docs/en/terminal-config)
and the [OpenAI Docs configuration reference](https://developers.openai.com/codex/config-reference/).

Agent settings live outside this repository and are not managed by
`dotfiles_setup`. If migrating from the retired `agent-notify` helper, remove
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

## Repository layout

`~/dev` is split by purpose and lifetime:

| Directory | Holds |
| --- | --- |
| `src/<host>/<owner>/<repository>` | Cloned repositories, path taken from `origin` (`~/dev/src/github.com/planmanager/planfred`) |
| `worktrees/<host>/<owner>/<repository>/<task>` | Additional checkouts for features, pull requests and agents |
| `local/<name>` | Lasting projects without a remote |
| `scratch/<name>` | Experiments and throwaway tests |

`d` and `c` without arguments and `tmux_switch_session` list the projects below `src/`,
`local/` and `scratch/`. The picker shows `<host>/<owner>/<repository>` for
repositories. Anything else directly below `~/dev`, the worktree storage directory
and symbolic links are not listed. `d` always opens the picker; `d planfred` only
pre-fills the search, and `d .` goes to `~/dev`. A tmux
session is named after the project's path below `~/dev`, for example
`src/github.com/franzgollhammer/dotfiles` or `local/notes`. tmux before 3.7
stores `.` and `:` in session names as `_`; `tmux_switch_session` still finds such a
session when it was started in the same directory.

When moving existing checkouts, preserve local files and leave compatibility links
for running shells until their old paths are no longer needed. Repair registered
worktrees with `git worktree repair` from the moved checkout, then rerun the setup
script with `--dry-run` and `--backup` to refresh managed home links. Open a new shell
to refresh `DOTFILES` and `SCRIPTS`. Do not remove old links while tools still use them.

## Helpers

Commands in `scripts/` become available after loading `.zshrc`. Each executable
uses a topic-first `topic_action[_resource]` name with lowercase words and
underscores. Start with the affected tool or area, such as `tmux` or `processes`,
then a concrete action such as `list`, `show`, `set`, `switch`, or `run`. Related
helpers stay together in completion and the script picker. Short interactive
aliases belong in `.zshrc`.

| Command | Purpose |
| --- | --- |
| `brew_export_packages` | Write installed casks and formulas to `brew/*.txt` |
| `brew_update_packages` | Update, upgrade and clean up Homebrew packages |
| `dev_list_projects` | List projects below `src/`, `local/` and `scratch/` as label and path for `d`, `c`, and tmux |
| `dotfiles_setup` | Preview or create configuration links (`--profile full` adds graphical applications) |
| `git_switch_branch` | Pick/switch branches (fzf) with commit metadata |
| `processes_kill_dev` | Run both process helpers below |
| `processes_kill_mongo` | Stop the current user's processes named `mongo` |
| `processes_kill_node` | Stop the current user's processes named `node` |
| `scripts_run` | Pick and execute a helper with fzf |
| `terminal_show_colors` | Show the 16 ANSI colors with hex values from the terminal palette for color picking |
| `tmux_init_session` | Run the first executable project, home, or default `.tmux_init` |
| `tmux_set_window_title` | Rename the tmux window to the worktree branch and PR number, or repository and branch without a PR (requires gh) |
| `tmux_switch_session` | Pick a project, attach/create its tmux session, and initialize new sessions |

Interactive shortcuts remain: `b` → `git_switch_branch`, `s` and `scr` →
`scripts_run`, and `t` → `tmux_switch_session`. On macOS, `bb` →
`brew_update_packages` and `bbb` → `brew_export_packages`.

### Renamed commands

Update custom scripts and automation to use the topic-first executable names
below. The old files are removed; short aliases are available after starting a
new zsh session or reloading `.zshrc`. The setup entry point is now
`dotfiles_setup`; configuration link destinations and `.tmux_init` customization
filenames are unchanged.

| Previous executable names | Current executable |
| --- | --- |
| `brew_export`, `export_brew_packages` | `brew_export_packages` |
| `brew_update`, `update_brew_packages` | `brew_update_packages` |
| `dev_projects`, `list_dev_projects` | `dev_list_projects` |
| `setup_dotfiles` | `dotfiles_setup` |
| `b`, `switch_git_branch` | `git_switch_branch` |
| `kill_all`, `kill_dev_processes` | `processes_kill_dev` |
| `kill_mongo`, `kill_mongo_processes` | `processes_kill_mongo` |
| `kill_node`, `kill_node_processes` | `processes_kill_node` |
| `s`, `run_script` | `scripts_run` |
| `term_colors`, `show_terminal_colors` | `terminal_show_colors` |
| `tmux_init`, `init_tmux_session` | `tmux_init_session` |
| `tmux_set_title`, `set_tmux_window_title` | `tmux_set_window_title` |
| `tmux_session`, `switch_tmux_session` | `tmux_switch_session` |

### Worktree navigation

Worktree navigation lives in `.zshrc`: `wt` picks a worktree of the current
repository; `wtr` picks worktrees to remove and offers branch deletion; `wta` is
an alias for `git worktree add` and takes ordinary Git arguments. The `WT`
environment variable points to `~/dev/worktrees`.

## Validation

The `Dotfiles checks` GitHub Actions workflow runs shell syntax checks,
ShellCheck on all shell helpers, and the full automated safety suite
on macOS and Linux, including Ubuntu 22.04/26.04 and Debian 12/13 containers
with their distribution Vim and tmux packages. Run the full suite through GitHub
Actions, not locally.
For local edits, use narrow checks such as:

```sh
bash -n scripts/dotfiles_setup
shellcheck scripts/dotfiles_setup
zsh -n .zshrc
./scripts/dotfiles_setup --home /tmp/dotfiles-preview --dry-run
./scripts/dotfiles_setup --home /tmp/dotfiles-preview --profile full --dry-run
git diff --check
```

The safety suite exercises temporary destinations, reruns, conflicts, backups,
custom paths, and missing sources. Terminal checks load Vim and an isolated tmux
server, check Linux paths and fd aliases, and exercise tmux initialization without
optional tools. Tests do not launch GUI applications, install plugins/packages,
or exercise the live home directory.
