# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 07:05 PST] - File Paths Parameter Parsing Issue

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated paths.

**What the issue was:** The MCP tool parsed the `file_paths` parameter incorrectly, treating each character as a separate file path. I passed `"~/xs/lucky-numbers-matrix/run.xs,~/xs/lucky-numbers-matrix/function/lucky_numbers.xs"` and it tried to validate individual characters like `~`, `/`, `x`, `s`, etc. as separate files.

**Why it was an issue:** This made batch validation via `file_paths` unusable. The error output showed 84 "files" being validated (each character of the two paths), all failing with "File not found".

**Potential solution:** The MCP tool should properly parse comma-separated arrays in the `file_paths` parameter, or the documentation should clarify the expected format (e.g., JSON array vs comma-separated string).

**Workaround used:** I successfully used the `directory` parameter instead to validate all `.xs` files in the exercise folder.

---

## [2026-02-24 07:05 PST] - Overall Experience

**What went well:**
- The `directory` validation parameter worked perfectly
- The `xanoscript_docs` topic system provided excellent, detailed documentation
- Both `run.job` and `function` constructs were well-documented with clear examples
- Code validated successfully on first attempt

**General feedback:**
- The XanoScript documentation is comprehensive and well-organized by topic
- The validation tool provides clear pass/fail status
- The `functions` and `run` topic documentation had exactly what I needed to complete this exercise
