# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 12:05 PST] - 2D Array Type Syntax Confusion

**What I was trying to do:** Define a function input parameter for a 2D integer array (a dungeon grid).

**What the issue was:** I initially tried `int[][] dungeon` which seemed intuitive for a 2D integer array, but this syntax is not valid in XanoScript. The validation error was:
```
[Line 10, Column 10] Expecting token of type --> Identifier <-- but found --> '['
```

**Why it was an issue:** The error message doesn't clearly indicate that 2D array types aren't supported or what the correct alternative is. I had to search through existing code examples to discover that 2D arrays should be typed as `json`.

**Potential solution:** 
- The documentation could explicitly state that multi-dimensional arrays use `json` type
- The validation error could suggest using `json` for multi-dimensional arrays
- A dedicated section on "Array Types" in the types documentation would help

---

## [2025-02-25 12:08 PST] - 2D Array Element Update Syntax

**What I was trying to do:** Update a specific element in a 2D array using `var $dp { value[$i][$j] = $needed }`.

**What the issue was:** This syntax is invalid. XanoScript doesn't support indexed assignment in variable declarations. The error was a cryptic parser error about expecting various token sequences.

**Why it was an issue:** Coming from other languages, indexed assignment like `array[i][j] = value` is standard. The XanoScript approach requires building arrays differently - either using `array.push` or creating new arrays with `merge`. This paradigm shift isn't clearly documented.

**Potential solution:**
- Add a "Working with Arrays" section in the quickstart documentation
- Provide examples of building 2D arrays row-by-row
- Explain the immutable-style approach to array manipulation in XanoScript
- The `array.push` documentation should show examples with 2D arrays

---

## [2025-02-25 12:10 PST] - MCporter Parameter Passing Issues

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with the Xano MCP.

**What the issue was:** The `mcporter call` command had issues with parameter parsing:
- Using `--file_paths` with comma-separated values caused the string to be split character by character
- Using JSON format `'{"file_paths": [...]}'` resulted in "parameter required" errors
- The working syntax was `file_path=/path` (single file) but array parameters were problematic

**Why it was an issue:** I had to validate files one at a time instead of batch validation, which is slower and more tedious.

**Potential solution:**
- Document the exact syntax for array parameters in mcporter
- Provide examples of batch file validation
- Consider supporting a simpler comma-separated format that actually works

---

## [2025-02-25 12:12 PST] - Finding Reference Examples

**What I was trying to do:** Find existing implementations of similar problems (2D array DP problems) to learn the correct patterns.

**What the issue was:** The xs/ directory has many examples but finding the right one required browsing through many folders. I had to try multiple files before finding `set_matrix_zeroes` and `minimum_path_sum` which showed the correct patterns.

**Why it was an issue:** There isn't a categorized index or "examples by pattern" guide that would help developers quickly find reference implementations for specific patterns like:
- 2D array manipulation
- Dynamic programming
- String processing
- Tree traversal

**Potential solution:**
- Create an INDEX.md in the xs/ folder categorizing exercises by pattern/technique
- Tag exercises with concepts they demonstrate
- Or at least group them in subdirectories by category (arrays, strings, dp, trees, etc.)
