#!/bin/bash

mute=`amixer -c 0 get Master | grep Mono | cut -d " " -f8`
if [ $mute == "[on]" ]
then
    echo 1
else
    echo 0
fi
