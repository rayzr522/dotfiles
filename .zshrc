# ---------------------------
# rayzr's personal ZSH config
# ---------------------------

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

# All environment variables, aliases, etc. are handled in my organized dotfiles.
for file in ~/.config/dotfiles/*.dot.sh; do
  source "$file"
done

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

eval "$(starship init zsh)"
