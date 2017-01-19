#!/bin/bash
# Get the cover of an album in a folder

file=$(find . -type f -name "*.ogg" | head -n 1)
[[ -z $file ]] && exit 0

artist=$(exiftool "$file" | grep "Artist" | awk '{$1=""; $2=""; print $0}')
album=$(exiftool "$file" | grep "Album" | awk '{$1=""; $2=""; print $0}')

if (glyrc cover --artist "$artist" --album "$album" -w cover.jpg 2>/dev/null 1>/dev/null); then
    printf "Fetched %s - %s\n" "$artist" "$album"
else
    printf "Failed to fetch %s - %s\n" "$artist" "$album"
fi
