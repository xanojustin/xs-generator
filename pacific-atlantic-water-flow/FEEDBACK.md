# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-28 00:05 PST - 2D Array Type Syntax Unclear

**What I was trying to do:** Define a function input parameter for a 2D integer matrix (array of arrays) for the Pacific Atlantic Water Flow problem.

**What the issue was:** I initially tried `int[][] heights` which is standard syntax in many languages (Java, TypeScript, C++), but XanoScript parser rejected it with error: "Expecting token of type --> Identifier <-- but found --> '['"

**Why it was an issue:** The documentation doesn't explicitly mention that nested array types like `int[][]` are not supported. I had to guess that `json` type would work for arbitrary nested arrays.

**Potential solution (if known):** 
- Add explicit documentation about multi-dimensional arrays
- Either support `int[][]` syntax OR clearly document that `json` should be used for nested arrays
- Include an example in the types documentation showing how to handle matrix/2D array inputs

---

## 2025-02-28 00:06 PST - Early Return Pattern Confusion

**What I was trying to do:** Return early from a function when handling an edge case (empty matrix input).

**What the issue was:** I initially wrote `response = []` inside a conditional block thinking that would return early, but XanoScript requires the `return { value = ... }` syntax for early returns.

**Why it was an issue:** The `response =` assignment only works at the top level of the function, not inside conditionals. The documentation mentions early return but doesn't clearly contrast it with the response assignment pattern.

**Potential solution (if known):**
- Add a clear example in the essentials documentation showing both patterns side by side:
  - `response = $var` - for end-of-function return
  - `return { value = ... }` - for early return from within conditionals
- Include a "Common mistakes" entry about using `response =` inside conditionals

---

## 2025-02-28 00:03 PST - MCP Tool Parameter Format Issues

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths.

**What the issue was:** The MCP tool expects a JSON array format for `file_paths`, but the mcporter CLI syntax wasn't immediately obvious. I tried several formats:
- `file_paths='["/path/1", "/path/2"]'` - didn't work
- `file_paths="/path/1,/path/2"` - didn't work (expects array, got string)
- Eventually had to use `--args '{"file_paths":[...]}'` syntax

**Why it was an issue:** The error message "Invalid arguments: file_paths: Invalid input: expected array, received string" was helpful, but it took trial and error to find the correct mcporter CLI syntax.

**Potential solution (if known):**
- Add an example to the MCP documentation showing how to pass arrays via mcporter CLI
- Consider supporting comma-separated strings as a convenience fallback for array parameters

---
