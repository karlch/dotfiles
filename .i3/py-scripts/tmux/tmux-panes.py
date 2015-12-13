#!/usr/bin/env python
# encoding: utf-8
import subprocess
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

p = subprocess.Popen(
    ['tmux', 'display-message', '-p', '#{?client_prefix,NORMAL,} #P'],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE)

prefix, err = p.communicate()
prefix = prefix.decode(encoding='UTF-8')
prefix = prefix.strip("\n")

if current == "tmux":
    print(prefix)
