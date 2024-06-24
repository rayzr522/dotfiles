# edits the given dotfile and then re-sources it
function dfe {
    local dotfile="$HOME/.config/zsh/init/$1"
    nvim "$dotfile" && source "$dotfile"
}

# opens path in GUI (supporting piping)
function o {
    local dir="$@"
    if [[ -z "$dir" ]] && [[ ! -t 0 ]]; then
        read -r line
        dir="$line"
    fi

    open "${dir:-.}" 1&>/dev/null
}

# locates a file
function loc {
    if [[ $# -lt 1 ]]; then
        echo "Usage: loc <query> [folder]" >&2
        return 1
    fi

    local query="$1"
    local dir="${2:-.}"

    rg --hidden --color always --line-number --ignore-case "$query" "$dir" | less -R
}

# finds a font
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

function sizes {
    du -sh "$@" | sort -h
}

function convert-to-mp4 {
    if [[ $# -lt 2 ]]; then
        echo "usage: convert-to-mp4 <input> <output>" >&2
        return 1
    fi

    ffmpeg -i "$1" -vcodec h264_nvenc -crf 30 -acodec copy "$2"
}

# creates an encrypted backup of the given path
function bak {
    if [[ $# -lt 1 ]]; then
        echo "usage: bak <path>" >&2
        return 1
    fi

    if [[ -z "$BAK_GPG_ID" ]]; then
        echo "BAK_GPG_ID not configured" >&2
        return 1
    fi

    mkdir -p ~/.bak
    if [[ ! -e "$1" ]]; then
        echo "'$1' does not exist" >&2
        return 1
    fi

    local bak_name="$(date "+%y-%m-%d-%H-%M-%S")-$(basename "$PWD")-$(basename "$1")"
    tar -czf - "$1" | gpg --encrypt --recipient "$BAK_GPG_ID" --output ~/.bak/"$bak_name".tar.gz.gpg
    echo "baked up as $bak_name"
}

