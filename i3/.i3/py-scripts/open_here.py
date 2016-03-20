#!/usr/bin/env python
# encoding: utf-8
import i3
from subprocess import call


def main():
    workspaces = i3.get_workspaces()
    for w in workspaces:
        if w['focused']:
            cur = w['num']
    print(workspaces)
    print(cur)
    call(["ls", "-l"])

if __name__ == '__main__':
    main()
