#!/bin/bash

# Update volume
mpc volume ${1}5
# Get current value
vol=$(mpc volume | cut -d ":" -f2 | tr -d "%")
# Display notification
dunstify -i ~/Images/Inkscape/audio_icons/raspberry_small.png -r 43 -t 1500 "Volume Pi" $vol" %"
# Print to info file for any other displaying purposes
printf "%s\n" $vol > ~/.i3/info/volume_info_raspberry
