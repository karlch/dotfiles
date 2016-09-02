#!/bin/bash

mpc volume ${1}2
vol=$(mpc volume | awk '{print $2}' | tr "%" "v")
volnoti-show -s /usr/share/pixmaps/volnoti/raspberry.png $vol
printf "%s\n" $vol $mute > ~/.i3/info/volume_info_raspberry
