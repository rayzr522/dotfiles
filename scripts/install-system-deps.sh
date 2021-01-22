#!/bin/bash

if command -v apt >/dev/null; then
    echo "aptitude discovered, assuming ubuntu/debian system"

    if ! command -v node >/dev/null; then
        echo "node not installed, running setup from nodesource"
        curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
    fi

    sudo apt update
    sudo apt install build-essential tmux nodejs zsh conky rofi jq playerctl xdotool xclip
elif command -v yay >/dev/null; then
    echo "yay discovered, assuming arch system"

    yay -Syy
    yay -S git tmux nodejs zsh conky rofi jq playerctl xdotool xclip
fi
