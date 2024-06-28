#!/bin/bash

declare -A schemas
declare -a opts

function add_opt {
  local name="${1?missing name}"
  opts+=( "$name" )
  schemas["$name":idx]=0
}
function add_schema {
  local opt="${1?missing opt}"
  local schema="${2?missing schema}"
  schemas["$opt":${schemas["$opt":idx]}]="$schema"
  (( schemas["$opt":idx]++ ))
}
function get_schemas {
  local opt="${1?missing opt}"
  local upper="${schemas["$opt":idx]}"
  for (( i = 0; i < $upper; i++ )); do
    echo "${schemas["$opt":$i]}"
  done
}
function schema_filename {
  echo -n "${1:1:-1}.dump" | tr '/' '_'
}
function rel_to_pwd {
  local in="${1?missing in}"
  local abs="$(realpath -m "$in")"
  local relative_to_orig_pwd="${abs#$PWD}"
  if [ "$relative_to_orig_pwd" != "$abs" ]; then
    echo ".$relative_to_orig_pwd"
  else 
    echo "$abs"
  fi
}

add_opt gnome_terminal
add_schema gnome_terminal /org/gnome/terminal/

add_opt gnome_keybindings
add_schema gnome_keybindings /org/gnome/desktop/wm/keybindings/
add_schema gnome_keybindings /org/gnome/settings-daemon/plugins/media-keys/

add_opt budgie
add_schema budgie /com/solus-project/budgie-panel/
add_schema budgie /com/solus-project/budgie-wm/

ACTION="$1"
OPT="$2"
DUMP_DIR="$(dirname "$0")/dumps/$OPT"

usage_and_die() {
  echo -e "usage: manage-dconf.sh load|save <opt>\n\navailable opts:\n$(printf -- '- %s\n' "${opts[@]}")" >&2
  exit 1
}

if [ -z "$ACTION" ]; then
  usage_and_die
elif [ "$ACTION" = save ]; then
  test -z "$OPT" && usage_and_die
  mkdir -p "$DUMP_DIR"
  for schema in $(get_schemas "$OPT"); do
    out="$DUMP_DIR/$(schema_filename "$schema")"
    echo "saving $schema to $(rel_to_pwd "$out")"
    dconf dump "$schema" > "$out"
  done
elif [ "$ACTION" = load ]; then
  test -z "$OPT" && usage_and_die
  for schema in $(get_schemas "$OPT"); do
    in="$DUMP_DIR/$(schema_filename "$schema")"
    if [ -f "$in" ]; then
      echo "loading $schema from $(rel_to_pwd "$in")"
      dconf load "$schema" < "$in"
    else
      echo "skipped $schema as $(rel_to_pwd "$in") was not found"
    fi
  done
elif [ "$ACTION" = getopts ]; then
  echo "${opts[@]}"
fi
