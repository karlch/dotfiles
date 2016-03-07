#!/bin/sh

# Run all shell scripts in /etc/X11/xinit/xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# No screen blanking
xset -dpms &
# Keyboard
setxkbmap -option 'caps:ctrl_modifier' 
setxkbmap de-ck 
setxkbmap -variant nodeadkeys 
xcape -t 0 -e 'Caps_Lock=Escape' 
xcape -t 0 -e 'ISO_Level3_Shift=F10' 
xcape -t 0 -e 'Super_L=F11' 
xcape -t 0 -e 'Super_R=F12' 
xcape -t 0 -e 'Control_R=F12' 
# Disable touchpad while typing
syndaemon -k -d -i 1 &
# Dont want to see the mouse
unclutter --timeout 1 -b
# Background
hsetroot -solid '#0C0C0C' &
# Volume notifier
volnoti -t 1.2
# Merge rofi settings
xrdb -load ~/.config/rofi/rofi &
# Music
export MPD_HOST="192.168.0.10"
# Updates
~/bin/update &
# Devmon for usb
devmon --exec-on-drive 'rofi -show run -e "Mounted %f at %d"' --exec-on-remove "volnoti-show -n -s /usr/share/pixmaps/volnoti/media-eject-symbolic.svg 100" &
# Conky
conky &
# Urxvt daemon
urxvtd -f -o -q
# Clipboard manager
~/bin/clipmenud &
# Urgency hint when a window changes name
~/.i3/py-scripts/ipc/urgencyhint.py &
# WM
exec i3
