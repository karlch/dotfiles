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
    *"Lock" ) optirun i3lock -O 0.3 -T 0.7 -i ~/Images/Background/Lock.png \
        -R 160 -F 80 -w "#99C794" -o "#EC5F67" -l "#F99157" \
        --24 --no-keyboard-layout;;
esac
