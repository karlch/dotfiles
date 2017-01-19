#compdef t.sh

local curcontext="$curcontext" state line ret=1

_files -g "*" -W ~/.local/share/tasks/ && ret=0

return ret
