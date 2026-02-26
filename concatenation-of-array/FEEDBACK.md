# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 20:32 PST] - Validation Parameter Confusion

**What I was trying to do:** Validate XanoScript files after creation

**What the issue was:** The `validate_xanoscript` tool failed with "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" when I used `path=run.xs`. The parameter is `file_path`, not `path`.

**Why it was an issue:** The error message was clear but I initially guessed the wrong parameter name. I had to check the tool schema to find the correct parameter name.

**Potential solution:** If possible, accept both `path` and `file_path` as aliases since many tools use `path` as the standard parameter name.

---

## [2026-02-25 20:33 PST] - No Other Issues

**What I was trying to do:** Complete the coding exercise

**What the issue was:** None - the exercise completed successfully on first validation

**Why it was an issue:** N/A

**Potential solution:** The documentation for `run.job` and `function` was clear and helpful. I was able to follow the patterns from the docs to create valid XanoScript on the first attempt.

