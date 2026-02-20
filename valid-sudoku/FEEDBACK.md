# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 10:35 PST] - 2D Array Type Syntax Unclear

**What I was trying to do:** Define a function input parameter for a 9x9 Sudoku board (2D array of integers).

**What the issue was:** I initially wrote `int[][] board` thinking that was the correct syntax for a 2D integer array, but this caused a parse error: `Expecting token of type --> Identifier <-- but found --> '['`.

**Why it was an issue:** The types documentation shows `int[]` for 1D arrays but doesn't explicitly show how to define 2D arrays. I had to look at existing exercises (like `matrix-transpose`) to discover that `json` type should be used for 2D arrays.

**Potential solution:** The `types` documentation could include an example or note about multi-dimensional arrays, recommending `json` type for 2D+ arrays.

---

## [2025-02-20 10:37 PST] - Array Element Access Syntax

**What I was trying to do:** Access elements from the 2D array using standard bracket notation like `$board[row][col]`.

**What the issue was:** The syntax `$input.board[row][col]` doesn't work. I discovered through examining the `pascals-triangle` example that I need to use the `|get:"index"` filter with the index converted to text: `$board|get:(row|to_text)`.

**Why it was an issue:** This syntax is quite verbose and non-intuitive compared to standard array bracket access. It took examining existing working code to figure out the correct pattern.

**Potential solution:** 
1. Add explicit documentation about array access patterns in the syntax or quickstart guide
2. Consider supporting a more concise syntax like `$array[row]` for direct index access
3. Add a code example showing 2D array iteration to the quickstart documentation

---

## General Observation

The documentation structure is good with the quick_reference mode being very helpful for saving context. However, some common patterns (like working with 2D arrays or nested data structures) could benefit from explicit examples in the quickstart guide.
