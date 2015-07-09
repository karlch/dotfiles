#!/usr/bin/python

"""
Find the first free workspace and switch to it

Add this to your i3 config file:
    bindsym <key-combo> exec python /path/to/this/script.py
"""
import i3


def main():
    # workspaces
    workspaces = i3.get_workspaces()
    workints = list()

    # get currently focused windows
    current = i3.filter(nodes=[], focused=True)

    # find a free one
    for w in workspaces:
        workints.append(w['num'])
    for i in range(1, 11):
        if i not in workints:
            break

    print(i)

    for window in current:
        i3.move("container", "to", "workspace", str(i))


if __name__ == '__main__':
    main()
