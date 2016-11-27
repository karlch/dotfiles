#!/bin/bash

for fil in $(find . -iname "*.jpg"); do
    name=$(basename "$fil")
    ext=".thumbnail_512x512.png"
    base=${name%\.*}
    base=${base/\.\//}
    new_name=~/.vimiv/Thumbnails/${base}${ext}
    if [[ -f "$new_name" ]]; then
        printf "Thumbnail for %s exists.\n"
    else
        convert "$fil" -thumbnail "512x512" "$new_name"
        printf "Created thumbnail for %s\n" "$name"
    fi
done
