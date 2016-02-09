#!/bin/bash
# Get the cover of an album in a folder

file=$(ls | head -n 1)
if !(echo ${file} | grep "ogg" 1>/dev/null 2>/dev/null); then
    exit 1
fi

artist=$(exiftool ${file} | grep "Artist" | awk '{$1=""; $2=""; print $0}')
album=$(exiftool ${file} | grep "Album" | awk '{$1=""; $2=""; print $0}')

if (glyrc cover --artist "${artist}" --album "${album}" -w cover.jpg 2>/dev/null 1>/dev/null); then
    printf "Fetched %s - %s\n" "${artist}" "${album}"
else
    printf "Failed to fetch %s - %s\n" "${artist}" "${album}"
fi
