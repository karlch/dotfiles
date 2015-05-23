# Path to your oh-my-zsh installation.
export ZSH=/home/christian/.zsh

# Set name of the theme to load.
ZSH_THEME="lhun"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode dircycle jump archlinux)

# User configuration

export VISUAL=vim
export EDITOR=vim
export PATH=$PATH:~/bin
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Do not mess with my tmux window names
export DISABLE_AUTO_TITLE=true

# cd, no thank you
setopt AUTO_CD

# God, this pause almost killed me
stty -ixon

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Vim as editor
export EDITOR='vim'
export TERMCMD='gnome-terminal'
# And vim mode in the zsh
bindkey -v
# With extra options
source ~/bin/vim-advanced-wordmotion/opp.zsh
source ~/bin/vim-advanced-wordmotion/opp/surround.zsh
source ~/bin/vim-visual.zsh
# Kill the stupid timeout
export KEYTIMEOUT=1

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Custom keybindings
bindkey "^S" clear-screen
bindkey "^A" vi-beginning-of-line
bindkey -s "^B" ""
bindkey "^E" vi-end-of-line
bindkey -s "^F" "" # Used as Tmux starter
bindkey -s "^K" "" # Used for Window movement
bindkey -s "^T" ""

# Custom commands
mkcd(){ mkdir "$1" && cd "$1" ; }
listjpg(){ autoload -U zmv && c=1 base="$1" zmv '*.JPG||*.jpg' '${base}_${(l:3::0:)$((c++))}.jpg' ; }
listall(){ autoload -U zmv && c=1 base="$1" end="$2" zmv '*' '${base}_${(l:3::0:)$((c++))}.${end}' ; }

# Colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[01;32m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[01;32m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# aliases
source ~/.zsh_aliases

# Logo
archey3
