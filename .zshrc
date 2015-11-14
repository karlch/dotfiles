# Path to zsh folder
export ZSH=/home/christian/.zsh

# Set name of the theme to load.
ZSH_THEME="lhun2"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Plugins
plugins=(dircycle vi-mode clipboard zsh-history-substring-search prepend-sudo)

# All main settings
source $ZSH/zsh.sh


# God, this pause almost killed me
stty -ixon

# And vim mode in the zsh
bindkey -v

# Custom keybindings
bindkey "^S" clear-screen
bindkey -s "^K" "" # Used for Window movement
bindkey "^A" vi-forward-blank-word
bindkey "^F" my-forward-word
bindkey "^E" my-backward-word
bindkey "^ " autosuggest-execute-suggestion
bindkey "^N" insert-cycledleft
bindkey "^P" insert-cycledright
bindkey "^T" autosuggest-toggle
bindkey "^R" history-incremental-pattern-search-backward
#
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
bindkey -M menuselect "+" accept-and-menu-complete

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

# nice colors for VT
if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | \
               awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
fi

# Logo
alsi
marvin
echo ""
