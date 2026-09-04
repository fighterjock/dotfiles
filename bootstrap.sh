#!/usr/bin/env bash
# Bootstrap a new machine from the dotfiles repo. macOS and Linux, curl only.
set -euo pipefail

REPO="fighterjock/dotfiles"

if ! command -v chezmoi >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/chezmoi" ]; then
  echo "installing chezmoi"
  mkdir -p "$HOME/.local/bin"
  sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$HOME/.local/bin"
fi
export PATH="$HOME/.local/bin:$PATH"

if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh is required but not installed." >&2
  echo "Debian/Ubuntu: sudo apt install zsh" >&2
  echo "Fedora:        sudo dnf install zsh" >&2
  echo "Alpine:        sudo apk add zsh" >&2
  echo "Arch:          sudo pacman -S zsh" >&2
  exit 1
fi

chezmoi init --apply "$REPO"
echo "done - open a new shell"
