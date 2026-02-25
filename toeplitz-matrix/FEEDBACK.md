# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 21:05 PST] - 2D Array Type Syntax Confusion

**What I was trying to do:** Define a function input parameter for a 2D matrix (array of arrays of integers)

**What the issue was:** I initially wrote `int[][] matrix` thinking that was the correct syntax for a 2D integer array, similar to many other programming languages. The validation failed with: "Expecting token of type --> Identifier <-- but found --> '['"

**Why it was an issue:** The error message was helpful in pointing out the location, but the suggestion mentioned using "type[]" which confused me since I was already trying to use array syntax. I had to look at existing matrix exercises (like `spiral-matrix`) to discover that matrices should be typed as `json` rather than using array type modifiers.

**Potential solution (if known):** 
- The cheatsheet or types documentation could include an example of how to type matrix/2D array inputs
- The error suggestion could be more specific: "For multi-dimensional arrays, use `json` type instead of `int[][]`"
- A specific note in the types documentation: "For 2D matrices, use `json` type and validate structure in the stack"

---

## [2026-02-24 21:08 PST] - Validating Multiple Files at Once Works Well

**What I was trying to do:** Validate both the run.xs and function/is_toeplitz.xs files together

**What the issue was:** None - this worked perfectly using the `file_paths` array parameter

**Why it was an issue:** N/A - positive feedback

**Potential solution (if known):** The batch validation feature is great! Consider documenting this more prominently as the preferred way to validate a complete exercise.

---
