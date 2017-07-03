#!/bin/bash

selected_option=$(printf "     Network Manager\n     Restart\n     Block\n    Unblock" | \
    rofi -dmenu -p "     " -i)

case $selected_option in
    *"Network Manager" ) st -n floating -e nmtui;;
    *"Restart" ) st -n floating -e systemctl restart NetworkManager.service;;
    *"Block" ) rfkill block wifi;;
    *"Unblock" ) rfkill unblock wifi ;;
esac
