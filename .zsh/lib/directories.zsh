# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'

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


# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'
