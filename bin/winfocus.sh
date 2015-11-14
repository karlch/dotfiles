#!/bin/bash

# Directory to save the images
mkdir ~/tmp
cd ~/tmp

# Get a window list
windows=$(i3-msg -t get_tree | tr "," "\n" | grep "\"id\"" \
    | grep -E -o "[[:digit:]]*" | sort | uniq)
# Current workspace
curworkspace=$(xdotool get_desktop)

# Focus every window
for window in $windows; do
    # If possible
    if i3-msg [con_id=$window] focus | grep "true"; then
        # And if not a parent container
        if !(i3-msg focus child | grep "true"); then
            # Screenshot with a nice name
            desktop=$(xdotool get_desktop)
            ((desktop++))
            curwin=$(xdotool getactivewindow)
            name=$(xprop -id $curwin | grep "WM_NAME(UTF8_STRING)" | \
                cut -d " " -f3- | tr " " "_" | tr -d "/")
            echo $name
            sleep 0.01
            scrot -u ${desktop}__${name}.jpg
            # xwd -id $curwin -silent -out ${desktop}__${name}.xwd
            windowlist=${windowlist}" "${window}"="${desktop}"_"${name}
        fi
    fi
done

# Go back to the beginning
xdotool set_desktop $curworkspace 

# And start sxiv as viewer
sxiv -t -f *.jpg &

while [[ $(~/.i3/py-scripts/wincurrent_title.py) != "sxiv" ]]; do
    sleep 0.01
done
xdotool key plus
# Wait as long as the user has not selected anything
while [[ $(~/.i3/py-scripts/wincurrent_title.py) == "sxiv" ]]; do
    sleep 0.01
done
# Then get the title of the selected image
win=$(xdotool getactivewindow)
win=$(xprop -id $win | grep "WM_NAME(UTF8_STRING)" | cut -d " " -f3- | \
    cut -d "\"" -f3 | tr -d '\\')

win=$(echo $win | tr -d "]" | tr -d "[")
windowlist=$(echo $windowlist | tr -d "]" | tr -d "[")
echo $win
echo $windowlist

# Find out which one it was
for window in $windowlist; do
    if test "${window#*$win}" != ${window}; then
        tofocus=$(echo $window | tr "=" " " | cut -d " " -f1)
        workspace=$(echo $window | tr "=" " " | cut -d " " -f2 | head -c 1)
        break
    fi
done

# Kill sxiv, focus the window
xdotool search --onlyvisible --class "Sxiv" key q
i3-msg [con_id=$tofocus] focus

# Fallback, at least focus the workspace of the window
((workspace--))
if [[ $(xdotool get_desktop) != $workspace ]]; then
    xdotool set_desktop $workspace
fi

# Clean up
cd ~
rm -rf ~/tmp
