#!/bin/bash

# Unbork prezto things
unalias o 2>/dev/null

alias rs='source ~/.zshrc;'

# Navigation
alias ~='cd ~'
alias ..='cd ..'
alias gh='cd ~/GitHub'
alias dt='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias ls='ls --color=auto'

# Fix vi/vim (and by vi/vim I mean me because I am the one who forgets)
alias vi='nvim'
alias vim='nvim'

# Git
alias gs='git status -s'
alias maven-deploy='mvn -DaltDeploymentRepository=local-repo::default::file://$HOME/GitHub/maven-repo clean package deploy'

# Quick launchers
alias wine-steam='wine "C:\Program Files\Steam\Steam.exe" 2>/dev/null >/dev/null &'
alias dotfiles='code ~/.zshrc ~/.config/dotfiles/'
alias duckgame='(wine "C:\Program Files\Steam\steamapps\common\Duck Game\DuckGame.exe" &>/dev/null &)'

alias restart-vps-bots='ssh bots@vps.rayzr.tech /home/bots/start-bots -v'

# Joke commands
alias doesinternetsuck='speedtest --simple --server 1298'
alias make-sure-sharpbot-is-running='systemctl --user list-units | grep sharp.service | grep -q "loaded active running" || { systemctl restart --user sharp.service && echo SharpBot restarted }'
alias wininfo='xprop -id "$(xwininfo | grep -oE "0x[0-9a-f]{7}")"'
alias boopboom='kill "$(wininfo | grep _NET_WM_PID | cut -d" " -f3)"'
alias boxify='cowsay -W "$(( $(tput cols) - 3))" | head -n -5'
alias chill='screen -dmS music mpsyt /lunacy chillout, "$(( RANDOM % 20 ))"'

# Info commands
alias sysinfo='clear;neofetch;read -sk 1;echo'
alias song='echo "$(playerctl metadata artist) - $(playerctl metadata title)"'
alias localip='ip addr show | grep "inet " | grep -v "127.0.0.1" | head -n1 | awk '\''{print $2}'\'' | cut -d/ -f1'
alias lastcommit='git log -n 1 -pretty=format:"%H"'
alias md-view='node ~/GitHub/markdown-parser '
alias diskstat='df -h | grep -E '\''^/dev'\'' | sort | awk '\''{ print $1 ": " $3 "/" $2 " used (" $5 ")" }'\'''

# Templating commands
alias joinme='echo -e "\n## Join Me\n[![Discord Badge](https://github.com/Rayzr522/ProjectResources/raw/master/RayzrDev/badge-small.png)](https://discord.io/rayzrdevofficial)" >> '

# Confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Server / Network
alias header='curl -I'
alias headerc='curl -I --compress'
alias get='wget --content-disposition'

# Method-based aliases
alias factors='ruby-factors'
