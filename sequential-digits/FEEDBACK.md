# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 20:05 PST] - MCP Parameter Passing Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The mcporter tool expects parameters in `key:value` format (colon separator), but I was initially trying to use JSON format (`{"key": "value"}`) and `--key=value` format. Both failed with the error "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** This caused confusion and required trial-and-error to find the correct syntax. The error message suggests any of those parameters would work, but the actual required format isn't clearly documented in the error.

**Potential solution (if known):** 
1. Update the error message to suggest the correct format: "Use `file_path:/path/to/file.xs` syntax"
2. Accept standard JSON format for parameters as an alternative
3. Add examples to the `--help` output showing the correct `key:value` syntax

---

## [2026-03-03 20:08 PST] - All Files Passed First Try

**What I was trying to do:** Implement a complete XanoScript coding exercise with run.job and function

**What happened:** Both files passed validation on the first attempt without any errors

**Why this matters:** The existing examples (fizzbuzz, two-sum) and documentation provided enough context to write correct XanoScript syntax the first time. The documentation at `xanoscript_docs({ topic: "essentials" })` and existing exercises were sufficient references.

**No issues to report** - this exercise was successfully implemented without MCP or XanoScript problems.
