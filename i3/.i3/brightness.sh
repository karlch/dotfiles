#!/bin/sh

if [[ $1 == "dec" ]]; then
    sudo xbacklight -dec 5
else
    sudo xbacklight -inc 5
fi

brightness=$(xbacklight -get)


dunstify -i ~/Images/Inkscape/audio_icons/brightness.png -r 44 -t 1 "Brightness" $brightness" %"

# Refresh i3blocks
pkill -SIGRTMIN+11 i3blocks
