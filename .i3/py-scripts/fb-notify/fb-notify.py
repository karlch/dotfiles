#!/usr/bin/env python
# encoding: utf-8

import i3


def main():
    # get currently focused windows
    current = i3.filter(nodes=[], focused=True)
    try:
        if len(current) > 0:
            current = current[0]
            if len(current) > 0:
                current = current["window_properties"]
                if len(current) > 0:
                    current = current["title"]
                    if len(current) > 0:
                        print(current)
    except:
        pass
    # get unfocused windows
    other = i3.filter(nodes=[], focused=False)
    if len(other) > 0:
        for win in other:
            try:
                if len(win) > 0:
                    win = win["window_properties"]
                    if len(win) > 0:
                        win = win["title"]
                        if len(win) > 0:
                            print(win)
            except:
                pass

if __name__ == '__main__':
    main()
