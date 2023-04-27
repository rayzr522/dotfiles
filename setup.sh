#!/bin/bash

cd "$(dirname "$0")" || exit 1

LN_OPTS="-sT"
FORCE=false

if [[ "$1" = "-f" ]] || [[ "$1" = "--force" ]]; then
    FORCE=true
    echo "(Force-installing)"
    LN_OPTS+="f"
    shift
else
    LN_OPTS+="i"
fi

DOTFILES_DIR="${1:-$HOME}"

echo "Current path: $PWD"
echo "Installing to: $DOTFILES_DIR"
echo "--- Linking directories & files ---"

safe-link() {
    echo "> Linking '$1'"
    SOURCE="$PWD/$1"
    DEST="$DOTFILES_DIR/${2:-$1}"

    if [[ -d "$SOURCE" ]] && [[ -d "$DEST" ]] && [[ ! -L "$DEST" ]]; then
        echo "! Made a backup of pre-existing '$1'"
        mv "$DEST" "$DEST.bak.$(date '+%D-%T' | tr ':/' '-')"
    fi

    ln "$LN_OPTS" "$SOURCE" "$DEST"
}

safe-link .bin
safe-link .zshrc
safe-link .zpreztorc
safe-link .gitignore
safe-link .gitconfig
safe-link .tmux.conf
if [[ "$(uname)" == Linux ]]; then
    safe-link .xprofile
    safe-link .xprofile .xsession
    safe-link .xprofile .xsessionrc
    safe-link .Xresources

    XTHEMES_DIR="$DOTFILES_DIR/.config/rice/Xthemes"

    if [[ -d "$XTHEMES_DIR" ]] && [[ ! -L "$XTHEMES_DIR/_selected" ]]; then
        echo "Setting google.xresources as the default rice theme"
        ln "$LN_OPTS" "$XTHEMES_DIR/google.xresources" "$XTHEMES_DIR/_selected"
    fi

    xrdb -merge "$DOTFILES_DIR/.Xresources"

    CONKY_DIR="$DOTFILES_DIR/.config/conky"

    if [[ -d "$CONKY_DIR/now-clocking" ]]; then
        ln "$LN_OPTS" "$CONKY_DIR/config.now-clocking.env" "$CONKY_DIR/now-clocking/config.env"
    fi
fi

mkdir -p "$DOTFILES_DIR/.config"
for file in "$PWD/.config/"*; do
    safe-link ".config/$(basename "$file")"
done

mkdir -p "$HOME/.templates"
for file in "$PWD/.templates/"*; do
    safe-link ".templates/$(basename "$file")"
done

echo "--- Dependency setup ---"

PREZTO_DIR="${ZDOTDIR:-$HOME}/.zprezto"

if [[ ! -d "$PREZTO_DIR" ]] && command -v zsh /dev/null; then
    echo "Setting up Prezto"
    zsh -c '
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
       ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
    '
fi

if ! command -v starship >/dev/null; then
    if command -v brew >/dev/null; then
        brew install starship
    else
        curl -sS https://starship.rs/install.sh | sh
    fi
fi

if [ "$CONFIGURE_NEOVIM" ]; then
    echo -n "Installing or updating vim-plug... "
    curl -sfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "done"

    echo -n "Updating coc.nvim extensions... "
    if ! command -v npm >/dev/null; then
        echo "fail, npm not found"
    else
        npm --prefix "$DOTFILES_DIR/.config/coc/extensions" install --silent --no-package-lock &>/dev/null

        if [[ $? = 0 ]]; then
            echo "done"
        else
            echo "fail, unknown error"
        fi
    fi
fi

if command -v budgie-desktop >/dev/null; then
    echo -n "Loading Budgie settings... "
    ./scripts/load-budgie-settings.sh
    echo done
fi

if command -v fc-list >/dev/null && ! fc-list | grep -q "Iosevka Nerd Font"; then
    echo -n "Downloading fonts... "

    (
        cd "$(mktemp -d)"
        curl -sSLO "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip"
        unzip -q Iosevka.zip
        # we don't really need these
        rm -rf *'Windows Compatible.ttf'
        mkdir -p ~/.local/share/fonts
        cp *.ttf ~/.local/share/fonts
        echo -n "refreshing font cache... "
        fc-cache -f
        echo -n "removing temp dir... "
        rm -rf "$(pwd)"
    )

    echo done
fi
