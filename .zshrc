# ---- fg zsh conf ----

# ---- var ----
export EDITOR="code"
export VISUAL="$EDITOR"
export VUE_EDITOR="$EDITOR"
export DOTFILES="$HOME/dev/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export NVM_DIR="$HOME/.nvm"
export RUBY_DIR="$(brew --prefix)/opt/ruby/bin"
export PYENV_DIR="$HOME/.pyenv/shims"
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

# ---- zoxide ----
eval "$(zoxide init zsh)"

# ---- starship ----
eval "$(starship init zsh)"

# ---- fzf ----
eval "$(fzf --zsh)"

# tmux find session
bindkey -s ^f "tmux_session_find\n"

# zsh autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# iterm shell integration
source iterm2_shell_integration.zsh

# ---- aliases ----
alias t='tmux_session'
alias tf='tmux_session_find'
alias v='nvim'
alias vim='nvim'
alias c='code'
alias ci='code-insiders'
alias cl='clear'
alias ls='eza -F'
alias l='ls -lah'
alias neo='neofetch'
alias sim='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias soz='source ~/.zshrc'
alias sot='tmux source ~/.tmux.conf'
alias zsh-startup="time zsh -i -c exit"

# git aliases
alias s='git status'
alias ga='git add'
alias gaa='git add .'
alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gm='git merge'
alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'
alias grhu='git reset --hard @{u}' #reset hard to upstream branch
alias gl="git log --graph --oneline"
alias gp='git pull'
alias psh='git push'
alias gco='git checkout'
alias gcob='git checkout -b'
alias stash='git stash -u'
alias pop='git stash pop'
alias apply='git stash apply'
alias stashls='git stash list'
alias save='git stash save -u'
alias com='git add .; git commit -m "$(date "+%Y-%m-%d-%H:%M:%S")" --allow-empty; git push'

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
