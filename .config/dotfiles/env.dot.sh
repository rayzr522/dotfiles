#!/bin/bash

# Important directories
export SCRIPTS="$HOME/.bin"
export SRVR="$HOME/Servers/Minecraft/paper-server"
export NPM_PACKAGES="$HOME/.cache/npm-packages"
export N_PREFIX="$NPM_PACKAGES"

# Get base system vars before any other tools muck with them
export _ORIG_PATH=${_ORIG_PATH:-$PATH}
export _ORIG_MANPATH=${_ORIG_MANPATH:-${MANPATH:-$(manpath)}}
export _ORIG_NODE_PATH=${_ORIG_NODE_PATH:-$NODE_PATH}

# Configure discovery paths
export PATH="$HOME/.local/bin:$SCRIPTS:$NPM_PACKAGES/bin:$HOME/go/bin:$_ORIG_PATH:./node_modules/.bin"
export MANPATH="$NPM_PACKAGES/share/man:$_ORIG_MANPATH"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$_ORIG_NODE_PATH"

# Configure tools
export EDITOR=nvim
export VISUAL="$EDITOR"
export SUDO_ASKPASS="$SCRIPTS/askpass-secret-tool"
