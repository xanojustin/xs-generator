# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-22 05:32 PST - File Path Expansion Issue

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** Used tilde (`~`) for home directory in file paths (e.g., `~/xs/distinct-subsequences/run.xs`), but the MCP tool reported "File not found"

**Why it was an issue:** Had to switch to absolute paths (`/Users/justinalbrecht/xs/...`) for validation to work

**Potential solution:** The MCP could expand `~` to the user's home directory before resolving file paths, making it more user-friendly

---

## 2025-02-22 05:35 PST - Documentation Request: Complex Algorithm Examples

**What I was trying to do:** Implement a dynamic programming solution (distinct subsequences) with nested loops and array manipulation

**What the issue was:** While the quick reference docs were helpful for basic syntax, it was unclear how to properly structure more complex algorithms. Specifically:
1. How to properly use `while` loops with index arithmetic
2. How to update array elements at specific indices using `set` filter
3. Whether `foreach` with index was supported (found it had syntax issues in other examples)

**Why it was an issue:** Had to infer patterns from existing exercise implementations rather than official docs

**Potential solution:** Add a section to the quickstart or syntax docs with common algorithmic patterns:
- Dynamic programming (1D and 2D arrays)
- Nested iteration patterns
- Array indexing and updates
- String to character array conversion for indexing

---

## 2025-02-22 05:38 PST - Success Note: First-Try Validation

**What I was trying to do:** Write valid XanoScript code on the first attempt

**What went well:** Both files validated successfully on the first try

**Why it worked:** 
1. The quick reference documentation covered the essentials (variable prefixes, filters with parentheses, type names)
2. Existing exercise implementations provided good patterns to follow
3. The error messages from the validator are clear when there are issues

**Positive feedback:** The `xanoscript_docs` tool with `mode=quick_reference` is excellent for context efficiency. The filter precedence warning about parentheses was especially helpful.

---
