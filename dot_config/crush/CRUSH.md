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

## Parley MCP: which tool to invoke

The parley server exposes external AIs (Gemini and ChatGPT) as tools with no
API keys, over their free web UIs. Every tool takes a `provider` argument
(`both` by default); `both` fans out concurrently, labels each answer, and
still returns the other provider when one fails.

Pick the tool from the state of the task, not from what sounds closest:

- **`review`** — you have an artifact to judge: a diff, a plan, a code change.
  Returns APPROVE / REQUEST_CHANGES / NEEDS_DISCUSSION with findings. Run this
  on every non-trivial change (see the self-review section below).
- **`diagnose`** — something is failing and the cause is uncertain. Pass the
  problem, the observations or logs, and the fixes already tried; it returns
  ranked competing causes and the tests that tell them apart. It needs
  evidence: with no evidence, use `ask` instead.
- **`decide`** — you must pick exactly one option from a finite set that is
  already enumerated, against stated criteria. If the options are not yet
  known, use `ask` to explore them first.
- **`plan`** — you know what to accomplish but need an ordered breakdown:
  phases, deliverables, risks, open questions.
- **`ask`** — the fallback: research, explanations, comparisons, brainstorming,
  or any external judgment no specialized tool above covers.

There is deliberately no tool for specs, summaries, explanations, or
translations; a good `ask` prompt covers those. Do not treat `ask` as the
default to reach for first, and do not reach for a specialized tool when its
precondition is not met.

## Parley MCP: how to dispatch

- **Both providers by default** — for any research or web-query task, dispatch
  to both up front. Do NOT start with `agentic_fetch`: it takes too long. Fire
  the model asks first (fast, free), then compare or combine their answers.
- **`agentic_fetch` only after the models** — reach for it when the providers
  diverge or you need primary sources: exact quotes, current docs, or verifying
  a disputed detail. Divergence usually means the answer needs verification.
- **Sanity-check across providers** — Gemini tends to be stronger on
  Google-ecosystem topics, ChatGPT on OpenAI-ecosystem topics.
- **Prefer parley over web searches** for conceptual questions, comparisons,
  and planning tasks.
- **Fallback** — the anonymous ChatGPT flow can throttle under heavy use; if it
  starts failing, pass `provider: gemini` so the call still returns.

## Self-review every code change with the review tool

- After implementing a code change and before reporting it done, send the diff
  to the parley `review` tool (both providers by default) and read the verdict.
- Treat the review as advice, not authority: verify every blocking finding
  against the codebase before acting on it. Reviewers hallucinate; if a finding
  contradicts a passing build, a passing test, or the existing code, the
  finding is wrong. Never apply a fix you have not confirmed is real.
- Act on real findings, fix, and re-run the tests. Then report what the review
  caught and what you rejected, with the evidence for the rejection.
- Skip only for trivial edits (comments, docs wording, formatting).

## Git branch naming

- Use `main` as the default branch for all new GitHub projects and repos.
  Never create new repositories with `master`.

## Writing files: split large writes into chunks

Empirically stress-tested: the Crush `write` tool has no size limit and writes
single-call files up to ~18KB cleanly, well-formed, with no truncation. There
is no hard breakpoint at any realistic HTML file size. The active model
(deepseek-v4-flash) has a huge output ceiling (384K tokens), so a single
`write` call reliably completes whole files.

The real cost of large write calls is *latency*, not correctness: HTML is
token-verbose (Tailwind classes, repeated closing tags), so a big page costs
4-5x more tokens than the same logic in Python, and generation is bound by
tokens/sec. A large single call also loads more context and can produce a
noticeable pause while the whole content streams in one gulp.

Guidance for writing files:

- **Small files (under ~20KB)** — write the whole thing in a single `write`
  call. It's fast and complete.
- **Large files (roughly 20-100KB)** — still fine as a single call, but expect
  it to take longer (token throughput wall). Prefer asking for a *surgical
  patch* (change only the relevant section) over regenerating the whole file.
- **Very large files (100KB+)** — prefer splitting the content across multiple
  focused `write`/`edit` calls (e.g. one logical section per call) rather than
  one giant blob. This keeps each call fast, keeps context small, and avoids
  long single-stream pauses. Do not pad a single call beyond what one logical
  unit of work needs.

General rules to keep file writes fast:

- Prefer `edit` (surgical diff) over rewriting a whole file when only part
  changes.
- Keep files modular (components / one section per file) so context stays
  small.
- Use component libraries (e.g. `<Button>`, `<Card>`) instead of long raw
  class strings.
- For mechanical HTML edits, prefer a fast model; save the smart model for
  architecture and logic.
