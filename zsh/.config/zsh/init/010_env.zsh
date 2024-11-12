# configure tools
export EDITOR=nvim
export VISUAL="$EDITOR"

# passwordless sudo via keychain
if [ "$(uname)" = Linux ] && command -v secret-tool >/dev/null; then
    export SUDO_ASKPASS="$SCRIPTS/askpass-secret-tool"
    alias sudo="sudo -A"
fi

# fix gpg
export GPG_TTY=$(tty)

add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.bin"
add_to_path "./node_modules/.bin"

if [ -f "/etc/wsl.conf" ]; then
   add_to_path "$HOME/.bin/wsl"
fi
