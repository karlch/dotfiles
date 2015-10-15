# Set VIMODE according to the current mode, default is i
function vimode() {
    mode=$(echo "${${KEYMAP/vicmd/<< }/(main|viins)/>> }")
    if [[ $mode == "" ]]; then
        echo ">> "
    else
        echo $mode
    fi
}

zle -N zle-keymap-select

PROMPT='%{$fg[blue]%}%n %{$fg[green]%}%~ %{$fg[blue]%}$(vimode)%{$reset_color%}'
RPROMPT=''
