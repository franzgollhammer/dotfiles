#  ─────────────────────────────────────────────────────────────
#   fg · zsh configuration
#  ─────────────────────────────────────────────────────────────

# ═══ Environment ═════════════════════════════════════════════

export TERM="xterm-256color"
export XDG_CONFIG_HOME="$HOME/.config"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="code-insiders"
  export VISUAL="code-insiders"
  export VUE_EDITOR="code-insiders"
fi

# ═══ Directories ═════════════════════════════════════════════

export DEV="$HOME/dev"
export DOTFILES="$DEV/dotfiles"
export SCRIPTS="$DOTFILES/scripts"

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

# ═══ Completion ══════════════════════════════════════════════

autoload -Uz compinit && compinit

[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# ═══ Tools ═══════════════════════════════════════════════════

[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

source <(fzf --zsh)

eval "$(starship init zsh)"

# ═══ Aliases ═════════════════════════════════════════════════

# — editors —
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias ci="code-insiders"

# — navigation & listing —
alias ls="ls -FG"
alias l="ls -ah"
alias ll="ls -lah"
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
alias gwt="git worktree"
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

# ═══ Functions ═══════════════════════════════════════════════

# mkdir + cd into it
function dir() {
  mkdir "$1" && cd "$1" || return
}

# cd into a project under $DEV — no arg picks one via fzf, `.` goes to $DEV
function d() {
  if [[ -z "$1" ]]; then
    local selected
    selected=$(ls "$DEV" | fzf) || return
    [[ -n "$selected" ]] && cd "$DEV/$selected"
  elif [[ "$1" == "." ]]; then
    cd "$DEV"
  else
    cd "$DEV/$1"
  fi
}

# open a project under $DEV in $EDITOR — no arg picks one via fzf
function c() {
  if [[ -z "$1" ]]; then
    local selected
    selected=$(ls "$DEV" | fzf) || return
    [[ -n "$selected" ]] && $EDITOR "$DEV/$selected"
  else
    $EDITOR "$1"
  fi
}

# cd into a git worktree of the current repo — picks one via fzf
function wt() {
  local dir
  dir=$(git worktree list --porcelain \
    | awk '/^worktree /{p=$2} /^branch /{sub("refs/heads/","",$2); print p"\t"$2}' \
    | column -t \
    | fzf --height=40% --reverse --prompt="worktree> " \
    | awk '{print $1}')
  [[ -n "$dir" ]] && cd "$dir"
}

# ═══ Autosuggestions ═════════════════════════════════════════
# Must stay last: it wraps existing ZLE widgets.

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
