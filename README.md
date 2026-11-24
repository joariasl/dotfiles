# Dotfiles

Dotfiles for setting up a professional development environment on macOS and Coder workspaces.

## Requirements

- **Bash:** Required to execute `install.sh` and the scripts inside `setup/*.sh`.
- **Core Utilities:** `git` and `curl` must be pre-installed.
- **Package Manager:** One of `Homebrew`, `apt`, `dnf`, `pacman`, or `apk`.

## Installation

Clone the repository directly (forking it first is recommended for security), or add it to your Coder workspace configuration to clone automatically, then run:

```sh
./install.sh
```

This will install:

- **Backup first**: Back up the previous important dotfiles in format +%Y-%m-%d_%H-%M-%S
- **Dependencies:** `stow`, `fzf` and `zsh` using the OS Package Manager.
- **mise:** Installed via the official shell script.
- **Starship:** Installed via the official shell script (falls back to `mise` if that fails).
- **Symlinks of Dofiles:** Uses GNU Stow to link the dotfiles into your home directory (`~`).
