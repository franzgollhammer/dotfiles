# ---- fg zsh conf ----

# ---- oh-my-zsh ----
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

plugins=(
  nvm
  fzf
  zoxide
  zsh-autosuggestions
)

# ---- var ----
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR="code-insiders"
  export VISUAL="code-insiders"
  export VUE_EDITOR="code-insiders"
fi

export DEV="$HOME/dev"
export DOTFILES="$DEV/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export RUBY_DIR="/opt/homebrew/opt/ruby/bin"
export LOCAL_BIN="$HOME/.local/bin"

# ---- path ----
export PATH="$SCRIPTS:"\
"$RUBY_DIR:"\
"$LOCAL_BIN:"\
"$PATH"

# ---- .env ----
export $(grep -v '^#' $DOTFILES/.env | xargs)

# ---- source oh-my-zsh ----
source $ZSH/oh-my-zsh.sh

# ---- fzf ----
source $DOTFILES/fzf/steel-dark.sh

# ---- aliases ----
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias t="tmux_session"
alias lg="lazygit"
alias run="node --run"
alias ls="ls -FG"
alias l="ls -ah"
alias ll="ls -lah"
alias dot="(cd $DOTFILES; $EDITOR .)"
alias play="(cd $DEV/playground; $EDITOR .)"
alias ff="fastfetch"
alias sim="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias soz="source ~/.zshrc"
alias sot="tmux source ~/.tmux.conf"
alias zsh-startup="time zsh -i -c exit"
alias killall="pkill -u $(whoami) node npm mongod redis redis-server minio Cypress Runner.Listener"
alias bbb="brew_update"

# git aliases
alias gundo="git reset --soft HEAD~1"
alias grhu="git reset --hard @{u}" # reset hard to upstream branch
alias glf="git log -p -- " # log patch <filename>
alias com="git commit -m "$(date "+%Y-%m-%d-%H:%M:%S")" --allow-empty; git push"

# github
alias repo="gh repo view --web"
alias pr="gh pr view --web || gh pr create --web"

# ---- functions ----
function dir() {
  mkdir "$1" && cd "$1" || exit
}

function d() {
  if [ -z "$1" ]; then
    selected=$(ls "$DEV" | fzf)
    if [ -n "$selected" ]; then
      cd "$DEV"/"$selected"
    fi
  elif [ "$1" = '.' ]; then
    cd "$DEV"
  else
    cd "$DEV"/"$1"
  fi
}

function c() {
  if [ -z "$1" ]; then
    selected=$(ls "$DEV" | fzf)
    if [ -n "$selected" ]; then
      $EDITOR "$DEV"/"$selected"
    fi
  else
    $EDITOR "$1"
  fi
}

# ---- starship prompt ----
eval "$(starship init zsh)"

# ---- end fg zsh conf ----
