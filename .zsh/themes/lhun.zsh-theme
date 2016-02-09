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

function gitinfo() {
    (git symbolic-req -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

function gitstring() {
    if [[ -z $(gitinfo) ]]; then
        printf ""
    else
        printf " [%s]" $(gitinfo)
    fi
}

PROMPT='%{$fg[blue]%}%n %{$fg[green]%}%~%{$fg[white]%}$(gitstring)%(?..%? ) %{$fg[blue]%}$(vimode)%{$reset_color%}'
