#! /bin/bash

i3-msg -q focus right

if [[ $(~/.i3/py-scripts/wincurrent.py) == Zathura ]]; then
    i3-msg -q kill
fi
