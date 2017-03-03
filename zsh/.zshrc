# Check for VT immediately to start tmux as early as possible
if [ "$TERM" = "linux" ]; then
    # Nice colors for VT
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

# Path to zsh folder
export ZSH=~/.zsh

# Path for rubygems
export PATH=$PATH:~/.gem/ruby/2.4.0/bin
# Settings
ZSH_THEME="lhun"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
CHASE_LINKS="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Plugins
plugins=(vi-mode zsh-history-substring-search sudo lscolors dot zsh-autosuggestions zsh-syntax-highlighting clipboard)

# Initialize the actual zsh script
source $ZSH/zsh.sh
# ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=("expand-or-complete")
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=("my-forward-word")

# God, this pause almost killed me
stty -ixon

# Custom keybindings
bindkey '^A' vi-forward-blank-word
bindkey '^F' my-forward-word
bindkey '^E' my-backward-word
bindkey '^ ' autosuggest-execute
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' push-line-or-edit
bindkey '^K' history-substring-search-up
bindkey '^?' backward-delete-char  # Backspace over everything in insert mode
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
bindkey -M menuselect '\E' accept-line

# Great z programs
autoload -U zmv
# Zcalc
autoload -U zcalc

# Colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;30;03;37m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Fasd
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install \
    zsh-wcomp zsh-wcomp-install)"

# Logo
alsi    # Logo with system information
my_fortune marvin
echo ""
