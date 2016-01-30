#!/bin/bash

isrunning=$(ps aux | grep "urxvt -e ncmpcpp" | wc -l)

ncmpcpp_screen()
{
    playlist=$(mpc | wc -l)
    if [[ ${playlist} -gt 1 ]]; then
        urxvt -e ncmpcpp -s "playlist"
    else
        urxvt -e ncmpcpp
    fi
}

if [[ $1 == "start" ]]; then
    echo "starting"
    i3-msg -q workspace 11:M
    if [[ ${isrunning} -lt 2 ]]; then
        ncmpcpp_screen
    fi
else
    echo "stopping"
    mpc clear
    tokill=$(ps aux | grep "ncmpcpp" | grep -v "grep" | awk '{print $2}')
    for item in $(echo ${tokill}); do
        kill -KILL ${item}
    done
fi
