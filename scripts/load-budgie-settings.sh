#!/bin/bash

if ! command -v dconf >/dev/null; then
    echo "dconf is required for this" >&1
    exit 1
fi

load_dconf_dump_to_path() {
    path="$1"
    file="$2"

    dconf load "$path" < "$file"
}

cd "$(dirname "$0")/.." || exit 1
[[ -d budgie ]] || mkdir budgie
cd budgie

load_dconf_dump_to_path /com/solus-project/budgie-panel/ budgie-panel.dump
load_dconf_dump_to_path /com/solus-project/budgie-wm/ budgie-wm.dump
