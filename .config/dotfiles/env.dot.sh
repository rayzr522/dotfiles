#!/bin/bash

# Important directories
export SCRIPTS="$HOME/.bin"
export SRVR="$HOME/Servers/Minecraft/paper-server"
export NPM_PACKAGES="$HOME/.cache/npm-packages"
export N_PREFIX="$NPM_PACKAGES"

# Configure discovery paths
export PATH="$HOME/.local/bin:$SCRIPTS:$NPM_PACKAGES/bin:$HOME/go/bin:$_ORIG_PATH:./node_modules/.bin"
if ! echo "$MANPATH" | grep -q "$NPM_PACKAGES/share/man:"; then
    export MANPATH="$NPM_PACKAGES/share/man:${MANPATH:-$(manpath)}"
fi
if ! echo "$NODE_PATH" | grep -q "$NPM_PACKAGES/lib/node_modules:"; then
    export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
fi

# Configure tools
export EDITOR=nvim
export VISUAL="$EDITOR"
export SUDO_ASKPASS="$SCRIPTS/askpass-secret-tool"
