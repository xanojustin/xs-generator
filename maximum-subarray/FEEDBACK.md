# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 04:35 PST] - File path expansion with tilde (~)

**What I was trying to do:** Validate XanoScript files using the MCP's `validate_xanoscript` tool

**What the issue was:** Passed file paths using tilde (`~/xs/...`) which the MCP couldn't resolve

**Why it was an issue:** Got "File not found" errors for both files even though they existed

**Potential solution (if known):** The MCP should either:
1. Expand tilde (~) to the user's home directory automatically, or
2. Document that full absolute paths are required

Workaround: Use `/Users/justinalbrecht/xs/...` instead of `~/xs/...`

---

## [2026-02-20 04:36 PST] - Filter expression parentheses requirement

**What I was trying to do:** Check if an array is empty using the `count` filter in a conditional

**Code that failed:**
```xs
if ($input.nums|count == 0) {
```

**What the issue was:** XanoScript requires parentheses around filter expressions when combining with comparison operators

**Error message:**
```
[Line 13, Column 32] An expression should be wrapped in parentheses when combining filters and tests
```

**Why it was an issue:** This syntax rule isn't immediately obvious from the quick reference documentation. The error message mentions "parentheses" but it's not clear if that means around the filter, around the whole expression, or using backticks.

**What worked:**
```xs
if (($input.nums|count) == 0) {
```

**Potential solution (if known):** 
1. Add a specific example of this pattern to the quickstart documentation
2. Consider making the error message more specific: "Wrap the filter in parentheses: `($input.nums|count)`"

---

## [2026-02-20 04:37 PST] - MCP experience was smooth overall

**Positive feedback:**
- The `validate_xanoscript` tool is fast and provides helpful error messages with line/column numbers
- The quick reference documentation was sufficient for basic syntax
- Having both `file_path` and `file_paths` options is convenient

**No major issues encountered beyond the two documented above.**
