# ---- franzgollhammer zsh conf ----
export EDITOR=nvim
export VISUAL="$EDITOR"

# ---- var ----
export CONFIG_DIR="$HOME/d/config-files"
export DOTFILES="$HOME/d/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export NVM_DIR="$HOME/.nvm"
export RUBY_DIR="$(brew --prefix)/opt/ruby/bin"
export PYENV_DIR="$HOME/.pyenv/shims"
export ZSH="$HOME/.oh-my-zsh"
export VM_DEV="$HOME/Virtual Machines.localized/dev.vmwarevm/dev.vmx"
export MYVIMRC="$HOME/.config/nvim/init.lua"
export BUN_INSTALL="$HOME/.bun/bin"

# ---- path ----
export PATH="$SCRIPTS:"\
"$NVM_DIR:"\
"$RUBY_DIR:"\
"$PYENV_DIR:"\
"$BUN_INSTALL:"\
"$PATH"

# bun completions
[ -s "/Users/fg/.bun/_bun" ] && source "/Users/fg/.bun/_bun"

# ---- nvm ----
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ---- pnpm ----
# export PNPM_HOME="/Users/fg/Library/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac

# ---- pyenv ----
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# ---- zsh plugins ----
plugins=(
  zsh-autosuggestions
)

# ---- zoxide ----
eval "$(zoxide init zsh)"

# ---- Oh-My-Zsh ----
# export ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# ---- starship ----
eval "$(starship init zsh)"

# search history with fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmux find session
bindkey -s ^f "tmux-session-find\n"

# ---- aliases ----
alias t='tmux-session'
alias v='nvim'
alias vv='nvim .'
alias code='code-insiders'
alias cl='clear'
alias ls='ls -F --color=auto'
alias neo='neofetch'
alias pn='pnpm'
alias pnx='pnpm dlx'
alias nii="npm i -g @antfu/ni"
alias sim='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias soz='source ~/.zshrc'
alias sot='tmux source ~/.tmux.conf'
alias zsh-startup="time zsh -i -c exit"
# GROOT
alias grt='cd "$(git rev-parse --show-toplevel)"'

# git aliases
alias s='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gss='git status'
alias gse='git rev-list --all | xargs git grep -F'
alias gc='git commit'
alias gcm='git commit -m'
alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'
alias gl="git log"
alias gll="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset\'"
alias gp='git pull'
alias psh='git push'
alias gco='git checkout'
alias gcob='git checkout -b'
alias stash='git stash -u'
alias pop='git stash pop'
alias apply='git stash apply'
alias stashls='git stash list'
alias save='git stash save -u'
alias repo="gh repo view --web"
alias pr="gh pr view --web"

# ---- functions ----
function d() {
  cd ~/d/$1
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  if [[ -z $2 ]] then
    gh repo clone "$@" && cd "$(basename "$1" .git)"
  else
    gh repo clone "$@" && cd "$2"
  fi
}

function cloned() {
  d && clone "$@" && code . && cd ~2
}

function pr() {
  if [ $1 = "ls" ]; then
    gh pr list
  else
    gh pr checkout $1
  fi
}

function pid() {
  lsof -i :$1
}

function killpid() {
  kill -9 $1
}

