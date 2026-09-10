#!/usr/bin/env bash
# DevPass provider + live model pricing for Crush.
#
# Crush auto-discovers the DevPass catalog via openai-compat, but discovered
# models carry no prices, so the cost panel shows $0.0. This file fetches the
# public LLM Gateway model catalog (per-token prices, same numbers as the
# DevPass site) and registers every model with `model add` so Crush can
# compute real spend, then picks large/small defaults.
#
# The catalog is public and needs no credentials. On fetch failure the last
# good copy is reused so Crush still loads offline; if there is no copy the
# provider is left unpriced but usable.

provider add devpass \
  --name "DevPass" \
  --type openai-compat \
  --base-url "https://api.llmgateway.io/v1" \
  --api-key "${DEVPASS_API_KEY}"

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/devpass-usage"
[ "$(uname)" = Darwin ] && CACHE_DIR="$HOME/Library/Caches/devpass-usage"
CACHE="$CACHE_DIR/models.json"

JSON="$(curl -fsSL --max-time 8 https://api.llmgateway.io/v1/models 2>/dev/null)"
if [ -z "$JSON" ] && [ -s "$CACHE" ]; then
  JSON="$(cat "$CACHE")"
fi

if [ -n "$JSON" ] && command -v jq >/dev/null 2>&1; then
  mkdir -p "$CACHE_DIR" && printf '%s' "$JSON" > "$CACHE"

  FRAG="$(mktemp)"
  printf '%s' "$JSON" | jq -r '
    def pm: ((. // 0) | tonumber) * 1e12 | round / 1e6;
    .data[] |
    select(.id != "custom" and .id != "auto") |
    [
      .id,
      .name,
      (.context_length // 0),
      (.pricing.prompt | pm),
      (.pricing.completion | pm),
      (.pricing.input_cache_read | pm),
      (.pricing.input_cache_write | pm)
    ] | @tsv' |
  while IFS=$'\t' read -r id name ctx in out cr cw; do
    [ -z "$id" ] && continue
    args="model add devpass/$id"
    case "$name" in
      *"'"*) ;; # rare: name with a quote, keep the bare ID
      *) args="$args --name '$name'" ;;
    esac
    [ "$ctx" -gt 0 ] 2>/dev/null && args="$args --context-window $ctx"
    [ -n "$in" ] && args="$args --price-input $in"
    [ -n "$out" ] && args="$args --price-output $out"
    [ -n "$cr" ] && args="$args --price-cache-hit $cr"
    [ -n "$cw" ] && args="$args --price-cache-create $cw"
    printf '%s\n' "$args" >> "$FRAG"
  done
  source "$FRAG"
  rm -f "$FRAG"
fi
