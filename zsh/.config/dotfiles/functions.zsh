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

# Changelog command
function changelog {
    if [[ $# -lt 2 ]]; then
        echo "Usage: changelog <tag from> <tag to>" >&2
        return 1
    fi

    printf "### Changelog\n\n"

    git log --format='* %H - %s' "$1".."$2"

    printf "\nEnjoy!\n\n- rayzr :computer:\n"
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
    local dotfile="$HOME/.config/dotfiles/$1.zsh"
    nvim "$dotfile" && source "$dotfile"
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

    rg --color always --line-number --ignore-case "$query" "$dir" | less -R
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

function gm {
    if [[ $# -lt 1 ]]; then
        echo "Usage: gm <name> [--init]" >&2
        return 1
    fi

    local gm_dir="$HOME/GitHub/.mirror"

    if [[ ! -d "$gm_dir" ]]; then
        echo "Creating git mirror dir..."
        mkdir -p "$gm_dir"
    fi

    local mirror_path="$gm_dir/$1.git"

    if [[ "$2" = "--init" ]]; then
        if [[ -d "$mirror_path" ]]; then
            echo "That mirror already exists!" >&2
            return 1
        fi

        echo "Initializing git mirror '$1'..."
        mkdir -p "$mirror_path"
        git --git-dir "$mirror_path" init --bare
        echo "Done!"
    elif [[ -d "$mirror_path" ]]; then
        echo "Cloning git mirror '$1'..."
        git clone "$mirror_path" "$1"
    else
        echo "That git mirror does not exist!" >&2
        return 1
    fi
}

function sizes {
    du -sh "$@" | sort -h
}

function set-gnome-lockscreen {
    gsettings set org.gnome.desktop.screensaver picture-uri "file://$(realpath $1)"
}

function github {
    local url
    url="$(giturl "$@")"
    local ret=$?

    if [[ $ret != 0 ]]; then
        return $ret
    fi

    o "$url"
}

function convert-to-mp4 {
    if [[ $# -lt 2 ]]; then
        echo "usage: convert-to-mp4 <input> <output>" >&2
        return 1
    fi

    ffmpeg -i "$1" -vcodec h264_nvenc -crf 30 -acodec copy "$2"
}

function bak {
    if [[ $# -lt 1 ]]; then
        echo "usage: bak <path>" >&2
        return 1
    fi

    mkdir -p ~/.bak
    if [[ ! -e "$1" ]]; then
        echo "'$1' does not exist" >&2
        return 1
    fi

    if [[ -z "$BAK_GPG_ID" ]]; then
        echo "BAK_GPG_ID not configured" >&2
        return 1
    fi

    local bak_name="$(date "+%y-%m-%d-%H-%M-%S")-$(basename "$PWD")-$(basename "$1")"
    tar -czf - "$1" | gpg --encrypt --recipient "$BAK_GPG_ID" --output ~/.bak/"$bak_name".tar.gz.gpg
    echo "baked up as $bak_name"
}

