# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 11:05 PST] - 2D Array Type Not Supported

**What I was trying to do:** Define a function input that accepts a 2D matrix (array of arrays of integers)

**What the issue was:** Used `int[][] matrix` syntax which resulted in a parse error: "Expecting token of type --> Identifier <-- but found --> '[' <--"

**Why it was an issue:** Common programming languages support nested array types like `int[][]`, but XanoScript doesn't appear to support this syntax directly. I had to use `json` type instead which loses type specificity.

**Potential solution (if known):** 
- Consider supporting `int[]` for 1D arrays and documenting how to handle multi-dimensional arrays
- Or provide a matrix/grid specific type for common use cases
- The error message suggestion "Use type[] instead of array" doesn't help when you're already trying to use `[]` notation

---

## [2025-03-01 11:08 PST] - File Path Resolution with ~

**What I was trying to do:** Validate files using `~/xs/...` paths

**What the issue was:** The MCP validator returned "File not found" when using tilde (~) paths. Had to use absolute paths `/Users/justinalbrecht/xs/...` instead.

**Why it was an issue:** Shell conventions suggest ~ should expand to home directory. Had to manually convert paths.

**Potential solution (if known):** The validator could expand `~` to the user's home directory before checking file existence.

---

## [2025-03-01 11:10 PST] - Positive Experience with Error Suggestions

**What I was trying to do:** Fix the type syntax error

**What went well:** The validation error included helpful suggestions like "Use 'type[]' instead of 'array'" and "Use 'int' instead of 'integer' for type declaration" which guided me toward the correct syntax.

**Why this was helpful:** Even though the specific suggestion for 2D arrays didn't directly solve my problem, the hint about using `type[]` format was useful context.

---
