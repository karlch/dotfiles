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

function _short_user() {
    user=$(whoami)
    if [[ ${user} != "christian" ]]; then
        printf "${user} "
    fi
}

zle -N zle-keymap-select


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

PROMPT='%{$fg[red]%}$(_short_user)%{$fg[blue]%}%~%{$fg[white]%} %(?..%? )%{$fg[green]%}$(_vimode)%{$reset_color%}'
