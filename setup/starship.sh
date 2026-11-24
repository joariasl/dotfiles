#!/usr/bin/env bash

set -o pipefail

if ! command -v starship >/dev/null 2>&1 && [[ ! -x "/usr/local/bin/starship" ]]; then
  if ! curl -fsS https://starship.rs/install.sh | sh -s -- -y; then
    echo "Starship's installer failed; trying mise instead." >&2
  fi
fi

if ! command -v starship >/dev/null 2>&1; then
  if command -v mise >/dev/null 2>&1; then
    mise use -g starship
  else
    echo "Unable to install Starship: neither its installer nor mise is available." >&2
    exit 1
  fi
fi
