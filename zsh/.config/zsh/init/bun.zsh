if [ -d ~/.bun ]; then
  # completions
  fpath+=(~/.bun)

  # bun
  export BUN_INSTALL="$HOME/.bun"
  add_to_path "$BUN_INSTALL/bin"
fi
