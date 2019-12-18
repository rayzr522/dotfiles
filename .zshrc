#    (    rayzr522    )
#    ( rayzr.dev/join )
# ------------------------
# My personal ZSH config.
# ------------------------

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Prezto options
zstyle ':prezto:module:editor' key-bindings 'vi'
prompt garrett

# When using urxvt, go straight to tmux and reattach if a session is available.
if [[ $TERM == rxvt-unicode-256color ]] && [[ -z "$NO_TMUX" ]]; then
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

# Use viins keymap
bindkey -v

# Enable Ctrl-x-e to edit command line.
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Enable ZSH reverse-search with ^R.
bindkey '^R' history-incremental-search-backward

# zsh-autosuggestions support & config.
AUTOSUGGESTIONS_LOC=""

if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    AUTOSUGGESTIONS_LOC=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    AUTOSUGGESTIONS_LOC=/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ ! -z "$AUTOSUGGESTIONS_LOC" ]]; then
    source "$AUTOSUGGESTIONS_LOC"
    bindkey '^ ' autosuggest-accept
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
fi

unset AUTOSUGGESTIONS_LOC

# source: https://github.com/sorin-ionescu/prezto/issues/28
# Insert "sudo " at the beginning of the line
function prepend-sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
  fi
}

zle -N prepend-sudo
bindkey '^s' prepend-sudo

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi
