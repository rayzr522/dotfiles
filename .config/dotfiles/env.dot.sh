#!/bin/bash

# Folder for all personal scripts.
export SCRIPTS="$HOME/.bin"

export PATH="$PATH:$SCRIPTS:.:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/go/bin:./node_modules/.bin"

# Aliases will handle translating from vim to nvim
export EDITOR=vim
export VISUAL="$EDITOR"

export SRVR="$HOME/Servers/Minecraft/paper-server"
