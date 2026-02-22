# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-22 03:35 PST - Validation Command Syntax

**What I was trying to do:** Validate XanoScript files using the MCP server

**What the issue was:** The initial attempt using `mcporter call xano.validate_xanoscript file-paths=...` failed with "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** The CLI-style argument passing didn't work as expected. The mcporter tool requires JSON-formatted arguments with `--args` flag.

**Potential solution:** The documentation or error message could clarify that `--args '{"file_paths": [...]}'` syntax is required when calling via mcporter CLI.

---

## 2026-02-22 03:36 PST - Successful First Validation

**What I was trying to do:** Implement the KMP string search algorithm in XanoScript

**What the issue was:** No issues encountered - the code passed validation on the first attempt.

**Why this is notable:** The XanoScript documentation was clear enough to write a complex algorithm (LPS array computation + pattern matching) correctly on the first try. The syntax patterns from `xanoscript_docs` were accurate.

**Positive feedback:** The `quickstart` and `functions` documentation topics provided sufficient examples to understand:
- Variable declaration with `var $name { value = ... }`
- Array manipulation with filters like `|push`, `|set`, `|get`
- Loop structures (`while`, `for`, `each`)
- String operations with `|substr`
- Conditional blocks

---