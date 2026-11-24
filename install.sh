#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS
case "$(uname -s)" in
  Darwin) export OS="macos" ;;
  Linux)  export OS="linux" ;;
  *)      echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

# Detect Arch
case "$(uname -m)" in
  x86_64|amd64)  export ARCH="amd64" ;;
  arm64|aarch64) export ARCH="arm64" ;;
  *)             export ARCH="$(uname -m)" ;;
esac

# Detect Distro
export DISTRO=""
export DISTRO_LIKE=""
if [[ "$OS" == "linux" && -f /etc/os-release ]]; then
  . /etc/os-release
  export DISTRO="$ID"
  export DISTRO_LIKE="${ID_LIKE:-$ID}"
fi

# Detect Package Manager
if command -v brew >/dev/null 2>&1; then
  export PKG_MANAGER="brew"
elif command -v apt-get >/dev/null 2>&1; then
  export PKG_MANAGER="apt"
elif command -v dnf >/dev/null 2>&1; then
  export PKG_MANAGER="dnf"
elif command -v pacman >/dev/null 2>&1; then
  export PKG_MANAGER="pacman"
elif command -v apk >/dev/null 2>&1; then
  export PKG_MANAGER="apk"
else
  export PKG_MANAGER=""
fi

# Backup previous Dotfiles if those exists
setup/backup.sh

if [[ "$OS" == "macos" && "$PKG_MANAGER" == "brew" ]]; then
  setup/homebrew.sh
elif [[ "$OS" == "linux" ]]; then
  setup/linux.sh
fi

stow -v -R -d "$SCRIPT_DIR" -t "$HOME" zsh

export PATH="$HOME/.local/bin:$PATH"
setup/mise.sh
setup/starship.sh
setup/git.sh
