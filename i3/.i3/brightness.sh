#!/bin/sh

if [[ $1 == "dec" ]]; then
    sudo xbacklight -dec 5
else
    sudo xbacklight -inc 5
fi

brightness=$(xbacklight -get)

volnoti-show -s "/usr/share/pixmaps/volnoti/display-brightness-symbolic.svg" "$brightness"

# Refresh i3blocks
pkill -SIGRTMIN+11 i3blocks
