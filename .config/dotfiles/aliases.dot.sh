#!/bin/bash

# Unbork prezto things
unalias o 2>/dev/null

alias rs='source ~/.zshrc;'

# Navigation {{{
alias ~='cd ~'
alias h='cd ~'
alias ..='cd ..'
alias gh='cd ~/GitHub'
alias dt='cd ~/Desktop'
alias dl='cd ~/Downloads'
# }}}

# Confirmation {{{
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
# }}}

# Server / Network {{{
alias header='curl -I'
alias headerc='curl -I --compress'
alias get='wget --content-disposition'
# }}}

# Fix vi/vim (and by vi/vim I mean me because I am the one who forgets) {{{
alias vi='nvim'
alias vim='nvim'
# shorthand because i Am LaZy
alias v='nvim'

# I'm addicted
alias :wq='exit'
alias :q!='exit'
alias :e='nvim'
# }}}

# Sane defaults {{{
alias grep='grep --exclude-dir=node_modules'
alias ls='ls --color=auto'
# }}}

# Git {{{
alias gs='git status -s'
alias gl='git log'
alias gls='git log --pretty=oneline'
alias gd='git diff'
alias gco='git checkout '
alias gb='git branch -vv '
alias gc='git commit -m '
alias gca='git commit -am '
alias gcf='git commit --amend'
alias ga='git add'
alias gp='git pull'
alias gpsh='git push'
alias gf='git fetch origin'
alias gfp='gf --prune'
alias gbr='git branch -r'
alias gbd='git branch -vv | grep ": gone" | awk "{print \$1}" | xargs git branch -d'
alias gbD='gbd -D'
alias grh='git reset --hard'
alias gss='git stash'
alias gsp='git stash pop'
# }}}
 
# NPM {{{
alias npr='npm run'

alias nps='npr start'
alias npt='npr test'
alias npb='npr build'
alias npl='npr lint'
alias npw='npr watch'
alias npd='npr dev'

alias npi='npm install'
alias npci='npm ci'
# }}}

# DB {{{
alias mongo='mongo --quiet'
# }}}

# Misc optional tool shortcuts {{{
if command -v shellcheck >/dev/null; then
    alias sc='shellcheck '
fi

if command -v xbindkeys >/dev/null; then
    alias get-xbindkeys-key-combo='xbindkeys -n -f ~/.config/xbindkeysrc -k'
fi
# }}}

# CI/CD {{{
alias maven-deploy='mvn -DaltDeploymentRepository=local-repo::default::file://$HOME/GitHub/maven-repo clean package deploy'

alias inspect-docker-context='printf "FROM scratch\n COPY . /" | DOCKER_BUILDKIT=1 docker build -f- -o context .'
# }}}

# Quick launchers {{{
alias vps-stats='ssh vps "TERM=$TERM" ./stats.sh'
alias note='nvim ~/notes/$(today)-notes.txt'
# }}}

# Info commands {{{
alias sysinfo='clear;neofetch;read -sk 1;echo'
alias song='echo "$(playerctl metadata artist) - $(playerctl metadata title)"'
alias localip='ip addr show | grep "inet " | grep -v "127.0.0.1" | head -n1 | awk '\''{print $2}'\'' | cut -d/ -f1'
alias lastcommit='git log -n 1 -pretty=format:"%H"'
alias md-view='node ~/GitHub/markdown-parser '
alias diskstat='df -h | grep -E '\''^/dev'\'' | sort | awk '\''{ print $1 ": " $3 "/" $2 " used (" $5 ")" }'\'''
alias today='date "+%D" | tr / -'
# }}}

# Templating commands {{{
alias joinme='echo -e "\n## Join Me\n[![Discord Badge](https://github.com/Rayzr522/ProjectResources/raw/master/RayzrDev/badge-small.png)](https://rayzr.dev/join)" >> '
# }}}

# Joke commands {{{
alias wininfo='xprop -id "$(xwininfo | grep -oE "0x[0-9a-f]{7}")"'
alias boopboom='kill "$(wininfo | grep _NET_WM_PID | cut -d" " -f3)"'
alias boxify='cowsay -W "$(( $(tput cols) - 3))" | head -n -5'
alias chill='screen -dmS music mpsyt /lunacy chillout, "$(( RANDOM % 20 ))"'
# }}}
