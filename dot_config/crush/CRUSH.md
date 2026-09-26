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
