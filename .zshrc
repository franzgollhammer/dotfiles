# ---- fg zsh conf ----
# zmodload zsh/zprof # uncomment to measure startup time

# ---- var ----
export EDITOR="code"
export VISUAL="code"
export VUE_EDITOR="code"
export DOTFILES="$HOME/dev/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export RUBY_DIR="$(brew --prefix)/opt/ruby/bin"

# ---- path ----
export PATH="$SCRIPTS:"\
"$RUBY_DIR:"\
"$PATH"

# ---- zoxide ----
eval "$(zoxide init zsh)"

# ---- starship ----
eval "$(starship init zsh)"

# ---- fzf ----
eval "$(fzf --zsh)"

# ---- zsh autosuggestions ----
source zsh_autosuggestions.sh

# ---- lazy load nvm ----
source lazy_nvm.sh

# ---- aliases ----
alias t="tmux_session"
alias tf="tmux_session_find"
alias v="nvim"
alias c="code"
alias ci="code-insiders"
alias zj="zellij"
alias cl="clear"
alias ls="eza -F"
alias l="ls -ah"
alias ll="ls -lah"
alias dot="cd $DOTFILES; code ."
alias play="cd $HOME/dev/playground; code ."
alias neo="neofetch"
alias sim="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias soz="source ~/.zshrc"
alias sot="tmux source ~/.tmux.conf"
alias zsh-startup="time zsh -i -c exit"

# git aliases
alias g="git"
alias s="git status"
alias ga="git add"
alias gd="git diff"
alias gaa="git add ."
alias gs="git stash"
alias stash="git stash -u"
alias pop="git stash pop"
alias apply="git stash apply"
alias gc="git commit"
alias gcm="git commit -m"
alias gm="git merge"
alias gr="git reset"
alias grh="git reset HEAD"
alias grh1="git reset HEAD~1"
alias grhu="git reset --hard @{u}" #reset hard to upstream branch
alias gl="git log --graph"
alias gp="git pull"
alias psh="git push"
alias gco="git checkout"
alias gcob="git checkout -b"
alias com="git commit -m "$(date "+%Y-%m-%d-%H:%M:%S")" --allow-empty; git push"
alias yolo="git add .; git commit -m "$(date "+%Y-%m-%d-%H:%M:%S")" --allow-empty; git push"

# github
alias repo="gh repo view --web"
alias pr="gh pr view --web"

# ---- functions ----
function d() {
  cd ~/dev/$1
}

function dir() {
  mkdir $1 && cd $1
}

# zprof # uncomment measure startup time