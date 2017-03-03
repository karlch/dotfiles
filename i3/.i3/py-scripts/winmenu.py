#!/usr/bin/env python
"""
Rofi script to jump to windows in i3.
Makes a list of nicely formatted strings for each open window, containing
workspace name, mark (if any) and window title.

I prefer this to the default rofi version as it sorts the windows nicely,
removes the currently focused window and removes the numbering part of the i3
workspace name, i.e. '1:wsname' becomes 'wsname.'
"""

import subprocess
import sys
import re

import i3


def i3clients():
    """Populate a dictionary with window strings for rofi.

    Structure of the dictionary:
        key: Formatted string containing workspace name and window name.
        value: ID of the window to be able to focus it.

    Return:
        The generated dictionary.
    """
    clients = {}
    tree = i3.get_tree()
    # Iterate over all workspaces
    for ws in i3.get_workspaces():
        wsname = ws["name"]
        wsshow = re.sub(r'[0-9]+(:)', "", wsname)
        workspace = i3.filter(tree, name=wsname)[0]
        # We do not want to go to the focused window
        windows = [win for win in i3.filter(workspace, nodes=[])
                   if not win["focused"]]
        # Build the formatted string to pass to rofi and add it to the
        # dictionary
        for window in windows:
            wsname = re.sub("<.*?>", "", wsshow)
            win_str = "%-6s %-50s" % (wsname, window["name"])
            clients[win_str] = window["id"]
    return clients


def win_menu(clients):
    """Display a window menu using rofi.

    Args:
        clients: Dictionary containing window information.
    Return:
        The formatted string of the window to focus.
    """
    menu = subprocess.Popen(["rofi", "-dmenu", "-width", "33", "-p", "window: "],
                             stdin=subprocess.PIPE,
                             stdout=subprocess.PIPE)
    menu_str = "\n".join(sorted(clients.keys()))
    # Popen.communicate returns a tuple stdout, stderr
    win_bytes = menu.communicate(menu_str.encode("utf-8"))[0]
    win_str = win_bytes.decode().rstrip("\n")
    return win_str

if __name__ == "__main__":
    # Remember current workspace name
    for ws in i3.get_workspaces():
        if ws["focused"]:
            wsname = ws["name"]
            break
    # Get ID and string of the window to focus
    clients = i3clients()
    win_str = win_menu(clients)
    con_id = clients[win_str] if win_str in clients else 0
    # No window selected
    if not con_id:
        sys.exit(0)
    # Focus the window
    i3.focus(con_id=con_id)
    # If "--get", move the window to the remembered workspace
    if "--get" in sys.argv:
        i3.move("container", "to", "workspace", wsname)
        i3.workspace(wsname)
