#!/bin/bash

# Check what to do
if [[ -n $1 ]]; then
    amixer set Master 5%${1}
else
    amixer set Master toggle
fi

vol=$(amixer -c 0 get Master | grep Mono | cut -d " " -f6 | tr -d '[]' | tr -d '\n' | tr -d '%')
mute=$(amixer -c 0 get Master | grep Mono | cut -d " " -f8)

# Get correct icon name
if [ $mute == "[on]" ]; then
    if [[ $vol -lt 33  ]]; then
        icon="volume_low"
    elif [[ $vol -lt 66  ]]; then
        icon="volume_medium"
    else
        icon="volume_high"
    fi
else
    icon="volume_muted"
fi

# Display notification
dunstify -i ~/Images/Inkscape/audio_icons/$icon.png -r 42 -t 1 "Volume" $vol" %"

# Refresh i3blocks
pkill -SIGRTMIN+11 i3blocks
