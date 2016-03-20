# Toggle sudo before command
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history && runlast="1"
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
    # Run it automatically if it works on the last history
    if [[ $runlast ]]; then
        zle accept-line
    # Else jump to the end of line
    else
        zle vi-add-eol
    fi
}
zle -N sudo-command-line
# Bind it to "!" in vi normal mode
bindkey -M vicmd "!" sudo-command-line
