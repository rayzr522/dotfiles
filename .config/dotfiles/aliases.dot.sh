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

# Confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Server / Network
alias header='curl -I'
alias headerc='curl -I --compress'
alias get='wget --content-disposition'

# Fix vi/vim (and by vi/vim I mean me because I am the one who forgets)
alias vi='nvim'
alias vim='nvim'

# Sane defaults
alias grep='grep --exclude-dir=node_modules'
alias ls='ls --color=auto'

# Git
alias gs='git status -s'
alias gl='git log'
alias gls='git log --pretty=oneline'
alias gd='git diff'
alias gco='git checkout '
alias gb='git checkout -b '
alias gc='git commit -m '
alias gca='git commit -am '
alias gcf='git commit --amend'
alias gp='git pull'
alias gps='git push'
alias gf='git fetch origin'
alias gbr='git branch -r'
alias grh='git reset --hard'
alias gss='git stash'
alias gsp='git stash pop'

# CI/CD
alias maven-deploy='mvn -DaltDeploymentRepository=local-repo::default::file://$HOME/GitHub/maven-repo clean package deploy'

# Quick launchers
alias vps-stats='ssh vps "TERM=$TERM" ./stats.sh'

# Info commands
alias sysinfo='clear;neofetch;read -sk 1;echo'
alias song='echo "$(playerctl metadata artist) - $(playerctl metadata title)"'
alias localip='ip addr show | grep "inet " | grep -v "127.0.0.1" | head -n1 | awk '\''{print $2}'\'' | cut -d/ -f1'
alias lastcommit='git log -n 1 -pretty=format:"%H"'
alias md-view='node ~/GitHub/markdown-parser '
alias diskstat='df -h | grep -E '\''^/dev'\'' | sort | awk '\''{ print $1 ": " $3 "/" $2 " used (" $5 ")" }'\'''

# Templating commands
alias joinme='echo -e "\n## Join Me\n[![Discord Badge](https://github.com/Rayzr522/ProjectResources/raw/master/RayzrDev/badge-small.png)](https://discord.io/rayzrdevofficial)" >> '

# Joke commands
alias wininfo='xprop -id "$(xwininfo | grep -oE "0x[0-9a-f]{7}")"'
alias boopboom='kill "$(wininfo | grep _NET_WM_PID | cut -d" " -f3)"'
alias boxify='cowsay -W "$(( $(tput cols) - 3))" | head -n -5'
alias chill='screen -dmS music mpsyt /lunacy chillout, "$(( RANDOM % 20 ))"'
