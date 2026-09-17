#!/usr/bin/env bash
# Jev MCP server — TypeSafe's System One model as typed MCP tools (classify,
# score, check, ask, models). Answers come back as probabilities and confidence,
# not text. Needs TYPESAFE_API_KEY, which lives in ~/.crush_env next to
# DEVPASS_API_KEY (create one at https://console.typesafe.ai/settings/keys).
# The key is baked into the container at create time, so run `docker rm jev`
# after rotating it.
#
# This file is sourced by crushrc, which already loads ~/.crush_env, so a
# missing key skips registration rather than baking an empty key into a
# container that every later launch would reuse.
if [ -n "${TYPESAFE_API_KEY:-}" ]; then
  mcp add jev \
    --command "$HOME/.config/crush/docker-mcp" \
    --args jev \
    --args hangarbay/jev.mcp:latest \
    --args --env --args "TYPESAFE_API_KEY=${TYPESAFE_API_KEY}"
else
  echo "jev: TYPESAFE_API_KEY is unset, skipping the jev MCP server (add it to ~/.crush_env)" >&2
fi
