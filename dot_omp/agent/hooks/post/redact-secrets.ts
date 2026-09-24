import type { HookAPI } from "@oh-my-pi/pi-coding-agent/extensibility/hooks";

export default function (pi: HookAPI): void {
  pi.on("tool_result", async (event) => {
    if (event.isError) return;

    const secrets = [
      /sk-[a-zA-Z0-9]{20,}/g,
      /(?:ghp|gho|ghu|ghs)_[a-zA-Z0-9]{36,}/g,
      /api[_-]?key['"]?\s*[:=]\s*['"][a-zA-Z0-9_\-]{16,}['"]/gi,
      /(?:eyJ|R0VU)[a-zA-Z0-9_\-]{10,}(?:\.(?:[a-zA-Z0-9_\-]{10,})){1,}/g,
    ];

    let changed = false;
    const redacted = event.content.map(chunk => {
      if (chunk.type !== "text") return chunk;
      let text = chunk.text;
      for (const pattern of secrets) {
        const next = text.replace(pattern, "[REDACTED]");
        if (next !== text) { changed = true; text = next; }
      }
      return { ...chunk, text };
    });

    if (changed) return { content: redacted };
  });
}
