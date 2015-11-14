# ls colors
autoload -U colors && colors
export LS_COLORS='di=1;34:fi=0:ln=35:pi=5:so=5:bd=5:cd=5:or=31:mi=31:ex=32:*.rpm=90'

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty --group-directories-first' || alias ls='ls -G'
fi

setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevars

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

# Apply theming defaults
PS1="%n@%m:%~%# "

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="git:("         # Prefix at the very beginning of the prompt, before the branch name
ZSH_THEME_GIT_PROMPT_SUFFIX=")"             # At the very end of the prompt
ZSH_THEME_GIT_PROMPT_DIRTY="*"              # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_CLEAN=""               # Text to display if the branch is clean

# Setup the prompt with pretty colors
setopt prompt_subst
