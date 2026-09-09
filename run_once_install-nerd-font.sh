#!/usr/bin/env bash
# Installs JetBrainsMono Nerd Font, required by nvim file tree / completion
# icons (nvim-web-devicons, blink.cmp). macOS only. Safe to re-run.
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
  echo "skipping nerd font install: not macOS"
  exit 0
fi

FONT_DIR="$HOME/Library/Fonts"
FONT_FILE="$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf"

if [ -f "$FONT_FILE" ]; then
  echo "JetBrainsMono Nerd Font already installed"
  exit 0
fi

echo "installing JetBrainsMono Nerd Font"
TAG="$(curl -fsSL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
  | grep -o '"tag_name": *"[^"]*"' | head -1 | cut -d'"' -f4)"
curl -fsSL -o /tmp/jetbrainsmono-nerd-font.zip \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/${TAG}/JetBrainsMono.zip"
TMP="$(mktemp -d)"
unzip -q /tmp/jetbrainsmono-nerd-font.zip '*.ttf' -d "$TMP"
mkdir -p "$FONT_DIR"
cp "$TMP"/JetBrainsMonoNerdFont-*.ttf "$TMP"/JetBrainsMonoNerdFontMono-*.ttf "$FONT_DIR/"
rm -rf "$TMP" /tmp/jetbrainsmono-nerd-font.zip

echo "done: JetBrainsMono Nerd Font installed (select it in your terminal settings)"
