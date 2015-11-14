#! /bin/bash

while true; do
    # Sleep a little after each run, saves cpu ;D
    sleep 0.5
    # Is a song selected in cmus?
    if (cmus-remote -Q | grep "status playing") || (cmus-remote -Q | grep "status paused"); then
        # Folder of the current song
        folder=`cmus-remote -Q | grep file | cut -d ' ' -f2- | cut -d '/' -f1-6`
        # Already there? -> Album cover already open
        if [[ $folder == $(pwd) ]]; then
            true 
            echo "nothing to do"
        else
            i3-msg [title="sxiv - cover.jpg"] kill
            cd $folder
            echo "working"
            # Cmus the selected window?
            if (xprop -name "cmus" | grep "window state: Normal"); then
                sxiv -b cover.jpg &
                # Resize as soon as sxiv is focused
                while true; do
                    if (~/.i3/py-scripts/wincurrent.py | grep "Sxiv"); then
                        i3-msg focus left
                        break
                    fi
                done
                
            # Cmus not selected -> focus it and return to prev pos
            else
                i3-msg [title="cmus"] focus 
                sxiv -b cover.jpg &
                while true; do
                    if (~/.i3/py-scripts/wincurrent.py | grep "Sxiv"); then
                        i3-msg focus left
                        break
                    fi
                done
                sleep 2
                i3-msg workspace back_and_forth
            fi
        fi
    # Cmus not running?
    elif !(cmus-remote -Q); then
        i3-msg [title="sxiv - cover.jpg"] kill
        exit 0
    # No song selected ...
    else
        i3-msg [title="sxiv - cover.jpg"] kill
    fi
done
