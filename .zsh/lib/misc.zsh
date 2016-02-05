## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## jobs
setopt long_list_jobs

# ls colors
autoload -U colors && colors
export LS_COLORS='di=1;34:fi=0:ln=35:pi=5:so=5:bd=5:cd=5:or=31:mi=31:ex=32:*.rpm=90'

# Enable ls colors
alias ls='ls --color=tty --group-directories-first'

setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevars

# Setup the prompt with pretty colors
setopt prompt_subst
