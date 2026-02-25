# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 00:30 PST] - File Paths Array Parsing Issue

**What I was trying to do:** Validate multiple XanoScript files at once using the `file_paths` parameter with comma-separated values.

**What the issue was:** The MCP tool parsed the comma-separated string `/Users/justinalbrecht/xs/monotonic-array/run.xs,/Users/justinalbrecht/xs/monotonic-array/function/monotonic-array.xs` as individual characters instead of as two separate file paths. The tool returned errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

Each character of the path string was being treated as a separate file path entry.

**Why it was an issue:** This prevented batch validation of multiple files in a single call. I had to work around by calling the validation tool twice (once per file) instead of once with both files.

**Potential solution (if known):** 
- The MCP tool should properly parse the `file_paths` array parameter when passed from mcporter
- Alternatively, document the correct format for passing multiple file paths (perhaps as a JSON array string instead of comma-separated)
- Or provide an alternative parameter that accepts a directory path and validates all `.xs` files recursively within it

---

## [2025-02-25 00:32 PST] - Success with Single File Validation

**What I was trying to do:** Validate individual XanoScript files using the `file_path` parameter.

**What the issue was:** None - the single file validation worked perfectly on the first attempt.

**Why it was an issue:** N/A - no issues encountered.

**Feedback:** The validation tool provides clear output (`✓ filename.xs: Valid`) and the language server correctly auto-detected the object type from the code syntax.

---

## General Observations

### Positive
1. The `xanoscript_docs` tool with `mode=quick_reference` provided exactly the right amount of context for efficient code generation
2. The syntax documentation is clear about common pitfalls (like using `$input.field` vs bare variables)
3. The validation tool correctly identified both `run.job` and `function` object types without explicit hints

### Suggestions for Improvement
1. **Batch file_paths parameter:** Fix or document how to properly pass multiple file paths
2. **Error message formatting:** When validation fails, include the specific line numbers and column positions as mentioned in the tool description
3. **More examples in docs:** The quickstart docs are great, but additional examples for array iteration patterns would be helpful
