#!/bin/bash

# Check what to do
if [[ -n $1 ]]; then
    amixer set Master 5%${1}
else
    amixer set Master toggle
fi

vol=$(amixer -c 0 get Master | grep Mono | cut -d " " -f6 | tr -d '[]' | tr -d '\n' | tr -d '%')
mute=$(amixer -c 0 get Master | grep Mono | cut -d " " -f8)

# Read from conkybar
printf "%s\n%s\n" $vol $mute > ~/.i3/info/volume_info
# Display volnoti information
if [ $mute == "[on]" ]
then
    volnoti-show $vol
else
    volnoti-show -s /usr/share/pixmaps/volnoti/volume_muted.svg $vol
fi
