#!/bin/sh
brightness=$(xbacklight)
brightness=${brightness%.*}

volnoti-show -s "/usr/share/pixmaps/volnoti/brightness.png" ${brightness}
