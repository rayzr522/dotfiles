#    (    rayzr522    )
#    ( rayzr.dev/join )
# ------------------------
# My personal ZSH config.
# ------------------------

if [[ -d /opt/homebrew/bin ]]; then
    # this must run before anything else
    export PATH="/opt/homebrew/bin:$PATH"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Don't autocorrect
unsetopt correct
# Don't trust cache for completions -- https://unix.stackexchange.com/a/2180
zstyle ":completion:*:commands" rehash 1

# When using urxvt, go straight to tmux and reattach if a session is available.
if [[ $TERM =~ (rxvt-unicode|xterm)-256color ]] && [[ -z "$NO_TMUX" ]] && command -v tmux >/dev/null; then
  if [[ ! -z "$(tmux list-sessions | grep -v '(attached)')" ]]; then
    exec tmux attach
  else
    exec tmux
  fi
fi

# All environment variables, aliases, etc. are handled in my organized dotfiles.
for file in ~/.config/dotfiles/*.dot.sh; do
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

function copy-buffer {
    # my custom alias will be used on linux
    echo -n "$BUFFER" | pbcopy
}

zle -N copy-buffer
bindkey '^[c' copy-buffer

### zsh plugins ###

export ZSH_CUSTOM="$HOME/.config/zsh"

# zsh-autosuggestions
source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^ ' autosuggest-accept
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

# fast-syntax-highlighting
source "$ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
# fix for freezing when highlighting ssh commands
FAST_HIGHLIGHT[chroma-ssh]=""

# history-search-multi-word
source "$ZSH_CUSTOM/plugins/history-search-multi-word/history-search-multi-word.plugin.zsh"
zstyle :plugin:history-search-multi-word reset-prompt-protect 3

eval "$(starship init zsh)"
