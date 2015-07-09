#!/usr/bin/env python
# encoding: utf-8
import subprocess
import i3

# Get the current windowlist
win = subprocess.Popen(
    ['tmux', 'list-windows'],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE)

# Only the answer, not the error
win, err = win.communicate()
# To a list
winlist = win.split("\n")
# Remove the empty newline at the end
winlist.pop()

# And the current session
ses = subprocess.Popen(
    ['tmux', 'display-message', '-p', '#S'],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE)

# Only the answer, not the error
ses, err = ses.communicate()
ses = ses.strip("\n")

# Format the window names neatly
winlist_nice = list()
for element in winlist:
    new_element = element.split()
    new_str = new_element[0] + new_element[1]
    new_str = new_str.rstrip("-")
    if new_str[-1] == "*":
        new_str = new_str.rstrip("*")
        new_str = new_str.upper()
    winlist_nice.append(new_str)

# Gather them in a single string
winstr = str()
for element in winlist_nice:
    winstr = winstr + element + " "

# Check if Tmux is the current window
current = i3.filter(nodes=[], focused=True)
try:
    if len(current) > 0:
        current = current[0]
        if len(current) > 0:
            current = current["window_properties"]
            if len(current) > 0:
                current_class = current["class"]
                current_title = current["title"]
                current_title = current_title.split()
                current_title = current_title[0]
                if len(current_class) > 0:
                    current_class = current_class
except:
    print "Desktop"

# Display tmux windows if it is
if current_title == "tmux":
    print winstr.rstrip() + " [" + ses + "]"
# Else print the current window class
else:
    print current_class
