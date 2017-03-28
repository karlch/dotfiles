#!/bin/bash

# First line is empty so shutdown is not selected accidentally
selected_option=$(printf "
     Shutdown
     Reboot
     Logout
     Suspend
      Lock\n" | rofi -dmenu -l 6 -p "" -i)

case $selected_option in
    *"Shutdown" ) poweroff;;
    *"Reboot" ) reboot;;
    *"Logout" ) i3-msg exit;;
    *"Suspend" ) systemctl suspend;;
    *"Lock" ) convert x:root -resize 192x108 /tmp/.i3lock.png
        mogrify -resize 1920x1080 /tmp/.i3lock.png
        i3lock -O 0.1 -T 1.0 -i /tmp/.i3lock.png -R 260 -F 100 \
        -w "#99C794" -o "#EC5F67" -l "#6699CC" \
        --24 --no-keyboard-layout;;
esac
