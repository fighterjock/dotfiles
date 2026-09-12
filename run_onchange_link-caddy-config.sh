#!/usr/bin/env bash
# Keep /opt/homebrew/etc/Caddyfile (the config the brew caddy service reads)
# pointing at the chezmoi-managed copy in this repo, so edits never diverge.
set -euo pipefail

source_file="$HOME/.local/share/chezmoi/caddy/Caddyfile"
target="/opt/homebrew/etc/Caddyfile"

if [ ! -f "$source_file" ]; then
  echo "caddy source config not found: $source_file" >&2
  exit 0
fi

mkdir -p "$(dirname "$target")"

if [ -L "$target" ] && [ "$(readlink "$target")" = "$source_file" ]; then
  echo "caddy config symlink already correct"
  exit 0
fi

if [ -e "$target" ] && [ ! -L "$target" ]; then
  if cmp -s "$target" "$source_file"; then
    # Identical real file: drop it for the symlink.
    rm "$target"
  else
    # Divergent real file: back it up rather than clobber.
    backup="$target.bak-$(date +%Y%m%d%H%M%S)"
    echo "backing up divergent Caddyfile to $backup"
    mv "$target" "$backup"
  fi
fi

ln -sfn "$source_file" "$target"
echo "symlinked $target -> $source_file"
