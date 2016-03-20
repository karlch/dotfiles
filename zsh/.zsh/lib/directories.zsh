# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# List directory contents neatly
function ll() {
    ls -Aoh --group-directories-first --color=always --time-style "+%d.%m %H:%M" $* \
        | column -t
    ls -Aoh --group-directories-first --color=always --time-style "+%d.%m %H:%M" $* \
        | column -t | less -F
}
function l() {
    ls -oh --group-directories-first --color=always --time-style "+%d.%m %H:%M" $* \
        | column -t
    ls -oh --group-directories-first --color=always --time-style "+%d.%m %H:%M" $* \
        | column -t | less -F
}

function llo() {
    IFS=$'\n'
    for line in $(ls -Aoh --group-directories-first --color=always \
        --time-style "+%d.%m %H:%M" $* | column -t | tail -n +2 ) 
    do
        nicemod=$(echo $line | cut -d " " -f1 | chmod_format)
        line=$(echo $line | cut -d " " -f2-)
        echo "$nicemod $line"
    done
}
alias la='ls -A --group-directories-first'
