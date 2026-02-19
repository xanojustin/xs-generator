# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 15:35 PST] - MCP file_paths parameter parsing issue

**What I was trying to do:** Validate multiple .xs files by passing comma-separated file paths to the `validate_xanoscript` tool.

**What the issue was:** When using `file_paths` parameter with comma-separated values like `/path/to/file1.xs,/path/to/file2.xs`, the MCP server split the string on commas but interpreted each character as a separate file path. The output showed "File not found: U", "File not found: s", "File not found: e", etc. (each character of the path was being treated as a separate file).

**Why it was an issue:** This prevented batch validation of specific files using the `file_paths` parameter. I had to switch to using the `directory` parameter instead to validate all files in a folder.

**Potential solution:** The MCP server should properly parse comma-separated file paths, or the documentation should clarify that `file_paths` expects an array format (e.g., JSON array) rather than a comma-separated string. Alternatively, if using CLI-style parsing, ensure the entire value is preserved before splitting.

---

## [2025-02-19 15:38 PST] - Confusion about loop constructs in XanoScript

**What I was trying to do:** Implement a Roman numeral conversion algorithm that requires a while-loop pattern (repeatedly subtracting values until the remaining number is less than the current mapping value).

**What the issue was:** I initially tried to use `conditional { while (...) { ... } }` based on general programming intuition, but XanoScript's `conditional` block only supports `if`/`elseif`/`else`, not `while` loops. The documentation mentions `foreach` for iteration but doesn't clearly indicate that `while` loops don't exist as a language construct.

**Why it was an issue:** I had to restructure my algorithm significantly. Instead of the natural while-loop approach (which is the standard solution for Roman numeral conversion), I had to use division to calculate repetitions and then use `range` + `foreach` to iterate that many times. This made the code more complex than necessary.

**Potential solution:** 
1. Add explicit documentation about what loop constructs ARE available (only `foreach`?)
2. Consider adding `while` loop support to `conditional` blocks or as a separate construct
3. Add a "control flow" or "loops" topic to the documentation that clearly explains iteration patterns
4. Provide examples of how to simulate while-loops using existing constructs

---
