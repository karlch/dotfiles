#!/bin/bash

# Direction
if [[ $1 == "h" ]]; then
    dir="left"
    Dir="Left"
    tdir="-L"
    nowrap() {
        if [[ $cur == $prev ]]; then
            i3-msg -q focus left
        elif [[ $cur > $prev ]]; then
            tmux select-pane -l
            i3-msg -q focus left
        fi
    }
elif [[ $1 == "j" ]]; then
    dir="down"
    Dir="Down"
    tdir="-D"
    nowrap() {
        if [[ $cur == $prev ]]; then
            i3-msg -q focus down
        elif [[ $cur < $prev ]]; then
            tmux select-pane -l
            i3-msg -q focus down
        fi
    }
elif [[ $1 == "k" ]]; then
    dir="up"
    Dir="Up"
    tdir="-U"
    nowrap() {
        if [[ $cur == $prev ]]; then
            i3-msg -q focus up
        elif [[ $cur > $prev ]]; then
            tmux select-pane -l
            i3-msg -q focus up
        fi
    }
elif [[ $1 == "l" ]]; then
    dir="right"
    Dir="Right"
    tdir="-R"
    nowrap() {
        if [[ $cur == $prev ]]; then
            i3-msg -q focus right
        elif [[ $cur < $prev ]]; then
            tmux select-pane -l
            i3-msg -q focus right
        fi
    }
fi

curwin=$(xdotool getactivewindow)
if (xprop -id $curwin | grep "tmux" > /dev/null); then
    prev=`tmux display-message -p '#P'`
    if [[ $2 == "v" ]]; then
        tmux select-pane $tdir
    else
        tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys $Dir && exit 0 || tmux select-pane $tdir || :
    fi
    cur=`tmux display-message -p '#P'`

    nowrap
else
    i3-msg -q focus $dir
fi
