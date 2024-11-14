if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
  alias zf='z "$(find . -type d | fzf)"'
fi
