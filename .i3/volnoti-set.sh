#!/bin/bash

virtual=""
# Check what to do
if [[ -n $1 ]]; then
    mute=$(amixer -c 0 get Master | grep Mono | cut -d " " -f8)
    if [ $mute == "[off]" ]; then
        echo "mpc"
        # Change volume of mpd if normal volume is muted
        mpc volume ${1}1
        vol=$(mpc volume | awk '{print $2}' | tr "%" "v")
        virtual="mpc"
        volnoti-show -s /usr/share/pixmaps/volnoti/raspberry.png $vol
    else
        amixer set Master 5%${1}
        vol=$(amixer -c 0 get Master | grep Mono | cut -d " " -f6 | tr -d '[]' | tr -d '\n')
    fi
else
    amixer set Master toggle
    mute=$(amixer -c 0 get Master | grep Mono | cut -d " " -f8)
    vol=$(amixer -c 0 get Master | grep Mono | cut -d " " -f6 | tr -d '[]' | tr -d '\n')
fi

# Read from conkybar
if [[ $virtual == "mpc" ]]; then
    printf "%s\n%s\n" $vol "no" > ~/.i3/info/volume_info
else
    printf "%s\n%s\n" $vol $mute > ~/.i3/info/volume_info
    # Display volnoti information
    if [ $mute == "[on]" ]
    then
        volnoti-show $vol
    else
        volnoti-show -s /usr/share/pixmaps/volnoti/volume_muted.svg $vol
    fi
fi
