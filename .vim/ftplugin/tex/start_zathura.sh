#! /bin/bash

pdf=`ls | grep "pdf"`
if [[ $pdf ]]; then
    zathura &>/dev/null >/dev/null $pdf &
    while true; do
        if (~/.i3/py-scripts/wincurrent.py | grep -i "zathura"); then
            i3-msg -q resize shrink width 50 px or 10 ppt
            i3-msg -q focus left
            break
        fi
    done
fi
