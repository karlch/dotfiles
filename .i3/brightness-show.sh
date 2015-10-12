#!/bin/sh
brightness=$(xbacklight)
brightness=${brightness%.*}

volnoti-show -s "/usr/share/pixmaps/volnoti/display-brightness-symbolic.svg" ${brightness}
