#! /bin/bash

wsp=`i3-msg -t get_workspaces | tr "}" "\n" | grep '"focused":true' | grep -o -E "[[:digit:]]" | head -1`
$@ &
while true; do
    if (~/.i3/py-scripts/wincurrent.py | grep -i "$1"); then
        if [[ $wsp !=  $(i3-msg -t get_workspaces | tr "}" "\n" | grep '"focused":true' | grep -o -E "[[:digit:]]" | head -1) ]]; then
            i3-msg move container to workspace $wsp
            break
        else
            break
        fi
    fi
done
exit 0
