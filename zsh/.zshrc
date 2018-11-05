# Tmux automatically in X
if [ "$TERM" != "linux" ]; then
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
plugins=(vi-mode sudo dot clipboard lscolors)
source $ZSH/zsh.sh  # Initialize plugins, theme and co.
# Plugins with antigen
source /usr/share/zsh/share/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply
source $ZSH/misc/my_highlighters.zsh

# Accept autosuggested word with ^F with slightly different word separators
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=("my-forward-word")

# God, this pause almost killed me
stty -ixon

# Custom keybindings
bindkey '^F' my-forward-word
bindkey '^ ' autosuggest-execute
bindkey '^K' history-substring-search-up # I always hit this accidentally
bindkey '^S' push-line-or-edit
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
autoload -U zmv zcalc

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
alsi
my_fortune marvin
echo ""
