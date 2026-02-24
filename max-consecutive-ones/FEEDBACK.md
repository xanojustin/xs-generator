# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 04:05 PST] - Run job syntax confusion

**What I was trying to do:** Create a run.job that tests multiple function calls with different inputs

**What the issue was:** I incorrectly assumed run.job could have a `stack` block like functions do. I tried to write:
```xs
run.job "test" {
  description = "..."
  stack { ... }
  response = ...
}
```

But run.job has a completely different syntax - it only accepts `main = { name: "...", input: {...} }` and optional `env`.

**Why it was an issue:** This blocked me because I wanted to run multiple test cases in one run job. The error messages were helpful but I had to discover the correct pattern by looking at existing examples in the repo.

**Potential solution:** 
1. The docs could show a "Testing Pattern" example where a run.job calls a test-runner function
2. The error message could suggest "run.job cannot contain logic directly - call a function instead"

---

## [2025-02-24 04:08 PST] - Input block formatting for empty inputs

**What I was trying to do:** Create a function with no required inputs (the test runner)

**What the issue was:** The documentation says empty input blocks need braces on separate lines:
```xs
input {
}
```

I wasn't sure if this would validate correctly but it did pass.

**Why it was an issue:** Minor uncertainty about formatting convention

**Potential solution:** The docs are clear on this, just a note that it works as documented

---

## [2025-02-24 04:10 PST] - Documentation lookup was smooth

**What went well:** 
- The MCP `xanoscript_docs` tool worked great for finding syntax information
- Having existing examples in `~/xs/` to reference was extremely helpful
- The validation tool gave clear error messages with line numbers

**No issues to report for this part - the tooling worked as expected**
