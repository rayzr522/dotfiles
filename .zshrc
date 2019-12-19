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

# source: https://github.com/sorin-ionescu/prezto/issues/28
# Insert "sudo " at the beginning of the line
function prepend-sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
  fi
}

zle -N prepend-sudo
bindkey '^s' prepend-sudo

# and then my own addition

function un-prepend-sudo {
  if [[ $BUFFER = "sudo "* ]]; then
      (( CURSOR -= 5 ))
      BUFFER="${BUFFER[6,-1]}"
  fi
}

zle -N un-prepend-sudo
bindkey '^[s' un-prepend-sudo

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

### zsh plugins ###

export ZSH_CUSTOM="$HOME/.config/zsh"

# zsh-autosuggestions
source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^ ' autosuggest-accept
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

# fast-syntax-highlighting
source "$ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# history-search-multi-word
source "$ZSH_CUSTOM/plugins/history-search-multi-word/history-search-multi-word.plugin.zsh"
zstyle :plugin:history-search-multi-word reset-prompt-protect 1
