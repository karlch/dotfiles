#!/bin/bash

selected_option=$(printf "     Wifi Menu\n     Block\n    Unblock" | \
    rofi -dmenu -p "     " -i)

case $selected_option in
    *"Wifi Menu" ) st -n floating -e sudo wifi-menu;;
    *"Block" ) rfkill block wifi;;
    *"Unblock" ) rfkill unblock wifi && \
        st -n floating -e systemctl restart netctl-auto@wlp1s0.service;;
esac
