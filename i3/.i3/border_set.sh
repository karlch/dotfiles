#!/bin/bash

# Get current border width
width=$(i3-msg -t get_tree | tr "}" "\n"  | grep '"focused":true' | \
            tr "," "\n" | grep "current_border_width" | cut -d ":" -f2)
# Correct pixel width for hidpi screens
dpi=$(xdpyinfo | awk '/resolution/ {print $2}' | cut -d "x" -f2)
if [[ $dpi -gt 150 ]]; then (( width /= 2 )); fi

# Do correct adjustment
if [[ $1 == "+" ]]; then
    (( width++ ))
elif [[ $1 == "-" ]]; then
    (( width-- ))
else
    width=$(seq 0 20 | rofi -dmenu -p "borderwidth: " -columns 21 -lines 1)
fi

i3-msg border pixel $width
