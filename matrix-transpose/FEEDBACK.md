# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 07:35 PST] - 2D Array Type Declaration

**What I was trying to do:** Create a function that accepts a 2D matrix (array of arrays) as input

**What the issue was:** I initially declared the input type as `int[][] matrix` thinking this would represent a 2D integer array, but XanoScript rejected this syntax with error: "Expecting token of type --> Identifier <-- but found --> '[' <--"

**Why it was an issue:** The documentation mentions `text[]` for arrays but doesn't clearly explain how to declare multi-dimensional arrays. I had to guess and was wrong.

**Potential solution (if known):** The types documentation could include an explicit example of how to handle nested arrays or matrices. Something like:
```
For multi-dimensional arrays or matrices, use the `json` type:
  json matrix  // Accepts [[1,2], [3,4]]
```

---

## [2026-02-19 07:36 PST] - Directory Path Expansion in MCP

**What I was trying to do:** Validate XanoScript files using the validate_xanoscript tool with directory parameter

**What the issue was:** When I used `directory: "~/xs/matrix-transpose"`, the MCP returned "No .xs files found in directory". I had to use the full absolute path `/Users/justinalbrecht/xs/matrix-transpose` for it to work.

**Why it was an issue:** Most CLI tools and scripts expand `~` to the home directory automatically. The MCP doesn't, which is unexpected behavior.

**Potential solution (if known):** The MCP could expand `~` to the user's home directory before processing the path, or the error message could suggest using an absolute path.

---

## [2026-02-19 07:37 PST] - Limited Array Manipulation Documentation

**What I was trying to do:** Implement matrix transpose logic using while loops and array indexing

**What the issue was:** While the documentation covers basic array filters like `count`, `first`, `last`, and concatenation with `~`, it's not clear how to:
1. Access array elements by index (e.g., `array[index]`)
2. Create nested arrays programmatically
3. The proper way to build up arrays in a loop

**Why it was an issue:** I had to infer the syntax from examples and hope it worked. The `array[index]` syntax worked, but I wasn't sure if it was correct until validation passed.

**Potential solution (if known):** The syntax documentation could include a section on array indexing and construction, with examples like:
```xs
// Access by index
var $item { value = $array[0] }

// Build array incrementally
var $arr { value = [] }
var $arr { value = $arr ~ [new_item] }

// Nested access
var $inner { value = $matrix[row][col] }
```

---
