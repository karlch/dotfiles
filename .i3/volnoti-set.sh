#!/bin/bash
mute=`amixer -c 0 get Master | grep Mono | cut -d " " -f8`
vol=`amixer -c 0 get Master | grep Mono | cut -d " " -f6 | tr -d '[]' | tr -d '\n'`
if [ $mute == "[on]" ]
then
    volnoti-show $vol
else
    volnoti-show -s /usr/share/pixmaps/volnoti/volume_muted.svg $vol
fi

printf "%s\n%s\n" $vol $mute > ~/.i3/info/volume_info
