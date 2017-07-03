#!/bin/bash
tex=$(ls | grep $1)
pdf=${1%.*}.pdf

start_zathura() {
    if [[ $tex ]]; then
        if !(xdotool search --onlyvisible --class "Zathura"); then
            zathura $pdf &
            while true; do
                curwin=$(xdotool getactivewindow)
                if (xprop -id $curwin | grep -i "wm_class.*zathura"); then
                    i3-msg -q resize shrink width 50 px or 10 ppt
                    i3-msg -q focus left
                    break
                fi
            done
        else
            zathura --synctex-forward ${2}:1:${1} ${pdf}
        fi
    fi
}

start_zathura $1 $2 > /dev/null 2>&1
