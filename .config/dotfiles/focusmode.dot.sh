#!/bin/bash

# A little joke of a system that I made to remind myself
# to focus instead of getting distracted by my terminal.
# Every time I open the terminal, it starts playing
# "Last Christmas" by Wham! 

({
    pushd ~/Music/TRAP &>/dev/null || return 1
    if [[ ! -f song.lock ]]; then
        touch song.lock
        mplayer Wham_-_Last_Christmas.mp3
        rm -rf song.lock
    fi
    popd &>/dev/null
} &>/dev/null &)

function stop-the-madness {
    pushd ~/Music/TRAP &>/dev/null || return 1

    if [[ -f song.lock ]]; then
        killall mplayer 2>/dev/null
        echo "Killed mplayer"
        rm -rf song.lock
        echo "Removed song.lock file"
    else
        touch song.lock
        echo "Preventing future playback"
    fi

    popd &>/dev/null
}
