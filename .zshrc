# Path to your oh-my-zsh installation.
export ZSH=/home/christian/.zsh

# Set name of the theme to load.
ZSH_THEME="lhun"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Plugins
plugins=(vi-mode dircycle tmux)

# Standard Exports
export VISUAL=vim
export EDITOR=vim
export PATH=$PATH:~/bin
export CDPATH=".:..:~"
export TERMINAL=urxvt
export TERMCMD=urxvt
export LESSHISTFILE=/dev/null
export BROWSER=elinks
export MANWIDTH=80
export CACA_DRIVER=ncurses

# All the settings from oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Do not mess with my tmux window names
export DISABLE_AUTO_TITLE=true

# God, this pause almost killed me
stty -ixon

# And vim mode in the zsh
bindkey -v
# With extra options
source ~/bin/vim-advanced-wordmotion/opp.zsh
source ~/bin/vim-advanced-wordmotion/opp/surround.zsh
source ~/bin/vim-visual.zsh
# Kill the stupid timeout
export KEYTIMEOUT=1

# Custom keybindings
bindkey "^S" clear-screen
bindkey "^B" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^F" vi-forward-blank-word
bindkey "^A" vi-add-eol
bindkey -s "^K" "" # Used for Window movement
bindkey "^T" autosuggest-execute-suggestion

# History like in GUI file managers (see functions)
zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey
# Great z programs
autoload -U zmv

# Awesome autocomplete like fish
# Load zsh-autosuggestions.
source ~/.zsh/plugins/zsh-autosuggestions/autosuggestions.zsh
# Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

# Colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;34m' \
    LESS_TERMCAP_me=$'\E[00;34m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[00;34m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[00;33m' \
    man "$@"
}

# Settings
# Follow symbolic links
CHASE_LINKS="true"

# aliases
source ~/.zsh/aliases
# functions
source ~/.zsh/functions

# Logo
alsi
