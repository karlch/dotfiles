#!/usr/bin/env python
# encoding: utf-8

import i3
import sys

if len(sys.argv) != 2:
    sys.exit(1)

dir = sys.argv[1]
print(dir)

current = i3.filter(nodes=[], focused=True)
current = current[0]
geom = current["rect"]
x = geom["x"]
y = geom["y"]

if dir == "h":
    if x == 0:
        print("shrinking")
        i3.resize('shrink', '10', 'px')
    else:
        print("growing")
elif dir == "j":
    if y == 0:
        print("growing")
