#!/usr/bin/env bash
# DevPass usage MCP server (Docker) — replaces the devpass-usage skill.
# Credentials stored in macOS Keychain; set them once:
#   security add-generic-password -a "$USER" -s devpass-email -w "you@example.com"
#   security add-generic-password -a "$USER" -s devpass-password -w "..."
GW_EMAIL=$(security find-generic-password -s devpass-email -w 2>/dev/null)
GW_PASSWORD=$(security find-generic-password -s devpass-password -w 2>/dev/null)
GW_SESSION="${LLM_GATEWAY_SESSION_TOKEN:-}"
CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/devpass-usage"
[ "$(uname)" = Darwin ] && CACHE="$HOME/Library/Caches/devpass-usage"
mcp add devpass \
  --command "$HOME/.config/crush/docker-mcp" \
  --args devpass \
  --args hangarbay/devpass.mcp:latest \
  --args --user --args "$(id -u):$(id -g)" \
  --args --env --args "LLM_GATEWAY_SESSION_TOKEN=${GW_SESSION}" \
  --args --env --args "LLM_GATEWAY_EMAIL=${GW_EMAIL}" \
  --args --env --args "LLM_GATEWAY_PASSWORD=${GW_PASSWORD}" \
  --args --env --args "XDG_CACHE_HOME=/cache" \
  --args --volume --args "$CACHE:/cache/devpass-usage"
