#!/bin/bash

DIR="${1:-$HOME/.config/coc/extensions}"

if [ ! -d "$DIR" ]; then
    echo "Could not find coc extensions directory! Please make sure you've installed coc or specify a different extensions directory to this script." 2>&1
    exit 1
fi

cd "$DIR"

npm install --no-save --no-package-lock
