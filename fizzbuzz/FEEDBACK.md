# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 11:05 PST] - Validation Experience

**What I was trying to do:** Validate the FizzBuzz exercise files using the Xano MCP

**What the issue was:** Initially had trouble with the CLI syntax for the `validate_xanoscript` tool. The parameter names in the schema (`file_paths`) didn't match the CLI option names (`file-paths`), which caused confusion.

**Why it was an issue:** Had to check the tool schema to understand the correct CLI syntax. The error message wasn't clear about the correct parameter format.

**Potential solution (if known):** Consider adding example commands in the tool description or error messages that show the correct CLI syntax.

---

## [2026-02-19 11:00 PST] - Documentation Clarity

**What I was trying to do:** Create a FizzBuzz exercise following the established pattern

**What the issue was:** None - the documentation (`xanoscript_docs` topics: functions, quickstart, run) was clear and comprehensive.

**Why it was an issue:** N/A

**Potential solution (if known):** N/A - The documentation worked well. The examples for run.job structure and function syntax were particularly helpful.

---

## Overall Experience

The FizzBuzz exercise was completed successfully with:
- ✅ Clean run.job structure following the established pattern
- ✅ Function with proper input/output handling
- ✅ First-validation pass (no syntax errors)
- ✅ Complete documentation (README, CHANGES, FEEDBACK)

The Xano MCP validation tool worked well once the correct syntax was understood.

