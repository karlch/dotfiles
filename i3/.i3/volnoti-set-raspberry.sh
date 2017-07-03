#!/bin/bash

# Update volume
mpc volume ${1}2
# Get current value
vol=$(mpc volume | awk '{print $2}' | tr -d "%")
# Display notification
dunstify -i ~/Images/Inkscape/audio_icons/raspberry_small.png -r 43 -t 1 "Volume Pi" $vol" %"
# Print to info file for any other displaying purposes
printf "%s\n" $vol > ~/.i3/info/volume_info_raspberry
