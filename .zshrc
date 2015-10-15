# Path to zsh folder
export ZSH=/home/christian/.zsh

# Set name of the theme to load.
ZSH_THEME="lhun2"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Plugins
plugins=(dircycle vi-mode clipboard zsh-history-substring-search)

# Standard Exports
export VISUAL=vim
export EDITOR=vim
export PATH=$PATH:~/bin
export CDPATH=".:/home/christian:.."
export TERMINAL=urxvt
export TERMCMD=urxvt
export LESSHISTFILE=/dev/null
export BROWSER=elinks
export MANWIDTH=80
export CACA_DRIVER=ncurses

# All main settings
source $ZSH/zsh.sh

# Do not mess with my tmux window names
export DISABLE_AUTO_TITLE=true

# God, this pause almost killed me
stty -ixon

# And vim mode in the zsh
bindkey -v
# Kill the stupid timeout
export KEYTIMEOUT=1

# Custom keybindings
bindkey "^S" clear-screen
bindkey -s "^K" "" # Used for Window movement
bindkey "^A" vi-forward-blank-word
bindkey "^F" my-forward-word
bindkey "^E" my-backward-word
bindkey "^ " autosuggest-execute-suggestion
bindkey "^N" insert-cycledleft
bindkey "^P" insert-cycledright
# bindkey -s "ä" "/"
# Normal mode
bindkey -M vicmd "\E" vi-beginning-of-line
bindkey -M vicmd " " vi-end-of-line
bindkey -M vicmd "K" run-help
bindkey -M vicmd "ä" vi-history-search-backward
bindkey -M vicmd "ö" execute-named-cmd
bindkey -M vicmd "s" quote-region
bindkey -M vicmd "S" quote-line
bindkey -M vicmd "j" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
# Completion menu
bindkey -M menuselect "j" down-line-or-history
bindkey -M menuselect "k" up-line-or-history
bindkey -M menuselect "l" forward-char
bindkey -M menuselect "h" backward-char
bindkey -M menuselect "i" accept-and-infer-next-history

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
marvin
echo ""
