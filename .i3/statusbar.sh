#!/bin/sh
# shell script to prepend the status bar with extra info

i3status -c ~/.i3/i3status.conf | while :
do
    read line
    
    artist=$(cmus-remote -Q | grep ' artist ' | cut -d ' ' -f3-)
    song=$(cmus-remote -Q | grep ' title ' | cut -d ' ' -f3-)
    brightness=$(xbacklight)
    brightness=${brightness%.*}
    output="[{ \"full_text\": \"${artist}  ${song}                                  ☀ ${brightness}% \" },"
    echo "${line/[/$output }" ||
exit 1
done
