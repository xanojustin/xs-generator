# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 21:00 PST] - Issue: No 2D Array Type

**What I was trying to do:** Define a function input parameter for a matrix (2D array of integers)

**What the issue was:** Used `int[][] matrix` syntax which resulted in parse error: `Expecting token of type --> Identifier <-- but found --> '['`

**Why it was an issue:** I expected nested array types to work like in TypeScript or Java, but XanoScript doesn't support `int[][]` syntax for 2D arrays.

**Potential solution (if known):** Use `json` type for arbitrary nested arrays. Better documentation or examples for handling matrix/grid data structures would help.

---

## [2026-02-26 21:02 PST] - Issue: set_at_path Filter Doesn't Exist

**What I was trying to do:** Update a value in a nested 2D array (memoization table) at position [row][col]

**What the issue was:** Used `$memo|set_at_path:[$nr, $nc]:($curr_len + 1)` filter which doesn't exist in XanoScript

**Why it was an issue:** The docs don't clearly show how to update nested array values. The `set` filter only works for object keys, not array indices.

**Potential solution (if known):** Had to manually rebuild the entire 2D array structure by:
1. Getting the target row
2. Rebuilding that row with the updated value at the specific index
3. Rebuilding the entire memo array with the updated row

This is very verbose and inefficient. A `set_at` filter for arrays or a `set_at_path` filter for nested structures would be extremely useful.

**Example of what would help:**
```xs
// Instead of 20+ lines of code:
var.update $memo { value = $memo|set_at_path:[$row, $col]:$new_value }

// Or at minimum for 1D arrays:
var.update $arr { value = $arr|set_at:$index:$new_value }
```

---

## [2026-02-26 21:05 PST] - Issue: No Clear Way to Update Array Elements

**What I was trying to do:** Update a specific index in an array without rebuilding the entire array

**What the issue was:** XanoScript doesn't seem to have a direct way to update array elements by index. The `var.update` only works on variables, not on array elements.

**Why it was an issue:** For memoization problems (like this one), you need to frequently update cached values. Having to rebuild entire arrays each time is:
1. Very verbose (30+ lines of code for a simple update)
2. Potentially inefficient
3. Error-prone

**Potential solution (if known):** 
- Add array mutation filters like `set_at`, `update_at`
- Or provide clear documentation on the recommended pattern for this common use case

---

## General Feedback on Xano MCP

The MCP validation tool is helpful and gives clear error messages with line numbers. The main struggles were around:

1. **Missing documentation for complex data structures** - How to work with matrices, graphs, trees in XanoScript
2. **Limited array manipulation** - No built-in way to update array elements by index
3. **Filter discovery** - Hard to know which filters exist without reading all the docs

The documentation at `xanoscript_docs` is comprehensive but could benefit from:
- More examples for algorithmic problems (DP, graph traversal, etc.)
- A "common patterns" section for data structure manipulation
- A clear list of available filters with examples
