#!/usr/bin/env bash

# Set zsh as the default login shell if installed
# Run only inside a Coder workspace on Linux
if { [ "${CODER:-}" = "true" ] || [ -n "${CODER_WORKSPACE_ID:-}" ]; } && [ "$(uname -s)" = "Linux" ]; then
  if command -v zsh >/dev/null 2>&1; then
    ZSH_PATH="$(command -v zsh)"
    CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

    if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
      sudo chsh -s "$ZSH_PATH" "$USER"
    fi
  fi
fi

stow -v -R --no-folding -d "$SCRIPT_DIR" -t "$HOME" zsh

# Update all zinit plugins in parallel
TERM=xterm-256color zsh -c 'source ~/.zshrc; zinit update --all'
