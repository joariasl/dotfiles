#!/usr/bin/env bash

SUDO=""
if [[ "${EUID:-$(id -u)}" -ne 0 ]] && command -v sudo >/dev/null 2>&1; then
  SUDO="sudo"
fi

STANDARD_PKGS="stow fzf zsh"

case "$PKG_MANAGER" in
  apt)
    DEBIAN_FRONTEND=noninteractive $SUDO apt-get update -qq
    DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y -qq \
      $STANDARD_PKGS \
      starship
    ;;
  dnf)
    $SUDO dnf install -y -q \
      $STANDARD_PKGS
    ;;
  pacman)
    $SUDO pacman -Sy --noconfirm --needed \
      $STANDARD_PKGS \
      starship
    ;;
  apk)
    $SUDO apk add --no-cache \
      $STANDARD_PKGS \
      starship
    ;;
esac

