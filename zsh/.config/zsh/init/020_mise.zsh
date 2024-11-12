if [ -x ~/.local/bin/mise ]; then
  eval "$(~/.local/bin/mise activate zsh)"
  # ensure we run this asap to have path updated
  _mise_hook
fi
