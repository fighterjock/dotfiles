#!/usr/bin/env bash
# Installs fzf and the two zsh plugins via curl only. Works on macOS and Linux.
# Safe to re-run: skips anything already installed.
set -euo pipefail

OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
case "$OS" in
  darwin|linux) ;;
  *) echo "unsupported OS: $OS" >&2; exit 1 ;;
esac

case "$(uname -m)" in
  x86_64|amd64)  FZF_ARCH=amd64 ;;
  aarch64|arm64) FZF_ARCH=arm64 ;;
  *) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

mkdir -p "$HOME/.local/bin" "$HOME/.zsh/plugins"

if [ ! -x "$HOME/.local/bin/fzf" ]; then
  TAG="$(curl -fsSL https://api.github.com/repos/junegunn/fzf/releases/latest \
    | grep -o '"tag_name": *"[^"]*"' | head -1 | cut -d'"' -f4)"
  VER="${TAG#v}"
  echo "installing fzf $TAG"
  curl -fsSL -o /tmp/fzf.tar.gz \
    "https://github.com/junegunn/fzf/releases/download/${TAG}/fzf-${VER}-${OS}_${FZF_ARCH}.tar.gz"
  tar -xzf /tmp/fzf.tar.gz -C "$HOME/.local/bin" fzf
  chmod +x "$HOME/.local/bin/fzf"
  rm -f /tmp/fzf.tar.gz
else
  echo "fzf already installed"
fi

install_plugin() {
  local name="$1" url="$2" file="$3"
  if [ -f "$file" ]; then
    echo "$name already installed"
    return
  fi
  echo "installing $name"
  curl -fsSL -o "/tmp/${name}.tar.gz" "$url"
  mkdir -p "$HOME/.zsh/plugins/$name"
  tar -xzf "/tmp/${name}.tar.gz" -C "$HOME/.zsh/plugins/$name" --strip-components=1
  rm -f "/tmp/${name}.tar.gz"
}

install_plugin zsh-autosuggestions \
  "https://codeload.github.com/zsh-users/zsh-autosuggestions/tar.gz/refs/tags/v0.7.0" \
  "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

install_plugin zsh-syntax-highlighting \
  "https://codeload.github.com/zsh-users/zsh-syntax-highlighting/tar.gz/refs/tags/0.8.0" \
  "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

echo "done: fzf and zsh plugins ready"
