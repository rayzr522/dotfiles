#!/bin/bash

# Unbork prezto things
unalias o 2>/dev/null
unalias gm 2>/dev/null

alias rs='source ~/.zshrc;'

# Navigation {{{
alias ~='cd ~'
alias h='cd ~'
alias ..='cd ..'
alias dt='cd ~/Desktop'
alias dl='cd ~/Downloads'
alias dotfiles='cd ~/GitHub/dotfiles'
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
alias sirv='pnpx --yes --package sirv-cli sirv'
# }}}

# Fix vi/vim (and by vi/vim I mean me because I am the one who forgets) {{{
alias vi='nvim'
alias vim='nvim'
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
alias gbc='git branch --show-current'
alias grh='git reset --hard'
alias gss='git stash save'
alias gsp='git stash pop'
alias grb='git rebase'
alias gtl='git tag | tr - \~ | sort -V | tr \~ -'

alias tickets='grep -oE "[A-Z]+-[0-9]+"'
alias jql='xargs | tr " " "," | xargs -I{} echo "id in ({})"'
alias get-latest-tag-range='echo -n "$(gtl | tail -n2 | head -n1)..$(gtl | tail -n1)"'
alias get-release-tickets='git --no-pager log --pretty=oneline "$(get-latest-tag-range)" 1>&2; echo "$(tput setaf 2)\nuse the following JQL query to see all tickets:\n$(tput sgr0)$(git log --format="%s" "$(get-latest-tag-range)" | tickets | jql)"'
# }}}
 
# NPM {{{
alias npr='npm run'

alias nps='npr start'
alias npt='npr test'
alias npb='npr build'
alias nprb='npr rebuild'
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
alias scanrepos='find . -maxdepth 2 -name .git -type d -prune | xargs dirname | sed "s;./;;g" | while read -r repo; do [ -n "$(git -C "$repo" remote -v)" ] && [ -z "$(git -C "$repo" status --porcelain)" ] && echo "$(tput setaf 2)$repo" || echo "$(tput setaf 1)$repo"; done | sort -r'
alias path='echo "$PATH" | tr : "\n"'
# }}}

# Joke commands {{{
alias wininfo='xprop -id "$(xwininfo | grep -oE "Window id: 0x[0-9a-f]{6,7}" | cut -d" " -f3)"'
alias boopboom='kill "$(wininfo | grep _NET_WM_PID | cut -d" " -f3)"'
alias boxify='cowsay -W "$(( $(tput cols) - 3))" | head -n -5'
alias chill='screen -dmS music mpsyt /lunacy chillout, "$(( RANDOM % 20 ))"'
# }}}

# Docker aliases {{{
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:latest'
# }}}
