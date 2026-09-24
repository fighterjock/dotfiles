import type { HookAPI } from "@oh-my-pi/pi-coding-agent/extensibility/hooks";

export default function (pi: HookAPI): void {
  pi.on("tool_result", async (event) => {
    if (event.isError) return;

    const MAX_LENGTH = 50000;
    let changed = false;
    const truncated = event.content.map(chunk => {
      if (chunk.type !== "text") return chunk;
      if (chunk.text.length <= MAX_LENGTH) return chunk;
      changed = true;
      return {
        ...chunk,
        text: chunk.text.slice(0, MAX_LENGTH) +
          `\n\n[... truncated to ${MAX_LENGTH} chars]`
      };
    });

    if (changed) return { content: truncated };
  });
}
