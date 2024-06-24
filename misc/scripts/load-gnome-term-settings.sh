#!/bin/bash
cat "$(dirname "$0")/../../gnome-terminal/term.conf" | dconf load /org/gnome/terminal/
