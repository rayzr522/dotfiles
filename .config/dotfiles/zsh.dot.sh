#!/bin/bash

# borrowed from https://github.com/chauncey-garrett/zsh-prompt-garrett
function _zsh_chpwd_hook {
    #
    # List the contents of the new directory.
    #

    # Check for dircolors
    if is-callable 'dircolors'; then

        # GNU flavor ls.
        if zstyle -t ':prezto:module:utility:ls' color; then
            ls --group-directories-first --color=auto
        else
            ls -F
        fi

        else

        # BSD flavor ls.
        if zstyle -t ':prezto:module:utility:ls' color; then
            ls -G
        else
            ls -F
        fi
    fi
}

if command -v autoload >/dev/null; then
    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd _zsh_chpwd_hook
fi
