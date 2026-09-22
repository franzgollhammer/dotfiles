#  ─────────────────────────────────────────────────────────────
#   fg · zsh configuration
#  ─────────────────────────────────────────────────────────────

# ═══ Environment ═════════════════════════════════════════════

export TERM="xterm-256color"
export XDG_CONFIG_HOME="$HOME/.config"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="code"
  export VISUAL="code"
  export VUE_EDITOR="code"
fi

# ═══ Directories ═════════════════════════════════════════════

export DEV="$HOME/dev"
export DOTFILES="$DEV/dotfiles"
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
ZSH_THEME="robbyrussell"
plugins=(fzf zsh-autosuggestions)
source "$ZSH/oh-my-zsh.sh"

# ═══ Starship ════════════════════════════════════════════════

eval "$(starship init zsh)"

# ═══ Completion ══════════════════════════════════════════════

[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# ═══ Tools ═══════════════════════════════════════════════════

[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# ═══ Aliases ═════════════════════════════════════════════════

# — editors —
alias z="zed"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias ci="code-insiders"

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

# remove git worktree(s) of the current repo — picks via fzf (tab = multi), -f forces
function wtr() {
  git rev-parse --git-dir >/dev/null || return
  local force=()
  [[ "$1" == "-f" ]] && force=(--force)

  local main selected line dir branch
  main=$(git worktree list --porcelain | awk '/^worktree /{print $2; exit}')
  selected=$(git worktree list --porcelain \
    | awk '/^worktree /{p=$2; n++} n>1 && /^branch /{sub("refs/heads/","",$2); print p"\t"$2} n>1 && /^detached/{print p"\t(detached)"}' \
    | column -t \
    | fzf --multi --height=40% --reverse --prompt="remove worktree> " \
    | awk '{print $1"\t"$2}')
  [[ -z "$selected" ]] && return

  for line in ${(f)selected}; do
    dir=${line%%$'\t'*}
    branch=${line#*$'\t'}
    git -C "$main" worktree remove $force "$dir" || continue
    [[ "$PWD" == "$dir" || "$PWD" == "$dir"/* ]] && cd "$main"
    echo "removed $dir"
    [[ "$branch" == "(detached)" ]] && continue
    if read -q "?delete branch $branch? [y/N] "; then
      echo
      git -C "$main" branch -d "$branch"
    else
      echo
    fi
  done
}
