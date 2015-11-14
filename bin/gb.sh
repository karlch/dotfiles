#!/bin/bash

setxkbmap us
xmodmap -e "keycode 37 = BackSpace"
xmodmap -e "keycode 94 = Return"
xmodmap -e "keycode 108 = F10"
