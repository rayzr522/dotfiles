# An attempt at something similar to Java's Stream API, except in bash.
# It... sort of works. Just incredibly slowly and sometimes not at all :)

function isEmpty {
   if find "$1" -mindepth 1 | read -r; then
      return 1
   else
      return 0
   fi
}

function stdin {
   while read -r line; do echo "$line"; done
}

function replace {
   stdin | sed "s/$1/$2/g"
}

function trim {
   stdin | sed -e 's/^ *//g' -e 's/ *$//g'
}

function substr {
   stdin | cut -c"$1"-"$2"
}

function len {
   STR="${*:-$(stdin)}"
   echo "${#STR}"
}

function calc {
   bc -l <<< "$*"
}

function join {
   DELIM="$1"
   CURR="$2"
   NEXT="$3"
   if [[ ${#CURR} -lt 1 ]]; then
      echo -n "$NEXT"
   else
      CURR+="$DELIM"
      echo -n "$CURR$NEXT"
   fi
}

# https://stackoverflow.com/a/8811800
function contains {
   string="$1"
   substring="$2"
   if test "${string#*$substring}" != "$string"
   then
      return 0    # $substring is in $string
   else
      return 1    # $substring is not in $string
   fi
}

# THE MAGIC THAT MAKES IT HAPPEN
function map {
   CMD="${*//\{\}/\$1}"

   if ! contains "$CMD" "\$1"; then
      CMD="$CMD \$1"
   fi

   # https://stackoverflow.com/a/845928
   xargs -I {} -0 zsh -c "$CMD" -- {} | tr '\n' '\0'
}

function maps {
   map "echo {} | $*"
}

function filter {
   method=map
   CMD="$*"

   if ! contains "$CMD" "{}"; then
      method=maps
   fi

   "$method" "if $CMD; then echo {}; fi"
}

function split {
   OUT=""
   local IFS="$1"
   while read -r item; do OUT="$(join "\x00" "$OUT" "$item")"; done
   echo "$OUT"
}

function forin {
   OUT=""
   for item in "$@"; do OUT="$(join "\x00" "$OUT" "$item")"; done
   echo -n "$OUT"
}

function dir {
   if [[ "$1" = "-r" ]]; then
      shift
      dir "$@" | map basename
      return
   fi

   DIR="${1:-$(pwd)}"
   ! isEmpty "$DIR" && forin "$DIR"/*
}

function prnt {
   xargs -I {} -0 -- echo {}
}

function require {
   [[ $# -lt 1 ]] && return 1

   if [[ -f "$1" ]]; then
      source "$1"
   else
      echo "The file '$1' could not be found" 1>&2
      return 1
   fi
}

function requiredir {
   DIR="${1:-.}"

   dir "$DIR" | filter test -f {} -a -x {} | prnt |\
      while read -r item; do require "$item"; done
}
