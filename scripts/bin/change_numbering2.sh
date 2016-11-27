#!/bin/bash

for fil in $(find . -type f); do
    num=$(printf "%s" "$fil" | grep -o "[[:digit:]]*" | tr -d "()")
    ext=${fil##*\.} 
    base=${fil%_*}
    if [[ $num -gt 0 ]]; then
        new_name=$(printf "%s_%03d.%s\n" "$base" "$num" "$ext")
        if [[ -f "$new_name" ]]; then
            printf "Not overwriting %s\n" "$new_name"
            printf "Name was %s\n" "$fil"
        else
            mv "$fil" "$new_name"
        fi
    fi
done
