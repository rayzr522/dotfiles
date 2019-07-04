#!/bin/bash

cd "$(dirname "$0")" || exit 1

DOTFILES_DIR="${1:-$HOME}"

echo "Current path: $PWD"
echo "Installing to: $DOTFILES_DIR"
echo "--- Linking directories & files ---"

safe-link() {
    echo "> Linking '$1'"
    SOURCE="$PWD/$1"
    DEST="$DOTFILES_DIR/$1"

    if [[ -d "$SOURCE" ]] && [[ -d "$DEST" ]]; then
        echo "! Made a backup of pre-existing '$1'"
        mv "$DEST"{,.bak}
    fi

    ln -is "$SOURCE" "$DEST"
}

safe-link .bin
safe-link .zshrc
safe-link .gitignore
safe-link .tmux.conf
if [[ "$(uname)" == Linux ]]; then
    safe-link .Xresources
fi

mkdir -p "$DOTFILES_DIR/.config"
for file in "$PWD/.config/"*; do
    safe-link ".config/$(basename "$file")"
done
