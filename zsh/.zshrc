# ---------------------------
# rayzr's personal ZSH config
# ---------------------------

if [[ -d /opt/homebrew/bin ]]; then
    # this must run before anything else
    export PATH="/opt/homebrew/bin:$PATH"
fi

# optional: mise
if [ -x ~/.local/bin/mise ]; then
    eval "$(~/.local/bin/mise activate zsh)"
    # ensure we run this asap to have path updated
    _mise_hook
fi

# optional: starship
if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
fi

# All environment variables, aliases, etc. are handled in my organized dotfiles.
for file in ~/.config/zsh/init/*.zsh; do
  source "$file"
done

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

