SEPCHARS='[/ ]'

my-forward-word() {
    if [[ "${BUFFER[CURSOR + 1]}" =~ "${SEPCHARS}" ]]; then
        (( CURSOR += 1 ))
        return
    fi
    while [[ CURSOR -lt "${#BUFFER}" && ! "${BUFFER[CURSOR + 1]}" =~ "${SEPCHARS}" ]]; do
        (( CURSOR += 1 ))
    done
    (( CURSOR += 1 ))
}

zle -N my-forward-word

my-backward-word() {
    if [[ "${BUFFER[CURSOR]}" =~ "${SEPCHARS}" ]]; then
        (( CURSOR -= 1 ))
        return
    fi
    while [[ CURSOR -gt 0 && ! "${BUFFER[CURSOR]}" =~ "${SEPCHARS}" ]]; do
        (( CURSOR -= 1 ))
    done
    (( CURSOR -= 1 ))
}

zle -N my-backward-word
