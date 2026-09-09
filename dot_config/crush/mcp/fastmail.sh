#!/usr/bin/env bash
# Fastmail MCP server — official hosted endpoint, OAuth 2.0 (dynamic client
# registration + PKCE). First connect opens a browser consent flow.
mcp add fastmail \
  --type http \
  --url "https://api.fastmail.com/mcp" \
  --oauth true
