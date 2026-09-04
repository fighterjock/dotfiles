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
