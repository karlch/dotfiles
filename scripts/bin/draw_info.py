#!/usr/bin/env python
# encoding: utf-8

import os
import signal
from subprocess import Popen, PIPE
from gi import require_version
require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, Pango


class Info(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self)
        self.connect("destroy", Gtk.main_quit)

        update_info, update_names = self.update_info()
        wm = '<span foreground="#8787AF">WM </span>i3'
        editor = '<span foreground="#8DB5DD">EDITOR </span>nvim'
        shell = '<span foreground="#8787AF">SHELL </span>zsh'
        kernel = '<span foreground="#8DB5DD">KERNEL </span>' + self.kernel()
        disksize, diskfree = self.disk_info()
        disksize = '<span foreground="#AFD7FF">TOTAL </span>' + disksize
        diskfree = '<span foreground="#AFD7FF">FREE </span>' + diskfree
        weather = '<span foreground="#875FAF">WEATHER </span>' + self.weather()

        vbox = Gtk.VBox(False, 10)
        self.hbox = Gtk.HBox(False, 10)
        border = Gtk.Box(False, 0)
        border.modify_bg(Gtk.StateType.NORMAL, Gdk.color_parse("#AFD7FF"))
        border.set_size_request(-1, 2)

        self.add_label(update_info, self.hbox)
        self.add_label(disksize, self.hbox)
        self.add_label(diskfree, self.hbox)
        self.add_label(kernel, self.hbox)
        self.add_label(editor, self.hbox)
        self.add_label(shell, self.hbox)
        self.add_label(wm, self.hbox)
        self.add_label(weather, self.hbox)

        vbox.pack_start(self.hbox, False, False, 10)
        vbox.pack_start(border, False, False, 10)

        self.add_label(update_names, vbox)

        self.add(vbox)
        self.modify_bg(Gtk.StateType.NORMAL, Gdk.color_parse("#3C3C40"))

        self.set_keep_below(True)
        self.set_skip_pager_hint(True)
        self.set_skip_taskbar_hint(True)
        self.set_decorated(False)
        # self.set_accept_focus(False)
        self.set_type_hint(Gdk.WindowTypeHint.DESKTOP)
        self.set_title("DesktopWindow")
        self.show_all()

    def update_info(self):
        update_file = os.path.join(os.path.expanduser("~"),
                                   ".i3/info/update_info")
        update_info = ""
        with open(update_file) as fil:
            for line in fil:
                update_info += line
        update_names_file = os.path.join(os.path.expanduser("~"),
                                         ".i3/info/update_names")
        update_names = ""
        with open(update_names_file) as fil:
            for line in fil:
                update_names += line

        update_info = update_info.rstrip("\n")
        update_names = update_names.rstrip("\n")

        return update_info, update_names

    def kernel(self):
        p = Popen(["uname", "-sr"], stdout=PIPE)
        return p.communicate()[0].decode().rstrip("\n")

    def disk_info(self):
        p1 = Popen(["lsblk"], stdout=PIPE)
        info1 = p1.communicate()[0].decode()
        disksize = info1.split()[16]
        p2 = Popen(["df", "-h"], stdout=PIPE)
        info2 = p2.communicate()[0].decode()
        diskfree = info2.split("\n")[5].split()[3]
        return disksize, diskfree

    def weather(self):
        command = os.path.join(os.path.expanduser("~"), "bin/weather.sh")
        p = Popen([command], stdout=PIPE)
        return p.communicate()[0].decode().rstrip("\n")

    def add_label(self, string, box):
        label = Gtk.Label()
        font = Pango.FontDescription("Source Code Pro Bold 13")
        label.modify_font(font)
        label.set_markup(string)
        box.pack_start(label, True, True, 0)




if __name__ == "__main__":
    Info()
    signal.signal(signal.SIGINT, signal.SIG_DFL)  # ^C
    Gtk.main()
