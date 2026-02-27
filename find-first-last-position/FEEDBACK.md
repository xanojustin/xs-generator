# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 17:35 PST] - file_paths Parameter Parsing Issue

**What I was trying to do:** Validate multiple .xs files using the `file_paths` parameter with comma-separated paths

**What the issue was:** The `file_paths` parameter appears to be parsing the comma-separated string incorrectly. When I passed:
```
file_paths="/Users/justinalbrecht/xs/find-first-last-position/run.xs,/Users/justinalbrecht/xs/find-first-last-position/function/find_first_last_position.xs"
```

The tool treated each character after the comma as a separate file path, resulting in errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

It seems the tool is treating the entire string as an array of characters rather than an array of file paths.

**Why it was an issue:** This prevented batch validation of specific files. I had to work around it by using the `directory` parameter instead, which validated all files in the folder.

**Potential solution:** The MCP tool should properly parse comma-separated values in the `file_paths` parameter as an array of strings, not as individual characters. Alternatively, the tool could accept a JSON array format for better clarity.

---

## [2025-02-26 17:36 PST] - Documentation Request: Array Return Syntax

**What I was trying to do:** Return an array literal `[-1, -1]` from a function

**What the issue was:** I wasn't sure about the exact syntax for array literals in XanoScript, particularly:
1. Whether to use square brackets `[]` or another syntax
2. How to create an array with integer values

**Why it was an issue:** The quickstart documentation shows object literals `{key: value}` but doesn't explicitly show array literal syntax. I had to infer it from examples in other files.

**Potential solution:** Add a brief section on array literals to the quickstart documentation, showing:
- Empty array: `[]`
- Array with values: `[1, 2, 3]`
- Array with mixed types: `["text", 123, true]`

---

## [2025-02-26 17:37 PST] - Positive Feedback: Directory Validation Works Well

**What I was trying to do:** Validate all .xs files in my exercise folder

**What worked well:** The `directory` parameter worked perfectly for validating all files at once. It correctly found both the `run.xs` and `function/find_first_last_position.xs` files.

**Why this is good:** This is actually a better workflow than validating individual files - it validates the entire exercise in one call.

**Suggestion:** Consider updating the workflow instructions to recommend using `directory` validation instead of `file_paths` for exercise validation.

---
