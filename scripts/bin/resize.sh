#!/bin/bash

if [[ $1 == "h" ]]; then
    if (i3-msg resize grow left 10 px or 4 ppt | grep "false"); then
        i3-msg resize shrink right 10 px or 4 ppt
    fi
elif [[ $1 == "j" ]]; then
    if (i3-msg resize grow down 10 px or 4 ppt | grep "false"); then
        i3-msg resize shrink up 10 px or 4 ppt
    fi
elif [[ $1 == "k" ]]; then
    if (i3-msg resize grow up 10 px or 4 ppt | grep "false"); then
        i3-msg resize shrink down 10 px or 4 ppt
    fi
elif [[ $1 == "l" ]]; then
    if (i3-msg resize grow right 10 px or 4 ppt | grep "false"); then
        i3-msg resize shrink left 10 px or 4 ppt
    fi
else
    exit 1
fi
