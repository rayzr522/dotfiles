#!/bin/bash

# Important directories
export SCRIPTS="$HOME/.bin"
export SRVR="$HOME/Servers/Minecraft/paper-server"

# Get base system vars before any other tools muck with them
export _ORIG_PATH=${_ORIG_PATH:-$PATH}
export _ORIG_MANPATH=${_ORIG_MANPATH:-${MANPATH:-$(manpath)}}
export _ORIG_NODE_PATH=${_ORIG_NODE_PATH:-$NODE_PATH}

# Configure discovery paths
export PATH="$HOME/.local/bin:$SCRIPTS:$HOME/.deno/bin:$HOME/go/bin:$_ORIG_PATH:./node_modules/.bin"

# Configure tools
export EDITOR=nvim
export VISUAL="$EDITOR"

if [ "$(uname)" = Linux ] && command -v secret-tool >/dev/null; then
    export SUDO_ASKPASS="$SCRIPTS/askpass-secret-tool"
    alias sudo="sudo -A"
fi

export GPG_TTY=$(tty)
