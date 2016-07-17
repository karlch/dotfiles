#!/bin/bash

if [[ $1 == "l" ]]; then
    if (i3-msg resize shrink left 5 px or 2 ppt | grep "false"); then
        i3-msg resize grow right 5 px or 2 ppt
    fi
elif [[ $1 == "k" ]]; then
    if (i3-msg resize shrink down 5 px or 2 ppt | grep "false"); then
        i3-msg resize grow up 5 px or 2 ppt
    fi
elif [[ $1 == "j" ]]; then
    if (i3-msg resize shrink up 5 px or 2 ppt | grep "false"); then
        i3-msg resize grow down 5 px or 2 ppt
    fi
elif [[ $1 == "h" ]]; then
    if (i3-msg resize shrink right 5 px or 2 ppt | grep "false"); then
        i3-msg resize grow left 5 px or 2 ppt
    fi
else
    exit 1
fi
