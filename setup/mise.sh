#!/usr/bin/env bash

if ! command -v mise >/dev/null 2>&1 && [[ ! -x "$HOME/.local/bin/mise" ]]; then
  curl -fsSL https://mise.run | sh
  "$HOME/.local/bin/mise" --version
fi

stow -v -R -d "$SCRIPT_DIR" -t "$HOME" mise
mise install
