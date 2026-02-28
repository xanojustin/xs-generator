# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 16:32 PST] - 2D Array Type Not Supported

**What I was trying to do:** Define a function that takes a 2D matrix (int[][]) as input.

**What the issue was:** XanoScript does not support multi-dimensional array type declarations like `int[][]`. The validation error was:
```
[Line 7, Column 10] Expecting token of type --> Identifier <-- but found --> '[' <--
```

**Why it was an issue:** This was confusing because:
1. The syntax `int[][]` is standard in many languages for 2D arrays
2. The error message didn't clearly explain that multi-dimensional arrays aren't supported as type declarations
3. I had to look at other existing implementations (like spiral_matrix) to discover the workaround

**Potential solution (if known):** 
- The MCP could provide a clearer error message like: "Multi-dimensional array types are not supported. Use `json` type for nested arrays and access elements with `$input.matrix[row][col]`"
- Or the documentation could have a note about this limitation in the types topic

---

## [2026-02-27 16:32 PST] - Inconsistent Array/Matrix Access Documentation

**What I was trying to do:** Understand how to properly handle matrix (2D array) inputs in XanoScript functions.

**What the issue was:** The xanoscript_docs for functions shows array patterns like `type[]` but doesn't mention that for multi-dimensional/nested arrays, you should use `json` type.

**Why it was an issue:** I assumed I could declare `int[][] matrix` since the docs show `type[]` syntax. The gap between "arrays are type[]" and "multi-dimensional arrays must use json" wasn't clear.

**Potential solution (if known):** 
- Add a specific section in the `types` or `functions` documentation about handling nested/multi-dimensional arrays
- Include an example of matrix/array-of-arrays handling

---

## [2026-02-27 16:32 PST] - Discovery of array.push and math.add Operations

**What I was trying to do:** Push elements to an array and perform arithmetic operations.

**What the issue was:** The xanoscript_docs essentials show variable updates like `var.update $counter { value = $counter + 1 }` but looking at spiral_matrix.xs I found `math.add` and `array.push` operations that seem cleaner.

**Why it was an issue:** There's inconsistency between what's documented (var.update with arithmetic) and what's used in existing code (math.add, array.push). It's unclear which is preferred or if both are equally valid.

**Potential solution (if known):**
- Document `math.add`, `math.sub`, `array.push`, and similar operations in the essentials or syntax docs
- Clarify if `var.update $x { value = $x + 1 }` and `math.add $x { value = 1 }` are equivalent or if one is preferred

---

## General Feedback

**What went well:**
- The MCP validation tool is very helpful with line/column error reporting
- The suggestions provided (like "Use type[] instead of array") are useful
- Looking at existing implementations in ~/xs/ was very helpful for learning patterns

**What was challenging:**
- The gap between documented syntax and real-world usage in examples
- Multi-dimensional array handling wasn't clearly documented
- Had to discover math.* and array.* operations by reading existing code rather than docs
