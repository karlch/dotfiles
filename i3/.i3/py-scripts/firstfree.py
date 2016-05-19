#!/usr/bin/python

"""
Find the first free workspace and switch to it

Add this to your i3 config file:
    bindsym <key-combo> exec python /path/to/this/script.py
"""
import i3

workspace_names = ["1:one", "2:two", "3:three", "4:four", "5:five",
                   "6:six", "7:seven", "8:eight", "9:nine", "10:ten"]

def main():
    workspaces = i3.get_workspaces()
    print(workspaces)
    workints = list()
    for w in workspaces:
        workints.append(w['num'])
    for i in range(1, 11):
        if i not in workints:
            i3.workspace(workspace_names[i-1])
            break

if __name__ == '__main__':
    main()
