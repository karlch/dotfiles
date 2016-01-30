# Copy and paste to xclipboard

# Copy
copy-to-xsel() {
    zle vi-yank
    print -rn -- $CUTBUFFER | xsel -i -b
}
zle -N copy-to-xsel
bindkey -M vicmd "y" copy-to-xsel

# Paste
paste-xsel() {
    RBUFFER=$(xsel -o -b </dev/null)$RBUFFER
}
zle -N paste-xsel
bindkey -M vicmd "p" paste-xsel

# Delete
delete-to-xsel() {
    zle vi-delete
    print -rn -- $CUTBUFFER | xsel -i -b
}
zle -N delete-to-xsel
bindkey -M vicmd "d" delete-to-xsel

# Change
change-to-xsel() {
    zle vi-change
    print -rn -- $CUTBUFFER | xsel -i -b
}
zle -N change-to-xsel
bindkey -M vicmd "c" change-to-xsel

# Char
char-to-xsel() {
    zle vi-delete-char
    print -rn -- $CUTBUFFER | xsel -i -b
}
zle -N char-to-xsel
bindkey -M vicmd "x" char-to-xsel
