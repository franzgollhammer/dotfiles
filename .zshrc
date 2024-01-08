# ---- franzgollhammer zsh conf ----

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
# export DENO_INSTALL="$HOME/.deno/bin"
# export BUN_INSTALL="$HOME/.bun/bin"

# ---- path ----
export PATH="$SCRIPTS:"\
"$NVM_DIR:"\
"$RUBY_DIR:"\
"$PYENV_DIR:"\
"$PATH"
# "$DENO_INSTALL:"\
# "$BUN_INSTALL:"\

# ---- colorize less command ----
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

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

# ---- Starship ----
eval "$(starship init zsh)"

# Tmux sessionizer
bindkey -s ^f "tmux-sessionizer\n"
# Search history with fzf
# bindkey ^r fzf-history-search
bindkey '^R' fzf-history-search

# ---- aliases ----
# ls -F --color=auto
alias v='nvim'
alias vv='nvim .'
alias c='code-insiders'
alias code='code-insiders'
alias cl='clear'
alias ls='ls -F --color=auto'
alias neo='neofetch'
alias pn='pnpm'
alias pnx='pnpm dlx'
alias nii="npm i -g @antfu/ni"
alias sim='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias soz='source ~/.zshrc'
alias sov='source ~/.vimrc'
alias sot='tmux source ~/.tmux.conf'
alias zsh-startup="time zsh -i -c exit"
# GROOT
alias grt='cd "$(git rev-parse --show-toplevel)"'

# yabai and skhd
alias yabai-start='yabai --start-service'
alias yabai-stop='yabai --stop-service'
alias yabai-restart='yabai --restart-service'
alias skhd-start='skhd --start-service'
alias skhd-stop='skhd --stop-service'
alias skhd-restart='skhd --restart-service'

# git aliases
alias s='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gd='git diff'
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
alias main='git checkout main'
alias gmm='git merge main'
alias gb='git branch'
alias gbd='git branch -d'
alias sls='git stash list'
alias stash='git stash -u'
alias pop='git stash pop'
alias apply='git stash apply'
alias stashls='git stash list'
alias save='git stash save -u'
alias ghrepo="gh repo view --web"
alias ghpr="gh pr view --web"

# ---- Functions ----
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

function fzf-history-search() {
    BUFFER=$(history | sed "s/^ *[^ ]* *//" | fzf)
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N fzf-history-search
