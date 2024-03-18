# ---- fg zsh conf ----
export EDITOR=code
export VISUAL="$EDITOR"
 
# ---- var ----
export DOTFILES="$HOME/d/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export NVM_DIR="$HOME/.nvm"
export RUBY_DIR="$(brew --prefix)/opt/ruby/bin"
export PYENV_DIR="$HOME/.pyenv/shims"
export ZSH="$HOME/.oh-my-zsh"
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

# ---- pyenv ----
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ---- Oh-My-Zsh ----
export ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# ---- zoxide ----
eval "$(zoxide init zsh)"

# search history with fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmux find session
bindkey -s ^f "tmux-session-find\n"

# ---- aliases ----
alias t='tmux-session'
alias tf='tmux-session-find'
alias v='nvim'
alias vim='nvim'
alias c='code'
alias ci='code-insiders'
alias cl='clear'
alias l='ls -l -F --color=auto'
alias ll='ls -la -F --color=auto'
alias ls='ls -F --color=auto'
alias la='ls -a -F --color=auto'
alias neo='neofetch'
alias nii="npm i -g @antfu/ni"
alias sim='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias soz='source ~/.zshrc'
alias sot='tmux source ~/.tmux.conf'
alias zsh-startup="time zsh -i -c exit"

# git aliases
alias s='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'
alias grhu='git reset --hard @{u}' #reset hard to upstream branch
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
  cd ~/dev/$1
}

function dir() {
  mkdir $1 && cd $1
}
