# ---- fg zsh conf ----
# zmodload zsh/zprof # uncomment this line and bottom line to measure startup time

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH


# ---- var ----
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR="code"
  export VISUAL="code"
  export VUE_EDITOR="code"
fi

export DOTFILES="$HOME/dev/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
RUBY_DIR="$(brew --prefix)/opt/ruby/bin"
export RUBY_DIR

# ---- path ----
export PATH="$SCRIPTS:"\
"$RUBY_DIR:"\
"$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 14

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  nvm
  fzf
  zoxide
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.

# ---- aliases ----
alias t="tmux_session"
alias tf="tmux_session_find"
alias v="nvim"
alias c="$EDITOR"
alias ci="code-insiders"
alias run="node --run"
alias zj="zellij"
alias cl="clear"
alias ls="eza -F"
alias l="ls -ah"
alias ll="ls -lah"
alias dot="cd $DOTFILES; c ."
alias play="cd $HOME/dev/playground; c ."
alias neo="neofetch"
alias sim="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias soz="source ~/.zshrc"
alias sot="tmux source ~/.tmux.conf"
alias zsh-startup="time zsh -i -c exit"
alias gh-runner="cd $HOME/dev/actions-runner-1 && sh ./run.sh"

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
  cd ~/dev/"$1" || exit
}

function dir() {
  mkdir "$1" && cd "$1" || exit
}

# zprof # uncomment measure startup time
