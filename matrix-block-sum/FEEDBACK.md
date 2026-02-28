# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 07:35 PST] - 2D Array Type Not Supported

**What I was trying to do:** Create a function that accepts a 2D matrix as input for the matrix-block-sum problem.

**What the issue was:** I initially used `int[][] matrix` as the type declaration for a 2D array, but this syntax is not valid in XanoScript. The parser threw: `[Line 8, Column 10] Expecting token of type --> Identifier <-- but found --> '[' <--`

**Why it was an issue:** Most programming languages support multi-dimensional array syntax like `int[][]` or `int[,]`. Without this, I had to use the generic `json` type, which loses type safety and documentation clarity for 2D matrix inputs.

**Potential solution:** Consider supporting:
1. `int[]` for 1D arrays (already supported)
2. `int[][]` or `json<int[]>` for 2D arrays to maintain type information
3. Better documentation in the "types" topic about handling multi-dimensional data structures

---

## [2025-02-28 07:36 PST] - Array Indexing and Update Complexity

**What I was trying to do:** Update a value at a specific 2D index in the prefix sum array during computation.

**What the issue was:** XanoScript doesn't support direct 2D array indexing with assignment like `prefix[i][j] = value`. I had to work around this by:
1. Getting the row with `prefix|get:i`
2. Creating a new row by slicing and merging arrays
3. Reconstructing the entire prefix array

This made the code significantly more verbose and harder to read than necessary.

**Why it was an issue:** Building 2D prefix sums requires frequent updates to specific indices. The workaround (slice/merge/splice pattern) is error-prone and computationally inefficient.

**Potential solution:** 
1. Support `var.update $arr[i][j] { value = new_val }` for nested array updates
2. Or provide a `set` filter for arrays similar to objects: `$arr|set:i:$new_val`
3. Consider adding a dedicated 2D array/table type with efficient cell update operations

---

## [2025-02-28 07:37 PST] - Variable Shadowing Allowed But Confusing

**What I was trying to do:** Reuse variable names within nested scopes (e.g., `$row`, `$i` in multiple for loops).

**What the issue was:** XanoScript allows declaring new variables with the same name as existing variables in outer scopes. While this works, it can lead to confusion about which variable is being referenced.

**Why it was an issue:** In my prefix sum building loop, I had to be very careful about variable naming to avoid accidentally referencing the wrong `$row` variable from an outer scope.

**Potential solution:** This is more of a style/documentation issue. The current behavior is fine, but perhaps add a linting suggestion or documentation note about best practices for variable naming in nested loops.

---

## [2025-02-28 07:38 PST] - No Issues with MCP Server

**What I was trying to do:** Validate XanoScript files and get documentation.

**What the issue was:** The MCP server worked flawlessly. The `validate_xanoscript` tool provided clear error messages with line/column positions, and the `xanoscript_docs` tool returned well-organized documentation.

**Why it was NOT an issue:** The validation was fast, the error messages were helpful with the actual code snippet, and the suggestions were accurate.

**Potential solution:** None needed - the MCP tooling worked great!

---
