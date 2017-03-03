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
    *"Lock" ) convert x:root -blur 0x10 /tmp/.i3lock.png && \
        i3lock -O 0.3 -T 1.0 -i /tmp/.i3lock.png -R 130 -F 50 \
        -w "#CCCCCC" -o "#8787AF" -l "6B93BB" --24 --no-keyboard-layout;;
esac
