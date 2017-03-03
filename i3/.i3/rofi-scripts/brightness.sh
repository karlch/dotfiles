#!/bin/bash

selected_option=$(printf "0\n30\n50\n70\n100" | \
    rofi -dmenu -p "     " -i)

# Nothing selected
[[ -z "$selected_option" ]] && exit 0

sudo xbacklight -set "$selected_option"

# Refresh i3blocks
pkill -SIGRTMIN+11 i3blocks
