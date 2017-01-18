#!/bin/bash

default="eDP-1"
output=$(xrandr | awk '/ connected/ && !/eDP-1/ {print $1}' | \
    rofi -dmenu -p "     " -i)

# Nothing selected
[[ -z $output ]] && exit 0

# What to do
selected_option=$(printf "     Left\n     Same\n     Right\n     Off\n" | \
    rofi -dmenu -p "     " -i)

case $selected_option in
    *"Left" ) xrandr --output "$output" --auto --left-of "$default";;
    *"Same" ) xrandr --output "$output" --auto --same-as "$default";;
    *"Right" ) xrandr --output "$output" --auto --right-of "$default";;
    *"Off" ) xrandr --output "$output" --off;;
esac
