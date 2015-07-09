#!/usr/bin/env python
# encoding: utf-8

import i3

current = i3.filter(nodes=[], focused=True)
try:
    if len(current) > 0:
        current = current[0]
        if len(current) > 0:
            current = current["window_properties"]
            if len(current) > 0:
                current = current["title"]
                current = current.split()
                current = current[0]
except:
    current = "Desktop"

if current == "tmux":
    print "PANE"
