#!/bin/bash
##DESC## Fixes issues with KDE/Gnome not running .xinitrc stuff. I run this via an autostart .destkop file.

~/.xinitrc &
xrdb -merge ~/.Xresources
