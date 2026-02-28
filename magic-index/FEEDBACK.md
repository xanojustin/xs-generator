# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 10:35 PST] - Parser Error on Blank Lines After Comments

**What I was trying to do:** Create a XanoScript function with comments at the top describing the problem.

**What the issue was:** The XanoScript parser fails when there are blank lines between comment blocks and the function definition (or run.job definition). 

For example, this code fails:
```xs
// Magic Index Finder
// A magic index is an index i such that arr[i] == i

function "magic_index" {
```

With error: `[Line 3, Column 1] Expecting --> function <-- but found --> ''`

**Why it was an issue:** This is unexpected behavior - most languages allow blank lines between comments and code. The error message is also unhelpful as it suggests the parser found an empty string instead of clearly stating that blank lines aren't allowed after comments.

**Potential solution:** 
1. Allow blank lines between comments and code (preferred - follows standard conventions)
2. Provide a clearer error message like "Blank lines not allowed between comments and function definition"

---

## [2025-02-28 10:38 PST] - Array Access Syntax Not Clearly Documented

**What I was trying to do:** Access array elements by index using `arr[i]` syntax.

**What the issue was:** While the syntax worked (after seeing it in other examples), the documentation for array access syntax isn't prominent in the `essentials` or `functions` docs.

**Why it was an issue:** Had to look at existing code examples to confirm the syntax was `$input.nums[$mid]` rather than some other form like `$input.nums.$mid` or a filter like `$input.nums|get:$mid`.

**Potential solution:** Add a section on array access in the `essentials` or `types` documentation.

---

## [2025-02-28 10:40 PST] - Object Literal Syntax Subtle Difference

**What I was trying to do:** Define the `main` input object in run.xs with comma-separated properties (like JavaScript).

**What the issue was:** XanoScript object literals in block contexts don't use commas between properties:
```xs
// Wrong:
main = {
  name: "magic_index",
  input: { ... }
}

// Correct:
main = {
  name: "magic_index"
  input: { ... }
}
```

**Why it was an issue:** This is different from most programming languages where commas are required in object literals. The docs mention this in the "Common Mistakes" section but it's easy to miss.

**Potential solution:** The docs do cover this, but maybe add it to the `run` topic documentation specifically since it's a common pattern there.

---

## General Feedback

The MCP validation tool is very helpful! The error messages with line/column numbers are accurate (once I understood the blank line issue). The suggestions are also helpful (like reminding about `int` vs `integer`).

One improvement would be to validate all files in a directory recursively by default when given a path, rather than requiring the `directory` parameter explicitly.
