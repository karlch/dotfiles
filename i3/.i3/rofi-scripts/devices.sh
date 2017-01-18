#!/bin/bash

selected_option=$(printf "     Mount\n     Unmount" | \
    rofi -dmenu -p "     " -i)

mount_device() {
    # Populate list of mountable devices
    device=$(find /dev/ -name "sd[b-z][0-9]" | rofi -dmenu -p "     " -i)
    # Empty
    [[ -z $device ]] && return
    info=$(udevil mount "$device" 2>&1)
    notify-send -i hdd_unmount "Mount" "$info"
}

umount_device() {
    # Populate list of unmountable devices
    device=$(findmnt -Do "SOURCE,TARGET" | grep "sd[b-z][0-9]" |
        rofi -dmenu -p "     " -i | cut -d " " -f1)
    # Empty
    [[ -z $device ]] && return
    # Notifications are handled with udevil directly, only check for failure
    udevil umount "$device" || notify-send -i hdd_unmount "Umount" "Failed"
}

case $selected_option in
    *"Mount" ) mount_device;;
    *"Unmount" ) umount_device;;
esac
