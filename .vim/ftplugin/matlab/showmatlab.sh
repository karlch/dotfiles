#! /bin/bash

while true; do
    if (~/.i3/py-scripts/wincurrent.py | grep -i "matlab"); then
        i3-msg -q reload
        break
    fi
done
