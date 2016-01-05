#!/bin/bash
vol=`amixer -c 0 get Master | grep Mono | cut -d " " -f6 | tr -d '[]' | tr -d '\n'`
echo $vol
