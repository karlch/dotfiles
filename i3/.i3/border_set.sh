#!/bin/bash

width=$(i3-msg -t get_tree | tr "}" "\n"  | grep '"focused":true' | \
            tr "," "\n" | grep "current_border_width" | cut -d ":" -f2)

if [[ $1 == "+" ]]; then
    if [[ $width -lt 21 ]]; then (( width++ )); fi
elif [[ $1 == "-" ]]; then
    if [[ $width -gt 0 ]]; then (( width-- )); fi
else
    width=$(seq 0 20 | rofi -dmenu -p "borderwidth: " -columns 21 -lines 1)
fi

i3-msg border pixel $width
