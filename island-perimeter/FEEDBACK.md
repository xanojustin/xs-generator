# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-23 02:33 PST - Issue: 2D Array Type Syntax Not Supported

**What I was trying to do:** Define a 2D array input for a grid (array of arrays of integers)

**What the issue was:** Used `int[][] grid` which caused parse error: "Expecting token of type --> Identifier <-- but found --> '['"

**Why it was an issue:** The documentation mentions array types like `text[]` and `int[1:10]` but doesn't clearly indicate that multi-dimensional arrays (2D+) are not supported directly. I assumed `int[][]` would work like other languages.

**Potential solution (if known):** 
- Document that multi-dimensional arrays should use `json` type instead
- Or add explicit support for 2D array syntax like `int[][]`

**Workaround used:** Changed to `json grid` which accepts any JSON structure including arrays of arrays.

---

## 2026-02-23 02:35 PST - Issue: Array Literal Spacing Requirements

**What I was trying to do:** Define a nested array literal in run.job input: `[[1]]`

**What the issue was:** The parser rejected `[[1]]` with error "Expecting: Expected an object {} but found: '{'"

**Why it was an issue:** The error message was confusing - it made me think the issue was with the `input:` line itself, not the array literal format. It took trial and error to discover that spaces are required between nested brackets.

**Potential solution (if known):**
- Document that array literals need spaces: `[ [ 1 ] ]` not `[[1]]`
- Or improve parser to accept compact array syntax `[[1]]`
- Or provide clearer error messages that indicate the actual issue

**Workaround used:** Changed to `[ [ 1 ] ]` with spaces between brackets.

---

## 2026-02-23 02:36 PST - Positive Feedback: MCP Validation Tool

**What worked well:** The `validate_xanoscript` tool was helpful and provided clear line/column numbers for errors.

**Suggestion:** The error messages could be more specific about what syntax is expected (e.g., "Use 'json' type for 2D arrays" or "Array literals require spaces between brackets").

---
