# Path to zsh folder
export ZSH=/home/christian/.zsh

# Settings
ZSH_THEME="lhun"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
CHASE_LINKS="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Plugins
plugins=(vi-mode clipboard zsh-history-substring-search sudo lscolors dot zsh-autosuggestions zsh-syntax-highlighting)

# Initialize the actual zsh script
source $ZSH/zsh.sh

# God, this pause almost killed me
stty -ixon

# Custom keybindings
bindkey '^A' vi-forward-blank-word
bindkey '^F' my-forward-word
bindkey '^E' my-backward-word
bindkey '^ ' autosuggest-accept
bindkey '^N' insert-cycledleft
bindkey '^P' insert-cycledright
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' push-line-or-edit
bindkey '^K' history-substring-search-up
#
# Normal mode
bindkey -M vicmd '\E' vi-beginning-of-line
bindkey -M vicmd ' ' vi-end-of-line
bindkey -M vicmd 'K' run-help
bindkey -M vicmd 'ä' vi-history-search-backward
bindkey -M vicmd 'ö' execute-named-cmd
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd '^S' vi-insert # Used for vimux run command to enter i-mode
#
# Completion menu
bindkey -M menuselect 'j' down-line-or-history
bindkey -M menuselect 'k' up-line-or-history
bindkey -M menuselect 'l' forward-char
bindkey -M menuselect 'h' backward-char
bindkey -M menuselect 'i' accept-and-infer-next-history
bindkey -M menuselect '+' accept-and-menu-complete

# Great z programs
autoload -U zmv
# Zcalc
autoload -U zcalc
# Surround
autoload -Uz surround
zle -N add-surround surround
bindkey -M vicmd 's' add-surround
bindkey -M visual 's' add-surround
autosuggest_start

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

# nice colors for VT
if [ "$TERM" = "linux" ]; then
    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
    for i in $(sed -n "$_SEDCMD" $HOME/.Xdefaults | \
               awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
        echo -en "$i"
    done
    clear
else
    # Tmux only automatically in X
    test -z ${TMUX} && exec tmux
fi

# Workaround for handling TERM variable in multiple tmux sessions properly
if [[ -n ${TMUX} && -n ${commands[tmux]} ]];then
    case $(tmux showenv TERM 2>/dev/null) in
        *256color) ;&
        TERM=fbterm)
            TERM=screen-256color ;;
        *)
            TERM=screen
    esac
fi

# Logo
alsi    # Logo with system information
marvin  # Marvin quotes
echo ""
