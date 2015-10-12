# Copy and paste to xclipboard

copy-to-xclip() {
    [[ "$REGION_ACTIVE" -ne 0 ]] && zle copy-region-as-kill
    print -rn -- $CUTBUFFER | xclip -selection clipboard -i
}

zle -N copy-to-xclip
bindkey -M vicmd "Y" copy-to-xclip

paste-xclip() {
    killring=("$CUTBUFFER" "${(@)killring[1,-2]}")
    CUTBUFFER=$(xclip -selection clipboard -o)
    zle yank
}

zle -N paste-xclip
bindkey -M vicmd "P" paste-xclip
