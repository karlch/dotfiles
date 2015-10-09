#! /bin/bash

if (~/.i3/py-scripts/wincurrent_title.py | grep "tmux" > /dev/null); then
    prev=`tmux display-message -p '#P'`
    tmux select-pane -U
    cur=`tmux display-message -p '#P'`

    if [[ $cur == $prev ]]; then
        i3-msg -q focus up
    elif [[ $cur > $prev ]]; then
        tmux select-pane -l
        i3-msg -q focus up
    fi
else
    i3-msg -q focus up
fi
