#!/usr/bin/env python
# encoding: utf-8

import i3
import time


def i3clients():
    """
    Returns a dictionary with convoluted strings with window information as
    keys, and the i3 window id as values. Each window text is of format
    "[workspace] mark window title (instance number)."
    """
    clients = {}
    lengths = {'workspace': 0, 'mark': 0}
    tree = i3.get_tree()
    for ws in i3.get_workspaces():
        wsname = ws['name']
        if len(wsname) > lengths['workspace']:
            lengths['workspace'] = len(wsname)
        workspace = i3.filter(tree, name=wsname)
        if not workspace:
            continue
        workspace = workspace[0]
        windows = i3.filter(workspace, nodes=[])
        instances = {}
        # Adds windows and their ids to the clients dictionary
        for window in windows:
            windowdict = {
                'con_id': window['id'],
                'ws': wsname,
                'name': window['name']}
            try:
                windowdict['mark'] = window['mark']
                if len(window['mark']) > lengths['mark']:
                    lengths['mark'] = len(window['mark'])
            except KeyError:
                windowdict['mark'] = ""
            if window['name'] in instances:
                instances[window['name']] += 1
            else:
                instances[window['name']] = 1
            windowdict['instance'] = instances[window['name']]
            # win_str = '[%s] %s' % (workspace['name'], window['name'])
            clients[window['id']] = windowdict

    # Now build the strings to pass to dmenu:
    clientlist = []
    for con_id in clients.keys():
        clientlist.append(con_id)
    for con_id in clientlist:
        wslen = lengths['workspace']
        mlen = lengths['mark']
        win_str = u'[{k:<{v}}] {l:<{w}} {m}'.format(
            k=clients[con_id]['ws'], v=wslen,
            l=clients[con_id]['mark'], w=mlen,
            m=clients[con_id]['name'],
            n=clients[con_id]['instance'])
        clients[win_str] = clients[con_id]
        del clients[con_id]
    return clients

if __name__ == '__main__':
    clients = i3clients()
    i3.workspace("Overview")

    for i in range(1, 11):
        i3.workspace(str(i))
        for j in range(4):
            i3.focus("parent")
            i3.layout("splitv")
        i3.split("h")
        i3.move("container", "to", "workspace", "Overview")
        i3.focus("parent")
        # length = 0
        # containers = 0
        # for client in clients:
        #     if clients[client]['ws'] == str(i):
        #         time.sleep(2)
        #         length += 1
        #         containers += 1
        #         con_id = clients[client]['con_id']
        #         i3.focus(con_id=con_id)
        #         time.sleep(2)
        #         i3.move("container", "to", "workspace", "Overview")
        #         i3.focus(con_id=con_id)
        #         time.sleep(2)
        #         i3.border("pixel", "20")
        # if length < 2:
        #     if containers > 1:
        #         i3.focus("parent")
        #     i3.split("h")
        # else:
        #     i3.focus("parent")
        #     i3.focus("parent")
        #     i3.split("h")

    i3.workspace("Overview")
