# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 04:05 PST] - Array Index Assignment Filter Discovery

**What I was trying to do:** Implement the Sieve of Eratosthenes algorithm, which requires marking specific indices in a boolean array as true/false

**What the issue was:** I assumed the filter for setting an array index would be called `set_index` (following common naming conventions), but XanoScript uses simply `set`

**Why it was an issue:** This caused 3 validation errors on my first attempt:
```
1. [Line 23, Column 46] Unknown filter function 'set_index'
2. [Line 24, Column 46] Unknown filter function 'set_index'
3. [Line 37, Column 58] Unknown filter function 'set_index'
```

**Potential solution (if known):** 
- The `xanoscript_docs` could include a "Common Filter Names" section that explicitly lists array manipulation filters
- A cross-reference like "To set array values by index, use `set` (not `set_index`)" would help
- The bubble-sort example in the repo was helpful - I found the correct syntax by looking at existing code

---

## [2026-02-19 04:08 PST] - Validation Tool Path Handling

**What I was trying to do:** Validate a single file using the `validate_xanoscript` tool

**What the issue was:** The `file_paths` parameter seems to have parsing issues when given a full path - it was treating each character as a separate file path

**Why it was an issue:** Running:
```bash
mcporter call xano.validate_xanoscript file_paths="/Users/justinalbrecht/xs/sieve-of-eratosthenes/function.xs"
```
Resulted in 58 "files" being validated (each character became a file), all invalid

**Potential solution (if known):**
- The `directory` parameter worked perfectly for my use case
- Document that `file_paths` may have issues with full paths and suggest using `directory` for folders or relative paths
- Alternatively, the tool could be more robust about path parsing

---

## [2026-02-19 04:10 PST] - Success with Directory Parameter

**What I was trying to do:** Successfully validate the XanoScript code

**What the issue was:** None - once I switched to using the `directory` parameter, validation worked perfectly

**Why it was an issue:** N/A - success case

**Potential solution (if known):** The validation tool provides clear, actionable error messages with line numbers and column positions. Very helpful for debugging!
