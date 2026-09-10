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
