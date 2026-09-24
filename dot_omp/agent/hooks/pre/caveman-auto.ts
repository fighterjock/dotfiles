import type { HookAPI } from "@oh-my-pi/pi-coding-agent/extensibility/hooks";

export default function (pi: HookAPI): void {
  pi.on("before_agent_start", async (_event, _ctx) => {
    // Inject caveman lite mode: no filler/hedging, keep articles + full sentences
    return {
      message: {
        role: "system",
        content: [
          { 
            type: "text", 
            text: `CAVEMAN LITE MODE: Professional but tight. No filler (just/really/basically/actually/simply), no pleasantries (sure/certainly/of course/happy to), no hedging (probably/might/perhaps). Keep articles (a/an/the). Full sentences. Active voice. Present tense. Technical terms exact. One idea per sentence. Standard acronyms OK.`
          }
        ]
      }
    };
  });
}
