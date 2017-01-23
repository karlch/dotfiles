#!/bin/sh
brightness=$(xbacklight -get)

volnoti-show -s "/usr/share/pixmaps/volnoti/display-brightness-symbolic.svg" "$brightness"

# Refresh i3blocks
pkill -SIGRTMIN+11 i3blocks
