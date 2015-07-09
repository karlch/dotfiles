#!/usr/bin/env python
# encoding: utf-8
import subprocess


win = subprocess.Popen(
    ['tmux', 'list-windows'],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE)

win, err = win.communicate()
winlist = win.split("\n")
winlist.pop()
winlist_nice = list()

for element in winlist:
    new_element = element.split()
    new_str = new_element[0] + new_element[1]
    new_str = new_str.rstrip("-")
    if new_str[-1] == "*":
        new_str = new_str.rstrip("*")
        new_str = new_str.upper()
    winlist_nice.append(new_str)

winstr = str()
for element in winlist_nice:
    winstr = winstr + element + " "

pane = subprocess.Popen(
    ['tmux', 'list-panes'],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE)

pane, err = pane.communicate()
panelist = pane.split("\n")
panelist.pop()
panelist_nice = list()

for element in panelist:
    new_element = element.split()
    if new_element[-1] == '(active)':
        new_str = new_element[0]
        new_str = new_str.rstrip(":")
        panelist_nice.append(new_str)

panestr = str()
for element in panelist_nice:
    panestr = panestr + element + " "

print "win " + winstr + "  pane " + panestr
