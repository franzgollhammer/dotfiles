# ---- fg zsh conf ----
# zmodload zsh/zprof # uncomment this line and bottom line to measure startup time

# ---- var ----
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR="nvim"
  export VISUAL="nvim"
  export VUE_EDITOR="nvim"
fi

export DOTFILES="$HOME/dev/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
RUBY_DIR="$(brew --prefix)/opt/ruby/bin"
export RUBY_DIR

# ---- path ----
export PATH="$SCRIPTS:"\
"$RUBY_DIR:"\
"$PATH"

# ---- nvm ----
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# ---- aliases ----
alias t="tmux_session.sh"
alias v="nvim"
alias c="code"
alias ci="code-insiders"
alias run="node --run"
alias zj="zellij"
alias cl="clear"
alias ls="eza -F"
alias l="ls -ah"
alias ll="ls -lah"
alias dot="(cd $DOTFILES; c .)"
alias play="(cd $HOME/dev/playground; c .)"
alias neo="neofetch"
alias sim="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias soz="source ~/.zshrc"
alias sot="tmux source ~/.tmux.conf"
alias zsh-startup="time zsh -i -c exit"
alias killall="pkill -u $(whoami) node npm mongod redis redis-server minio Cypress Runner.Listener"
alias killrunners="pkill -u $(whoami) Runner.Listener"
alias test="sh $HOME/dev/actions-runner-pf-1/run.sh & sh $HOME/dev/actions-runner-pf-2/run.sh & sh $HOME/dev/actions-runner-pf-3/run.sh"
alias test-ucsl="sh $HOME/dev/actions-runner-ucsl-1/run.sh & sh $HOME/dev/actions-runner-ucsl-2/run.sh"
alias pflocal="sh $HOME/dev/db-connections/pf_mongo_local.sh"
alias pfdev="sh $HOME/dev/db-connections/pf_mongo_dev.sh"
alias ucsllocal="sh $HOME/dev/db-connections/ucsl_mongo_local.sh" 
alias ucsldev="sh $HOME/dev/db-connections/ucsl_mongo_dev.sh" 

# git aliases
alias g="git"
alias s="git status"
alias b="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | fzf | xargs git checkout"
alias gbr="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | fzf | xargs git checkout"
alias ga="git add"
alias gd="git diff"
alias gaa="git add ."
alias gap="git add -p"
alias gs="git stash"
alias stash="git stash -u"
alias stashls="git stash list"
alias pop="git stash pop"
alias apply="git stash apply"
alias gc="git commit"
alias gcm="git commit -m"
alias gm="git merge"
alias gr="git reset"
alias grh="git reset HEAD"
alias grh1="git reset HEAD~1"
alias grhu="git reset --hard @{u}" # reset hard to upstream branch
alias gl="git log --graph"
alias gp="git pull"
alias gps="git push"
alias gco="git checkout"
alias gcob="git checkout -b"
alias com="git commit -m "$(date "+%Y-%m-%d-%H:%M:%S")" --allow-empty; git push"
alias yolo="git add .; git commit -m "$(date "+%Y-%m-%d-%H:%M:%S")" --allow-empty; git push"

# github
alias repo="gh repo view --web"
alias pr="gh pr view --web || gh pr create --web"

# ---- functions ----
function tf() {
  tmux_session_find.sh
}

function lg() {
  lazygit
}

function tw() {
  tmux select-window -t $1
}

function d() {
  cd ~/dev/"$1" || exit
}

function dir() {
  mkdir "$1" && cd "$1" || exit
}

# ---- bind ----
# bind tmux session finder to ctrl-f
zle -N tf
bindkey ^f tf
# bind lazygit to ctrl-g
zle -N lg
bindkey ^g lg

# ---- eval ----
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# ---- mongo ----
# mongoexport --uri="mongodb://localhost:27017/myDatabase" --collection=users --query='{ "age": { "$gt": 25 } }' --limit=100 --out=limited_users.json
# mongoimport --uri="mongodb://localhost:27017/myDatabase" --collection=users --file=limited_users.json --jsonArray

# zprof # uncomment measure startup time
