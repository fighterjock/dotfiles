#!/usr/bin/env bash
# Parley MCP server — ask Gemini and ChatGPT for a second opinion, no API key
# (tools: ask_gemini, ask_chatgpt). Supersedes gemini.sh and openai.sh.
# Gemini bootstraps its session via headless Firefox, so bump shm.
mcp add parley \
  --command "$HOME/.config/crush/docker-mcp" \
  --args parley \
  --args hangarbay/parley.mcp:latest \
  --args --shm-size --args 256m
