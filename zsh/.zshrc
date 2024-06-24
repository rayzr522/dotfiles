# ---------------------------
# rayzr's personal ZSH config
# ---------------------------

if [[ -d /opt/homebrew/bin ]]; then
    # this must run before anything else
    export PATH="/opt/homebrew/bin:$PATH"
fi

# All environment variables, aliases, etc. are handled in my organized dotfiles.
for file in ~/.config/zsh/init/*.zsh; do
  source "$file"
done

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

eval "$(starship init zsh)"
