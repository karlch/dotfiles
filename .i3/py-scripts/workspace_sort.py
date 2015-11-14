#!/usr/bin/env python
# encoding: utf-8

"""
Sort the workspaces when they are out of order
"""
import i3


def main():
    # workspaces
    workspaces = i3.get_workspaces()
    workints = list()

    # number the workspaces
    for w in workspaces:
        workints.append(w['num'])

    # Sort them
    for i in range(1, len(workints) + 1):
        print(i)


if __name__ == '__main__':
    main()
