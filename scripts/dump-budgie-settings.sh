#!/bin/bash

if ! command -v dconf >/dev/null; then
    echo "dconf is required for this" >&1
    exit 1
fi

dump_dconf_path_to_file() {
    path="$1"
    file="$2"

    if [[ ! -z "$(dconf list "$path")" ]]; then
        dconf dump "$path" | tee "$file"
    fi
}

cd "$(dirname "$0")/.." || exit 1
[[ -d budgie ]] || mkdir budgie
cd budgie

dump_dconf_path_to_file /com/solus-project/budgie-panel/ budgie-panel.dump
dump_dconf_path_to_file /com/solus-project/budgie-wm/ budgie-wm.dump
