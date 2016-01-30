#!/bin/bash

outputs=$(xrandr | grep " connected" | awk '{print $1}' | grep -v "eDP1")
if [[ $outputs ]]; then
    monitor=$(echo $outputs | rofi -dmenu -p Monitors: $*)
    options="left\nsame\nright\noff"
    opt=$(printf $options | rofi -dmenu -p Options $*)
    if [[ $opt == "left" ]]; then
        xrandr --output $monitor --auto --left-of eDP1
    elif [[ $opt == "right" ]]; then
        xrandr --output $monitor --auto --right-of eDP1
    elif [[ $opt == "same" ]]; then
        xrandr --output $monitor --auto --same-as eDP1
    elif [[ $opt == "off" ]]; then
        xrandr --output $monitor --off
    fi
else
    rofi -show run -e "No external monitor connected"
fi
