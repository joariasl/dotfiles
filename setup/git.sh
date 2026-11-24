#!/usr/bin/env bash

stow -v -R --no-folding -d "$SCRIPT_DIR" -t "$HOME" git
git config --global core.excludesFile "$HOME/.gitignore_global"
