# vim:ft=zsh
# Set VIMODE according to the current mode, default is insert mode
function _vimode() {
    if [[ $KEYMAP == "vicmd" ]]; then
        echo "%{$fg[white]%}❮%{$fg[cyan]%}❮%{$fg[blue]%}❮ "
    else
        echo "%{$fg[white]%}❯%{$fg[cyan]%}❯%{$fg[blue]%}❯ "
    fi
}

zle -N zle-keymap-select

# Git information
function _gitinfo() {
    if [[ -n "$(git rev-parse HEAD 2>/dev/null)" ]]; then
        # Branch info (current branch, commits ahead and behind)
        local branchinfo=$(git branch -v | grep "*")
        local branch=$(printf "${branchinfo}" | awk '{print $2}')
        local branchstate=$(printf "${branchinfo}" | grep -o "\[.*\]")
        branchstate=${branchstate/ahead /↑}
        branchstate=${branchstate/behind /↓}
        branchstate=${branchstate/\[/}
        branchstate=${branchstate/\]/}
        # File info (untracked and unstaged files, number of changes)
        local fileinfo=$(git status --porcelain 2>/dev/null)
        local untracked=$(printf "${fileinfo}\n" | grep "^??" | wc -l)
        local unstaged=$(printf "${fileinfo}\n" | grep "^ M" | wc -l)
        local tocommit=$(printf "${fileinfo}\n" | grep "^M[M ]" | wc -l)
        local ins=$(git diff --numstat 2>/dev/null | awk '{sum+=$1} END {print sum}')
        local del=$(git diff --numstat 2>/dev/null | awk '{sum+=$2} END {print sum}')
        # Everything into one nicely formatted variable
        local GIT="%{$fg_bold[cyan]%}${branch} ${branchstate} "
        GIT+="%{$fg[white]%}C${tocommit} "
        GIT+="%{$fg[black]%}?${untracked} "
        GIT+="%{$fg[white]%}M${unstaged} "
        GIT+="(%{$FG[115]%}+${ins}%{$fg[white]%}/%{$fg[red]%}-${del}$reset_color) "
        # Print everything in multiple lines
        print -- "
${GIT}
%{$fg[red]%}${USER/#christian/}%{$reset_color%}"
    else
        # Only print a function (some output is necessary in line three of the
        # git prompt)
        print -- "%{$fg_no_bold[red]%}${USER/#christian/}%{$reset_color%}"
    fi
}

PROMPT='$(_gitinfo)%{$fg_bold[black]%}${PWD/#$HOME/~}%{$fg[white]%} %(?..%? )$(_vimode)%{$reset_color%}'
