#!/bin/bash

# Ensure Xresources are loaded
xrdb -merge ~/.Xresources

if command -v nvidia-settings >/dev/null; then
    # Load nvidia-settings
    nvidia-settings -l &
fi

if [[ -x "$HOME/.config/conky/now-clocking/start.sh" ]]; then
    "$HOME/.config/conky/now-clocking/start.sh" &>/dev/null &
fi

if [[ -z "$DISPLAY" ]]; then
    exec startkde
elif [[ "$XDG_CURRENT_DESKTOP" == KDE ]]; then
    if command -v compton >/dev/null; then
        compton -b &
    fi
fi
