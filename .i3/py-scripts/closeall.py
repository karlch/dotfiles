#!/usr/bin/env python
# encoding: utf-8


import i3


def cycle():
    # get currently focused windows
    current = i3.filter(nodes=[], focused=True)
    # get unfocused windows
    other = i3.filter(nodes=[], focused=False)
    # focus each previously unfocused window for 0.5 seconds
    for window in other:
        i3.focus(con_id=window['id'])
        i3.kill()
    # focus the original windows
    for window in current:
        i3.focus(con_id=window['id'])
        i3.kill()

if __name__ == '__main__':
    workspaces = i3.get_workspaces()
    cycle()
    on_one = False
    for w in workspaces:
        if w["num"] == 1:
            if w["focused"]:
                on_one = True

    if on_one:
        pass
    else:
        i3.workspace("1")
