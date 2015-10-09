#! /bin/bash

if (~/.i3/py-scripts/wincurrent_title.py | grep "tmux" > /dev/null); then
    prev=`tmux display-message -p '#P'`
    tmux select-pane -L
    cur=`tmux display-message -p '#P'`

    if [[ $cur == $prev ]]; then
        i3-msg -q focus left
    elif [[ $cur > $prev ]]; then
        tmux select-pane -l
        i3-msg -q focus left
    fi
else
    i3-msg -q focus left
fi
