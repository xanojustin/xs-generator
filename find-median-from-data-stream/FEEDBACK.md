# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 19:08 PST] - Missing array manipulation filters

**What I was trying to do:** Implement a bubble sort algorithm to sort an array for the "Find Median from Data Stream" exercise

**What the issue was:** I attempted to use an `array_replace` filter to swap elements in an array during sorting (a common pattern in other languages), but XanoScript doesn't have this filter.

**Error messages:**
1. `[Line 27, Column 35] Unknown filter function 'array_replace'`
2. `[Line 27, Column 52] Expecting --> } <-- but found --> '$sorted' <--`

**Why it was an issue:** Without an array_replace or similar filter, modifying a single element in an array requires rebuilding the entire array from scratch. This makes even simple operations like swapping two elements verbose and computationally expensive.

**Potential solution:**
- Add `array_replace` filter: `$arr|array_replace:index,new_value`
- Add `array_swap` filter: `$arr|array_swap:index1,index2`
- Add `array_insert` and `array_remove` filters for common array operations

---

## [2026-02-22 19:10 PST] - Documentation for available filters is limited

**What I was trying to do:** Find a list of all available filters to understand what array operations are possible

**What the issue was:** The quick_reference mode of `xanoscript_docs` only shows a subset of common filters. It took multiple attempts to discover that `array_replace` doesn't exist.

**Why it was an issue:** Trial-and-error is inefficient. I had to write code, validate it, get an error, and then rewrite it.

**Potential solution:**
- Provide a complete filter reference in the documentation
- Include a "Filters by Category" section (String, Array, Object, Math, etc.)

---

## [2026-02-22 19:12 PST] - MCP validate_xanoscript parameter format was unclear

**What I was trying to do:** Validate multiple XanoScript files using the MCP tool

**What the issue was:** Initially tried to pass JSON parameters, but the MCP tool expects `key=value` format.

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was confusing because I was technically providing those parameters, just in the wrong format.

**Potential solution:**
- Improve error message to suggest the correct format
- Document that parameters should be in `key=value` format, not JSON

---
