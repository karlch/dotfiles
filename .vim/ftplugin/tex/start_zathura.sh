#!/bin/bash

tex=$(ls | grep ".tex$")
pdf=${tex%.*}.pdf
if [[ $tex ]]; then
    if !(xdotool search --onlyvisible --class "Zathura"); then
        zathura > /dev/null 2>&1 $pdf &
        while true; do
            curwin=$(xdotool getactivewindow)
            if (xprop -id $curwin | grep -i "wm_class.*zathura"); then
                i3-msg -q resize shrink width 50 px or 10 ppt
                i3-msg -q focus left
                break
            fi
        done
    fi
    zathura --synctex-forward ${1}:1:${tex} ${pdf}
fi
