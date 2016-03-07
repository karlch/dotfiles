# vim:ft=zsh
# Set VIMODE according to the current mode, default is i
function _vimode() {
    mode=$(echo "${${KEYMAP/vicmd/<< }/(main|viins)/>> }")
    if [[ $mode == "" ]]; then
        echo ">> "
    else
        echo $mode
    fi
}

zle -N zle-keymap-select

PROMPT='%{$fg[blue]%}%n %{$fg[green]%}%~%{$fg[white]%} %(?..%? )%{$fg[blue]%}$(_vimode)%{$reset_color%}'

# Git information
function _gitinfo() {
    if [[ -n "$(git rev-parse HEAD 2>/dev/null)" ]]; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        files=$(git diff --numstat 2>/dev/null | wc -l)
        ins=$(git diff --numstat 2>/dev/null | awk '{sum+=$1} END {print sum}')
        del=$(git diff --numstat 2>/dev/null | awk '{sum+=$2} END {print sum}')
        print -- "@%F{4}${branch} %f${files} changed (%F{46}+${ins}%f/%F{1}-${del}%f)"
    else
        printf ""
    fi
}

RPROMPT='$(_gitinfo)'
