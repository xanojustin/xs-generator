# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 04:05 PST] - 2D Array Type Syntax

**What I was trying to do:** Define a 2D integer array input for the grid in the rotting-oranges exercise

**What the issue was:** Used `int[][] grid` syntax which is common in many programming languages (TypeScript, Java, C++, etc.) but is not valid in XanoScript. The validation error was:
```
[Line 8, Column 10] Expecting token of type --> Identifier <-- but found --> '['
```

**Why it was an issue:** This is a common pattern in other languages, so it was my natural assumption. The error message was somewhat cryptic - it says it expected an identifier but found `[`. It took me looking at existing code (`number-of-islands`, `toeplitz-matrix` exercises) to realize that 2D arrays should use the `json` type.

**Potential solution (if known):** 
1. Better error message: Instead of "Expecting token of type Identifier", something like "Invalid type syntax. For multi-dimensional arrays, use 'json' type instead of 'int[][]'"
2. Documentation note: The types documentation mentions `int[]` for arrays but doesn't explicitly mention how to handle 2D/nested arrays
3. Perhaps support `int[]` as a shorthand for `json` when the content is known to be integer arrays, or at least mention in the `json` type description that it's used for nested arrays

---

## [2026-02-25 04:06 PST] - Finding Reference Implementations

**What I was trying to do:** Understand the correct XanoScript patterns for 2D arrays and array operations

**What the issue was:** Had to manually explore the `~/xs/` directory to find existing exercises that use similar patterns. There was no quick way to search or query for "exercises that use 2D arrays" or "exercises that use json type"

**Why it was an issue:** It slowed down development. I had to:
1. List all directories
2. Guess which ones might use 2D arrays
3. Check multiple files until I found `toeplitz-matrix` which uses `json matrix`

**Potential solution (if known):**
1. A documentation example showing common patterns like "How to work with 2D arrays/grids"
2. A searchable index or tagging system for the example exercises
3. A "similar exercises" reference in documentation that groups exercises by pattern (array manipulation, grid traversal, string operations, etc.)

---

## General Feedback

The Xano MCP validation tool worked well once I understood the patterns. The error reporting with line/column numbers is helpful. The main friction points were:

1. **Type system assumptions:** Coming from TypeScript/Java/C++ background, `int[][]` felt natural but isn't supported
2. **Discoverability of patterns:** Had to reverse-engineer patterns from existing files rather than having a reference guide
3. **Mixed patterns in codebase:** Some older exercises use `math.add`, `array.push` while newer ones use `var.update` with operators - this is confusing when trying to learn best practices

Overall, once the initial syntax hurdle was cleared, the implementation was straightforward. The BFS algorithm translated cleanly to XanoScript.
