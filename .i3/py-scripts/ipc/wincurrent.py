#!/usr/bin/env python
# encoding: utf-8

import i3ipc

def print_class(i3, e):
    focused = i3.get_tree().find_focused()
    cl = focused.window_class
    output = open("/home/christian/.i3/info/wincurrent", "w")
    output.write(cl)
    output.close()

while True:
    i3 = i3ipc.Connection()
    i3.on('window::focus', print_class)
    i3.main()
