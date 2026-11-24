#!/usr/bin/env bash

if ! command -v starship >/dev/null 2>&1 && [[ ! -x "/usr/local/bin/starship" ]]; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

if ! command -v starship >/dev/null 2>&1; then
  mise use -g starship
fi

