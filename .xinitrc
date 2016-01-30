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
~/bin/keymapping/xcape -t 0 -e 'Caps_Lock=Escape' 
~/bin/keymapping/xcape -t 0 -e 'ISO_Level3_Shift=F10' 
~/bin/keymapping/xcape -t 0 -e 'Super_L=F11' 
~/bin/keymapping/xcape -t 0 -e 'Super_R=F12' 
~/bin/keymapping/xcape -t 0 -e 'Control_R=F12' 
# Disable touchpad while typing &
syndaemon -t -k -d -i 2 &
# Dont want to see the mouse
unclutter --timeout 1 -b
# Background
~/.fehbg &
# Volume notifier
volnoti -t 1.2
# Merge rofi settings
xrdb -load ~/.config/rofi/rofi &
# Music
mpd ~/.config/mpd/mpd.conf &
# Updates
~/bin/update &
# Devmon for usb
devmon --exec-on-drive 'rofi -show run -e "Mounted %f at %d"' --exec-on-remove "volnoti-show -n -s /usr/share/pixmaps/volnoti/media-eject-symbolic.svg 100" &
# Conky
~/.i3/conky.sh &
# WM
exec i3
