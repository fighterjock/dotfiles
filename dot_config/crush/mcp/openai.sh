#!/usr/bin/env bash
# OpenAI MCP server — ChatGPT via the free web UI, no API key or browser
mcp add openai \
  --command "$HOME/.config/crush/docker-mcp" \
  --args openai \
  --args hangarbay/openai.mcp:latest
