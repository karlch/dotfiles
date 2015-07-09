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
                current = current["class"]
                if len(current) > 0:
                    print(current)
except:
    print("Desktop")
