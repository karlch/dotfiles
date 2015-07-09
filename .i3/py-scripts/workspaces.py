#!/usr/bin/env python
# encoding: utf-8
import i3

ws = i3.get_workspaces()
output = str()

for element in ws:
    if element['focused']:
        output += element['name'] + "* "
    else:
        output += element['name'] + " "

print(output)
