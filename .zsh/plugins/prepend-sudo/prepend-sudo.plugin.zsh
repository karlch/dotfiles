# Insert "sudo " at the beginning of the line
function prepend-sudo {
    if [[ $BUFFER == "" ]]; then
        zle history-substring-search-up
        runlast="1"
    fi
    if [[ $BUFFER != "sudo "* ]]; then
        BUFFER="sudo $BUFFER"
    fi
    BUFFER=$(echo $BUFFER | sed "s/&&/& sudo/g")
    if [[ $runlast ]]; then
        zle accept-line
    else
        zle vi-add-eol
    fi
}
zle -N prepend-sudo
bindkey -M vicmd "!" prepend-sudo
