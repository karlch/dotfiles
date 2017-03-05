# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# List directory contents neatly
function ll() {
    ls -Aoh --group-directories-first --color=always --time-style "+%d.%m %H:%M" $* \
        | column -t
    ls -Aoh --group-directories-first --color=always --time-style "+%d.%m %H:%M" $* \
        | column -t | less -F
}

alias la='ls -A --group-directories-first'
