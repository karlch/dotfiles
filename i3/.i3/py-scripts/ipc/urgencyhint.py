#!/usr/bin/env python
# encoding: utf-8

import i3ipc
from os import system

def set_urgency(i3, event):
    """ Sets the urgency hint on a browser window if its title changes
        Useful for online web services, chats, ... """
    container = event.container
    win_id = container.window
    cl = container.window_class
    if cl == "qutebrowser":
        cmd = "/home/christian/src/seturgent/seturgent %s" %(win_id)
        system(cmd)

# Always keep a connection
# Shouldn't be neccessary IMHO, but the ipc breaks down randomly
while True:
    # Start a connection
    i3 = i3ipc.Connection()

    i3.on("window::title", set_urgency)

    i3.main()

# DEBUG when this dies
system("urxvt")
