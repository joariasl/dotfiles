#!/usr/bin/env bash

[ -f $HOME/.zshrc ] && cp $HOME/.zshrc{,-bak-`date +%Y-%m-%d_%H-%M-%S`} || true
[ -f $HOME/.config/mise/config.toml ] && cp $HOME/.config/mise/config.toml{,-bak-`date +%Y-%m-%d_%H-%M-%S`} || true
