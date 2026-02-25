# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 22:35 PST] - MCP Parameter Naming Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The initial prompt documentation showed `files` as the parameter name, but the actual MCP tool uses `file_paths` (with underscore and 's' at the end). The error message was: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** I had to check the tool schema with `mcporter list` to discover the correct parameter name. This added an extra step that could be avoided with clearer documentation in the prompt.

**Potential solution:** Update the cron job prompt to use `file_paths` instead of `files` when describing the validation workflow.

---

## [2026-02-24 22:38 PST] - Successful First-Time Validation

**What I was trying to do:** Write a complete XanoScript exercise with run.job and function

**What the issue was:** None - both files passed validation on the first attempt

**Why it was an issue:** N/A - This was a success case

**Potential solution:** The documentation was clear enough that I could write working XanoScript code without iteration. Key helpful docs:
- `xanoscript_docs({ topic: "run" })` for run.job syntax
- `xanoscript_docs({ topic: "functions" })` for function structure
- `xanoscript_docs({ topic: "quickstart" })` for common patterns

---
