#!/bin/bash

# Sorts STDIN by length.
function sortlen {
    while read -r line; do echo "${#line} $line"; done |\
        sort -n | cut -d' ' -f2-
}

# Reverses STDIN.
function reverse {
    OUT=""

    for word in "$@"; do
        for char in $(echo "$word" | sed 's/./\0\n/g'); do
            OUT="$char$OUT"
        done
        OUT=" $OUT"
    done

    echo "$OUT" | cut -c2-
}

# Per-dir profiles & .termdir support.
function cd {
    # shellcheck disable=SC1091
    builtin cd "${1+"$@"}"

    # get actual return value
    local ret=$?

    if [[ "$ret" == 0 ]]; then
        # Source a directory-specific profile if one is available.
        [[ -f ./.dir_profile ]] && source ./.dir_profile
        # Keep track of where the terminal is at for system keybinds to open the file manager in the PWD.
        realpath "$PWD" | tee ~/.termdir >/dev/null
    fi

    # return the proper return value
    return $ret
}

# Changelog command
function changelog {
    if [[ $# -lt 2 ]]; then
        echo "Usage: changelog <tag from> <tag to>" >&2
        return 1
    fi

    printf "### Changelog\n\n"

    git log --format='* %H - %s' "$1".."$2"

    printf "\nEnjoy!\n\n- Rayzr :computer:\n"
}

# Changes the online-mode of the server.properties file in the current directory to true or false.
function minecraft-online-mode {
    if [ ! -f server.properties ]; then
        echo "No server.properties file could be found." >&1
        return 1
    fi

    if ! echo "$1" | grep -qE 'true|false'; then
        echo "Usage: minecraft-online-mode <true|false>" >&1
        return 1
    fi

    sed -i "s/online-mode=\\(true\\|false\\)/online-mode=$1/" server.properties
    echo "online-mode set to '$1'"
}

# Edits the given dotfile and then re-sources it.
function dfe {
    nvim ~/.config/dotfiles/"$1".dot.sh && source ~/.zshrc
}

# Opens the given path or the current directory.
function o {
    local dir="$@"
    if [[ -z "$dir" ]] && [[ ! -t 0 ]]; then
        read -r line
        dir="$line"
    fi

    "$SCRIPTS/open" "${dir:-.}" 1&>/dev/null
    return $?
}

# Edits a file in Moeditor in the background.
function md {
    if ! command -v moeditor >/dev/null; then
        echo "Moeditor was not installed or is not in the PATH!" >&2
        return 1
    fi

    (moeditor "$@" &)
}

function loc {
    if [[ $# -lt 1 ]]; then
        echo "Usage: loc <query> [folder]" >&2
        return 1
    fi

    local query="$1"
    local dir="${2:-.}"

    grep -Rni "$query" "$dir" --color=yes | less
}

function fc-find {
    if [[ $# -lt 1 ]]; then
        echo "Usage: fc-find <name>" >&2
        return 1
    fi

    local fontName="$1"

    fc-list \
        | grep -i "$fontName" \
        | cut -d: -f2 \
        | sort \
        | uniq \
        | sed -e 's/^ //g' -e 's/,/, /g'
}

# ----- AUTOCOMPLETIONS
# Make sure to only run when we're using zsh
if command -v compdef >/dev/null; then
    function _dfe {
        local -a options
        options=( $(for item in ~/.config/dotfiles/*.dot.sh; do basename "$item" ".dot.sh"; done) )
        _describe 'command' options
    }

    compdef _dfe dfe

    function _build {
        local -a options
        options=( $(find ~/GitHub -mindepth 2 -maxdepth 2 -name 'pom.xml' -print0 | xargs -0 dirname -z | xargs -0 basename -a) )
        _describe 'command' options
    }

    compdef _build build

    function _cs {
        local -a options
        options=( $(find ~/.bin -maxdepth 1 -type f -print0 | xargs -0 basename -a) )
        _describe 'command' options
    }

    compdef _cs cs
fi
