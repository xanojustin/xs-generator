# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 17:35 PST] - 2D Array Type Not Supported

**What I was trying to do:** Create a function that accepts a 2D matrix (array of arrays) as input for the maximal square problem.

**What the issue was:** I initially wrote `int[][] matrix` to represent a 2D integer array, but XanoScript doesn't support this syntax. The validator gave this error:
```
[Line 5, Column 10] Expecting token of type --> Identifier <-- but found --> '[' <--
```

**Why it was an issue:** In many programming languages (Java, C++, TypeScript), `int[][]` or `number[][]` is the standard way to declare a 2D array. I had to guess that `json` type might work for arbitrary nested arrays, which it did.

**Potential solution (if known):** 
- Add documentation about handling multi-dimensional arrays - recommend using `json` type
- Consider supporting array type notation like `int[]` for 1D arrays or documenting that `json` is the catch-all for complex structures

---

## [2026-02-22 17:35 PST] - Good Documentation Coverage

**What I was trying to do:** Learn XanoScript syntax for functions, run jobs, loops, and conditionals.

**What the issue was:** No issues - the `xanoscript_docs` tool provided comprehensive documentation.

**Why it was a positive experience:** The documentation clearly covered:
- Function structure with input/stack/response blocks
- run.job syntax for calling functions
- Loop patterns (for, foreach, while)
- Conditional syntax with `elseif` (not `else if`)
- Type names (`int`, `text`, `bool`, `json` instead of `integer`, `string`, `boolean`)
- Common mistakes section was very helpful

**Potential improvement:** Consider adding a section about handling matrices/2D arrays since this is a common interview problem pattern.

---
