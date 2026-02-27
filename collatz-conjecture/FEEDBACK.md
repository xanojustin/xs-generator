# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 07:02 PST] - Run job syntax confusion

**What I was trying to do:** Create a run job that tests the collatz-conjecture function with multiple inputs

**What the issue was:** I initially wrote the run.xs file with a `stack` block containing the test logic, similar to how a function is structured. This caused validation errors because run.jobs have a completely different syntax.

**Why it was an issue:** The error messages were clear about the invalid arguments (`description`, `stack`), but I had to call `xanoscript_docs(topic="run")` to understand the correct syntax. The documentation showed that run.jobs use `main = { name: "...", input: {} }` instead of a `stack` block.

**Potential solution:** The quick reference for run jobs in the documentation is very minimal. It would help to have a side-by-side comparison or a note in the essentials guide that explicitly states "run.jobs are configuration-only and cannot contain logic - they only specify which function to run".

---

## [2026-02-27 07:03 PST] - One function per file limitation

**What I was trying to do:** Put both the `collatz-conjecture` function and the `collatz-test` function in the same file under `function/collatz-conjecture.xs`

**What the issue was:** The validator rejected the file with error "Redundant input, expecting EOF but found: function" at the start of the second function definition.

**Why it was an issue:** I assumed I could group related functions together in one file, but XanoScript requires exactly one function per .xs file. I had to split them into separate files.

**Potential solution:** The error message was actually helpful ("expecting EOF"), but it would be clearer if it explicitly said "Only one function definition allowed per file" or "Each function must be in its own .xs file". The `functions` topic documentation doesn't explicitly mention this limitation.

---

## [2026-02-27 07:00 PST] - Documentation discovery workflow

**What I was trying to do:** Learn XanoScript syntax from scratch since my training data doesn't include it

**What the issue was:** I needed to make multiple MCP calls to get all the documentation I needed (essentials, functions, run, syntax). The topic discovery worked well using the index mode, but I had to make several calls.

**Why it was an issue:** It took 4 separate MCP calls to gather the necessary documentation before I could start writing code. While not a major blocker, it adds friction to the development workflow.

**Potential solution:** Consider adding a "getting-started" or "quickstart" topic that bundles the most commonly needed documentation for new users (essentials + functions + syntax + types) in one call. Or document in the readme that these are the essential topics for writing functions and run jobs.

---

## [2026-02-27 07:01 PST] - Positive validation experience

**What was working well:** The `validate_xanoscript` tool with `directory` parameter made it easy to validate all files at once. The error messages included line/column numbers and helpful suggestions (like the "int" vs "integer" hint).

**Feedback:** The validation tool is excellent! Fast feedback loop with clear error locations. The suggestion feature is particularly helpful for common mistakes.

---
