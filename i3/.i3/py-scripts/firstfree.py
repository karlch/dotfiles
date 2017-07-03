#!/usr/bin/python
"""
Find the first free workspace and switch to it.
"""

import os
import sys

import i3


def get_workspace_names():
    """Return a list of the workspace names set in ~/.i3/config."""
    default = range(1, 11)
    ws_names = []

    configfile = os.path.expanduser("~/.i3/config")
    if not os.path.exists(configfile):
        return default

    with open(configfile) as f:
        for line in f:
            if line.startswith("set $ws"):
                line_content = line.rstrip("\n")
                ws_start = " ".join(line_content.split()[0:2])
                ws_name = line_content.replace(ws_start, "").strip()
                ws_names.append(ws_name)

    return ws_names if ws_names else default

if __name__ == '__main__':
    ws_names = get_workspace_names()
    ws_nums = []
    for w in i3.get_workspaces():
        ws_nums.append(w['num'])
    i = 1
    while i in ws_nums:
        i += 1
    first_free = ws_names[i-1]

    if "--move-to" in sys.argv:
        i3.move("container", "to", "workspace", first_free)
    elif "--take-with" in sys.argv:
        i3.move("container", "to", "workspace", first_free)
        i3.workspace(first_free)
    else:
        i3.workspace(first_free)
