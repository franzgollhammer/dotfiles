# ---- fg zsh conf ----
# zmodload zsh/zprof # uncomment this line and bottom line to measure startup time

# ---- var ----
# set default editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR="zed"
  export VISUAL="zed"
  export VUE_EDITOR="zed"
fi

# set default dirs
export DEV="$HOME/dev"
export DOTFILES="$DEV/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export RUBY_DIR="$(brew --prefix)/opt/ruby/bin"

# ---- path ----
export PATH="$SCRIPTS:"\
"$RUBY_DIR:"\
"$PATH"

# ---- nvm ----
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# ---- fzf ----
source <(fzf --zsh)

# ---- .env ----
# load env variables from .env file
export $(grep -v '^#' $DOTFILES/.env | xargs)

# ---- starship ----
eval "$(starship init zsh)"

# ---- zoxide ----
eval "$(zoxide init zsh)"

# ---- autosuggestions ----
source zsh_autosuggestions

# ---- aliases ----
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias t="tmux_session"
alias lg="lazygit"
alias run="node --run"
alias cl="clear"
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
alias cyrun="npx cypress run -s"
alias bbb="brew_update"

# test runner
alias killrunners="pkill -u $(whoami) Runner.Listener"
alias actions-runner-pf="sh $DEV/actions-runner-pf-1/run.sh"
alias actions-runner-ucsl="sh $DEV/actions-runner-ucsl-1/run.sh"

# git aliases
alias g="git"
alias s="git status"
alias gbr="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | fzf | xargs git checkout"
alias ga="git add"
alias gd="git diff"
alias gaa="git add ."
alias gap="git add -p"
alias gs="git stash"
alias gundo="git reset --soft HEAD~1"
alias stash="git stash -u"
alias stashls="git stash list"
alias pop="git stash pop"
alias apply="git stash apply"
alias gc="git commit"
alias gcm="git commit -m"
alias grh="git reset --hard"
alias grhu="git reset --hard @{u}" # reset hard to upstream branch
alias gl="git log --graph"
alias gp="git pull"
alias wt="git worktree"
alias gps="git push"
alias gco="git checkout"
alias gcob="git checkout -b"
alias com="git commit -m "$(date "+%Y-%m-%d-%H:%M:%S")" --allow-empty; git push"
alias yolo="git add .; git commit -m "$(date "+%Y-%m-%d-%H:%M:%S")" --allow-empty; git push"

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

# zprof # uncomment measure startup time
