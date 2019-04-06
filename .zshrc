#    (    rayzr522    )
#    ( rayzr.dev/join )
# ------------------------
# My personal ZSH config.
# ------------------------

# Prezto options
zstyle ':prezto:module:editor' key-bindings 'vi'
prompt garrett

# When using urxvt, go straight to tmux and reattach if a session is available.
if [[ $TERM == rxvt-unicode-256color ]]; then
  if [[ ! -z "$(tmux list-sessions | grep -v '(attached)')" ]]; then
    exec tmux attach
  else
    exec tmux
  fi
fi

# All environment variables, aliases, etc. are handled in my organized dotfiles.
for file in ~/.config/dotfiles/*.dot.sh; do
  # shellcheck disable=SC1090
  # Yes, I really do want to source this file.
  source "$file"
done

# zsh-autosuggestions support & config.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

# Enable Ctrl-x-e to edit command line.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Enable ZSH reverse-search with ^R.
bindkey -v
bindkey '^R' history-incremental-search-backward
