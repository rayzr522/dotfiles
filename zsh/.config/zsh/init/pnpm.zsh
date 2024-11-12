if [ -d ~/.local/share/pnpm ]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  add_to_path "$PNPM_HOME"
fi
