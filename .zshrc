# ---- fg zsh conf ----
# zmodload zsh/zprof # uncomment this line and bottom line to measure startup time

# ---- var ----
# set default editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR="code"
  export VISUAL="code"
  export VUE_EDITOR="code"
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
alias c="code"
alias ci="code-insiders"
alias t="tmux_session"
alias lg="lazygit"
alias run="node --run"
alias cl="clear"
alias ls="eza -F"
alias l="ls -ah"
alias ll="ls -lah"
# alias hist="fc -rl 1 | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//' | fzf" # search last commands with fzf
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
alias test="sh $DEV/actions-runner-pf-1/run.sh & sh $DEV/actions-runner-pf-2/run.sh & sh $DEV/actions-runner-pf-3/run.sh"
alias test-ucsl="sh $DEV/actions-runner-ucsl-1/run.sh & sh $DEV/actions-runner-ucsl-2/run.sh"

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
alias gm="git merge"
alias grhu="git reset --hard @{u}" # reset hard to upstream branch
alias gl="git log --graph"
alias glog="git log --graph --parents"
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
function d() {
  cd $DEV/"$1" || exit
}

function dir() {
  mkdir "$1" && cd "$1" || exit
}

# ---- mongodb ----
# mongoexport --uri="mongodb://localhost:27017/myDatabase" --collection=users --query='{ "age": { "$gt": 25 } }' --limit=100 --out=limited_users.json
# mongoimport --uri="mongodb://localhost:27017/myDatabase" --collection=users --file=limited_users.json --jsonArray

# zprof # uncomment measure startup time
