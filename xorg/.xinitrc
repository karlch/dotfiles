#!/bin/sh

# Run all shell scripts in /etc/X11/xinit/xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# No screen blanking
xset s off -dpms

setup_main_session() {
    # Wallpaper
    hsetroot -cover ~/Images/Background/background &
    # Keyboard
    setxkbmap de
    setxkbmap -variant nodeadkeys
    xcape -t 500 -e 'Caps_Lock=Escape;ISO_Level3_Shift=F10;Super_L=F11;Control_R=F12'
    # Screen
    xrandr --output e-DP1 --mode 3840x2160 --dpi 192
    xrandr --output e-DP1 --primary
    export GDK_DPI_SCALE=2
    # Daemons
    redshift &
    dunst &
    unclutter --timeout 1 -b
    volnoti -t 2.0 -a 0.2 -r 100
    devmon --exec-on-drive 'notify-send "Mounted %l %f at %d"' --exec-on-unmount 'notify-send "Succesfully unmounted %l from %f"' &
    ~/bin/xrandr_daemon &
    export MPD_HOST=alarmpi
    ~/bin/notify_mpd &
}

# Get session
session=${2:-i3}

# Run the session
case $session in
    i3) setup_main_session && exec i3 ;;
    vb) exec VirtualBox ;;
    *)  exec $session ;;
esac
