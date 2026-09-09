# Global instructions

## Todo lists are mandatory for multi-step work

- Before starting any task that needs 3+ tool calls, touches 2+ files, or has
  ordered dependencies, create a todo list with the `todos` tool FIRST and
  state the plan through it. Do not start acting before the list exists.
- Exactly one todo is `in_progress` at a time; mark each one `completed` the
  moment its work is done, not in a batch at the end.
- A todo item counts as done only when it is fully wired: implementation,
  config, and tests/verification all included.
- If the approach changes mid-task, update the todo list instead of abandoning
  it; keep it the source of truth for remaining work.
- Skipping the todo list is allowed only for trivial single-step tasks
  (one file, one edit, or pure Q&A). When in doubt, make the list.

## Gemini + OpenAI MCP for research and planning

You have access to two free web-UI MCP tools for offloading research,
brainstorming, and planning:

- `gemini_ask` — Google Gemini (AI Mode)
- `openai_ask` — OpenAI ChatGPT (anonymous web flow)

Use them to offload research, brainstorming, and planning:

- **Default dispatch** — for any research or web-query task, dispatch the
  question to BOTH `gemini_ask` and `openai_ask` up front. Do NOT start with
  `agentic_fetch`: it takes too long. Fire both model asks first (fast, free),
  then compare or combine their answers.
- **`agentic_fetch` only after the models** — reach for it after Gemini and
  OpenAI have answered, only when you want to dig deeper: exact quotes,
  primary sources, current docs, or verifying a disputed detail.
- **Research-heavy questions** — examples: "what's the best Go library for
  X", "how does OAuth2 PKCE work", "compare Redis vs Valkey tradeoffs".
- **Planning and design** — when the user asks "how would you build X" or
  "plan out Y", use either model to generate an initial plan or architecture,
  then refine it based on what you find in the codebase.
- **Summarization** — if you need to understand a concept or technology you're
  unfamiliar with, ask for a concise explanation instead of reading lengthy
  docs.
- **Cross-check when it matters** — divergent answers between the two models
  usually mean the question needs verification against primary sources; that
  is the case where `agentic_fetch` earns its keep. Use the two models'
  different training/priorities as a sanity check (e.g. Gemini for
  Google-ecosystem topics, ChatGPT for OpenAI/ecosystem topics).
- Both are free with no rate limits (web UIs). Prefer them over web searches
  for conceptual questions, comparisons, and planning tasks.

Caveat: the anonymous ChatGPT flow can throttle under heavy use; if
`openai_ask` starts failing, fall back to `gemini_ask`.

## Git branch naming

- Use `main` as the default branch for all new GitHub projects and repos.
  Never create new repositories with `master`.
