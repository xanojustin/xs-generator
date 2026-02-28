# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 08:35 PST] - strpos filter doesn't exist

**What I was trying to do:** Find the position of the first occurrence of "6" in a string to implement the Maximum 69 Number algorithm.

**What the issue was:** I assumed XanoScript would have a `strpos` or similar filter to find the position of a substring within a string (common in many languages like PHP, C, etc.). The validator returned: `Unknown filter function 'strpos'`.

**Why it was an issue:** I had to completely rewrite my algorithm to use a character-by-character iteration approach instead of finding the position directly and using substring operations.

**Potential solution (if known):** 
- Add a `strpos` or `index_of` filter to find the position of a substring
- Or add documentation clarifying that substring operations require iteration

---

## [2025-02-28 08:30 PST] - Initial validation parameter confusion

**What I was trying to do:** Validate my XanoScript files using the MCP `validate_xanoscript` tool.

**What the issue was:** I initially tried passing `files` as a JSON array parameter, but the tool expects `file_paths` (plural with underscore) as a comma-separated list or `directory` as a string path.

**Why it was an issue:** The error message wasn't clear about the exact parameter name expected. I had to check the schema to find the correct parameter names (`file_paths` vs `files`, `directory` vs `dir`).

**Potential solution (if known):** 
- Add more examples in the tool description showing exact parameter usage
- Accept both `files` and `file_paths` as aliases for better developer experience

---

## General Observations

**Positive:**
- The validation tool provides helpful line/column error positions
- The suggestion system is useful (e.g., reminding about `int` vs `integer`)
- The `xanoscript_docs` tool is comprehensive

**Documentation Gaps:**
- String manipulation could use more examples for common patterns like "find and replace first occurrence"
- It would be helpful to have a quick reference card for filters organized by use case
