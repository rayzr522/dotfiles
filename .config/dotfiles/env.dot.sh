#!/bin/bash

# Important directories
export SCRIPTS="$HOME/.bin"
export SRVR="$HOME/Servers/Minecraft/paper-server"

export PATH="$PATH:$SCRIPTS:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/go/bin:./node_modules/.bin"
export EDITOR=nvim
export VISUAL="$EDITOR"
export SUDO_ASKPASS="$SCRIPTS/askpass-secret-tool"

export NPM_PACKAGES="$HOME/.cache/npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
export MANPATH="$NPM_PACKAGES/share/man:${MANPATH:-$(manpath)}"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export N_PREFIX="$NPM_PACKAGES"
