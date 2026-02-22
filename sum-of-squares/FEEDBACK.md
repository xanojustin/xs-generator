# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 13:05 PST] - MCP Parameter Naming Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The MCP tool expects snake_case parameters (`file_path`, `file_paths`) but the mcporter CLI appears to convert them incorrectly. When using `file-path=/path/to/file.xs` format, the MCP returned an error saying required parameters were missing.

**Why it was an issue:** This blocked validation until I figured out the correct format. The error message was misleading because I was providing the parameter but it wasn't being passed through correctly.

**Potential solution (if known):** The mcporter CLI should either:
1. Convert kebab-case to snake_case automatically when calling MCP tools
2. Or the error message should indicate what parameters were actually received vs expected

**Workaround discovered:** Using `--args '{"file_path": "/path/to/file.xs"}'` with JSON format worked correctly.

---

## [2026-02-22 13:06 PST] - Documentation Discovery

**What I was trying to do:** Understand the XanoScript syntax for the `return` statement for early exit

**What the issue was:** The quickstart documentation mentions early return with `return { value = ... }` syntax, but it wasn't immediately clear if this works within conditional blocks or only at the stack level.

**Why it was an issue:** I wanted to implement a guard clause for the edge case where n=0, but wasn't sure if the return syntax would work inside a `conditional { if (...) { ... } }` block.

**Potential solution (if known):** The documentation could include a specific example of early return inside conditional blocks. However, experimentation showed it works correctly.

---
