# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 23:30 PST] - Documentation Access Pattern

**What I was trying to do:** Understand XanoScript syntax for creating run jobs and functions

**What the issue was:** The `xanoscript_docs` tool returns the same general documentation regardless of topic parameter. I called it with `functions`, `essentials`, and `run` topics but received nearly identical content each time.

**Why it was an issue:** Made it harder to find specific syntax patterns for run jobs vs functions. Had to rely on reading existing example files instead.

**Potential solution:** Topic-specific documentation that filters to relevant sections would be more useful.

---

## [2026-03-01 23:30 PST] - Run Job Syntax Discovery

**What I was trying to do:** Find the correct syntax for `run.job` construct

**What the issue was:** The documentation mentions `run.job` but doesn't provide clear syntax examples. I had to infer from existing files like `~/xs/fizzbuzz/run.xs`.

**Why it was an issue:** Without working examples in the repo, I would not have known that `run.job` uses `main = { name: "...", input: { ... } }` syntax.

**Potential solution:** Include a `run` topic with actual `run.job` syntax patterns and examples.

---
