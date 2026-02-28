# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 13:10 PST] - 2D Array Type Syntax Not Intuitive

**What I was trying to do:** Define a 2D integer array (matrix) input for the "number of provinces" graph problem

**What the issue was:** I tried to use `int[][] isConnected` following common programming language conventions, but this is not valid XanoScript syntax

**Why it was an issue:** The validation error message was cryptic: "Expecting token of type --> Identifier <-- but found --> '[' <--". It didn't clearly indicate that nested array types like `int[][]` aren't supported, nor did it suggest using `json` as the alternative.

**Potential solution (if known):** 
- The documentation could explicitly state that nested array types (e.g., `int[][]`, `text[][]`) are not supported
- Suggest using `json` type for multi-dimensional arrays
- Better error message: "Multi-dimensional array types are not supported. Use 'json' type for 2D arrays and matrices."

---

## [2026-02-28 13:12 PST] - Comments Inside Object Literals Cause Parse Errors

**What I was trying to do:** Add descriptive comments inside the `input` object in run.xs to explain the test case

**What the issue was:** Comments placed inside object literals (between properties) caused a parse error: "Expected an object {} but found: '{'"

**Why it was an issue:** This was confusing because the syntax looked correct. The error message pointed to the `{` after `main = {` which was misleading - the actual issue was the comments inside the nested `input` object.

**Potential solution (if known):**
- If comments inside objects aren't supported, document this restriction clearly
- Provide a better error message that identifies the comment as the issue, not the object brace
- Consider supporting comments inside object literals (they're useful for documenting test data)

---

## [2026-02-28 13:05 PST] - Documentation Discovery Could Be Easier

**What I was trying to do:** Find the correct syntax for defining function inputs with array types

**What the issue was:** Had to make multiple MCP calls to find the right documentation topics (functions, types, syntax, essentials)

**Why it was an issue:** It took several iterations to discover that:
1. Arrays are defined as `type[]` (e.g., `int[]`)
2. Multi-dimensional arrays should use `json` type
3. The `essentials` topic had the most practical syntax patterns

**Potential solution (if known):**
- A single "cheat sheet" or "common patterns" topic that covers the most frequent use cases
- Cross-references between topics (e.g., in the "functions" topic, link to "types" for input syntax)
- A troubleshooting guide for common syntax errors with suggested fixes

---

## General Observation: Array Manipulation Syntax

The `number-of-islands` example was very helpful for understanding the array manipulation patterns in XanoScript. Key learnings:

- Use `array.push` and `array.pop` instead of `var` with `merge` for stack operations
- Use `math.add` for incrementing counters instead of `var.update`
- `continue` keyword is supported in loops

Having more examples of common patterns (stack operations, matrix traversal, etc.) in the documentation would be valuable.
