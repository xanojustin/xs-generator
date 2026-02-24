# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 20:10 PST] - Blank Lines Between Comments and Function Rejected

**What I was trying to do:** Create a well-documented function with detailed comments explaining the algorithm.

**What the issue was:** The XanoScript validator rejected files that had blank lines between the comment block and the function definition. The error message was:
```
Line 21, Column 1: Expecting --> function <-- but found --> '\n' <--
```

**Why it was an issue:** This is unusual behavior - most languages allow blank lines between comments and code. The error message was also confusing because it said it found a newline character when it expected 'function', but the function WAS on the next line - just with a blank line before it.

**Potential solution (if known):** 
- Either allow blank lines between comments and function definitions (more intuitive)
- Or provide a clearer error message like "Blank lines not allowed between comments and function definition"

---

## [2025-02-23 20:15 PST] - |length Filter Not Available

**What I was trying to do:** Get the length of an array using the common `|length` filter pattern.

**What the issue was:** The validator reported "Unknown filter function 'length'" when using `$input.nums|length`.

**Why it was an issue:** `length` is the standard name for this operation in most languages (JavaScript, Python, etc.). I had to discover through trial and error that XanoScript uses `|count` instead.

**Potential solution (if known):**
- Add `|length` as an alias for `|count` for better developer experience
- Or include this in the error message suggestion (currently suggests "int" vs "integer" which wasn't relevant)

---

## [2025-02-23 20:20 PST] - Validation Parameter Format Inconsistency

**What I was trying to do:** Validate multiple files using the `validate_xanoscript` MCP tool.

**What the issue was:** Initially tried various parameter formats:
- `files` array - not recognized
- `file_paths` array - not recognized  
- `directory` - worked but only after trying other formats

**Why it was an issue:** The error message said "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" but `file_paths` (plural) wasn't actually working. Had to use `directory` parameter.

**Potential solution (if known):**
- Ensure all documented parameters actually work
- Or update the error message to only list working parameters

---

## [2025-02-23 20:25 PST] - Limited Documentation from xanoscript_docs

**What I was trying to do:** Learn the correct XanoScript syntax for run.job and function constructs.

**What the issue was:** The `xanoscript_docs` MCP tool returned generic high-level documentation that didn't include specific syntax patterns for:
- How to write a `run.job` that calls a function
- Available filters (like `|count` vs `|length`)
- Proper function structure

**Why it was an issue:** Had to discover correct patterns by reading existing example files rather than documentation. The docs mentioned topics like "run" and "functions" but when queried, returned the same generic structure info.

**Potential solution (if known):**
- Include concrete syntax examples for each construct type
- Provide a filter reference list
- Document the run.job -> function.call pattern explicitly
