#!/bin/bash
song=`cmus-remote -C "save -p -" | sed -e "s/\/home\/christian\/Musik\///" | sed -e "s/\//  /g" | sed -e "s/\.ogg//" | dmenu -i -l 45 -fn SourceCodePro -nb "#2C2C2C" -nf "#00C1FF" -sb "#00A0DD" -sf "#FFFFFF"`
song=`echo "$song" | sed -e "s/  /\//g" | sed -e "s/^/\/home\/christian\/Musik\//" | sed -e "s/$/\.ogg/"`
cmus-remote -C "player-play $song"
