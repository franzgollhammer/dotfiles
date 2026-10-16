#  ─────────────────────────────────────────────────────────────
#   fg · zsh configuration
#  ─────────────────────────────────────────────────────────────

# ═══ Environment ═════════════════════════════════════════════

export TERM="xterm-256color"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

export EDITOR="vim"
export VISUAL="vim"

# ═══ Directories ═════════════════════════════════════════════

export DEV="$HOME/dev"
# Resolve this file's symlink so scripts and secrets follow the active checkout.
export DOTFILES="${${(%):-%x}:A:h}"
export SCRIPTS="$DOTFILES/scripts"
export WT="$DEV/worktrees"
export LOCAL_BIN="$HOME/.local/bin"
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
export RUBY_DIR="/opt/homebrew/opt/ruby/bin"
export NVM_DIR="$HOME/.nvm"

# ═══ Path ════════════════════════════════════════════════════
# `typeset -U` keeps entries unique, so re-sourcing never duplicates.

typeset -U path PATH
path=(
  "$HOME/.opencode/bin"           # opencode
  "$HOME/.codeium/windsurf/bin"   # devin / windsurf
  "$PNPM_HOME"
  "$SCRIPTS"
  "$BUN_INSTALL/bin"
  "$RUBY_DIR"
  "$LOCAL_BIN"
  $path
)
export PATH

# ═══ Secrets ═════════════════════════════════════════════════

if [[ -f "$DOTFILES/.env" ]]; then
  set -a
  source "$DOTFILES/.env"
  set +a
fi

# ═══ History ═════════════════════════════════════════════════
# /etc/zshrc caps SAVEHIST at 1000, which truncates ~/.zsh_history on exit.

HISTSIZE=50000
SAVEHIST=50000

# ═══ Oh My Zsh ═══════════════════════════════════════════════

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=()
if [[ -f "${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]]; then
  plugins+=(zsh-autosuggestions)
elif [[ -f "$ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]]; then
  plugins+=(zsh-autosuggestions)
fi
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# ═══ Starship ════════════════════════════════════════════════

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# ═══ Completion ══════════════════════════════════════════════

[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# ═══ Tools ═══════════════════════════════════════════════════

[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# ═══ Aliases ═════════════════════════════════════════════════

# — editors —
alias v="vim"
alias vi="vim"

# — navigation & listing —
alias dot="(cd \$DOTFILES; \$EDITOR .)"
alias play="(cd \$DEV/playground; \$EDITOR .)"

# — dev —
alias p="pnpm"
alias run="node --run"
alias lg="lazygit"
alias t="tmux_session"
alias sim="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

# — git —
alias s="git status"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gp="git pull"
alias gps="git push"
alias gw="git worktree"
alias gwa="git worktree add"
alias wta="git worktree add"
alias gwr="git worktree remove"
alias gundo="git reset --soft HEAD~1"
alias grhu="git reset --hard @{u}"                 # reset hard to upstream branch
alias glf="git log -p -- "                         # log patch <filename>
alias com="git commit -m \"\$(date '+%Y-%m-%d-%H:%M:%S')\" --allow-empty; git push"

# — github —
alias repo="gh repo view --web"
alias pr="gh pr view --web || gh pr create --web"

# — system —
alias ff="fastfetch"
alias bbb="brew_update"
alias soz="source ~/.zshrc"
alias sot="tmux source ~/.tmux.conf"
alias zsh-startup="time zsh -i -c exit"
alias killall="pkill -u \$(whoami) node npm mongod redis redis-server minio Cypress Runner.Listener"
alias exif="exiftool -a -u -g1"

# ═══ Functions ═══════════════════════════════════════════════

# mkdir + cd into it
function dir() {
  mkdir "$1" && cd "$1" || return
}

# cd into a project under $DEV — no arg shows a menu, `.` goes to $DEV
function d() {
  if [[ -z "$1" ]]; then
    local selected
    local PS3='Project number (Ctrl-D to cancel): '
    local -a projects=("$DEV"/*(N/))
    (( ${#projects} )) || { print -u2 'No project directories found.'; return 1; }
    select selected in "${projects[@]}"; do
      [[ -n "$selected" ]] || continue
      cd -- "$selected"
      return
    done
    return 1
  elif [[ "$1" == "." ]]; then
    cd "$DEV"
  else
    cd "$DEV/$1"
  fi
}

# open a project under $DEV in $EDITOR — no arg shows a menu
function c() {
  if [[ -z "$1" ]]; then
    local selected
    local PS3='Project number (Ctrl-D to cancel): '
    local -a projects=("$DEV"/*(N/))
    (( ${#projects} )) || { print -u2 'No project directories found.'; return 1; }
    select selected in "${projects[@]}"; do
      [[ -n "$selected" ]] || continue
      $EDITOR "$selected"
      return
    done
    return 1
  else
    $EDITOR "$1"
  fi
}

# cd into a git worktree of the current repo — choose from a numbered menu
function wt() {
  git rev-parse --git-dir > /dev/null || return
  local entry selected
  local PS3='Worktree number (Ctrl-D to cancel): '
  local -a worktrees=()
  while IFS= read -r -d '' entry; do
    [[ "$entry" == 'worktree '* ]] && worktrees+=("${entry#worktree }")
  done < <(git worktree list --porcelain -z)
  (( ${#worktrees} )) || return 1
  select selected in "${worktrees[@]}"; do
    [[ -n "$selected" ]] || continue
    cd -- "$selected"
    return
  done
  return 1
}

