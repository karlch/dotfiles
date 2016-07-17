#!/bin/sh
brightness=$(xbacklight -get)
brightness=${brightness%.*}

volnoti-show -s "/usr/share/pixmaps/volnoti/display-brightness-symbolic.svg" ${brightness}
