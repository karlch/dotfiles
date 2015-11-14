#!/bin/bash

curwin=$(xdotool getactivewindow)
if (xprop -id $curwin | grep "tmux" > /dev/null); then
    prev=`tmux display-message -p '#P'`
    echo $prev
    xdotool click 1 
    sleep 1
    cur=`tmux display-message -p '#P'`
    echo $cur
    if [[ $cur != $prev ]]; then
        tmux select-pane -l
    fi
fi
exit 0
