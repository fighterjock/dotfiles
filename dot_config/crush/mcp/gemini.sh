#!/usr/bin/env bash
# Gemini MCP server — no API key, auto-bootstraps via headless Firefox in Docker
mcp add gemini \
  --command "$HOME/.config/crush/docker-mcp" \
  --args gemini \
  --args hangarbay/gemini.mcp:latest \
  --args --shm-size --args 256m
