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
plugins=(vi-mode dircycle jump ubuntu)

# User configuration

export PATH="/home/christian/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
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

# Aliases
# my bash aliases here as well
source ~/.bash_aliases
# handy ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# source this file quickly
alias sz='source ~/.zshrc'
alias vim='vim --servername VimServer'
alias v='vim --servername VimServer'
alias vima='vim --servername VimServer --remote-tab'
# everyone need some fun
alias chuck='fortune ~/bin/fortune/chucknorris | cowsay'
