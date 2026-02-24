# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-23 22:05 PST - 2D Array Type Notation Not Supported

**What I was trying to do:** Define a 2D array input for a matrix (array of arrays of integers)

**What the issue was:** I tried to use `int[][] mat` to represent a 2D integer matrix, but XanoScript doesn't support multi-dimensional array type notation like `int[][]`. The parser failed with:
```
[Line 7, Column 10] Expecting token of type --> Identifier <-- but found --> '[' <--
```

**Why it was an issue:** Without knowing the correct pattern, I had to guess and then wait for validation to fail. Common languages (TypeScript, Java, C++) all support `int[][]` or `number[][]` for 2D arrays.

**Potential solution:** 
1. Document that 2D arrays should use `json` type instead
2. Consider supporting `int[]` for 1D arrays and document that nested arrays require `json`
3. The MCP error suggestion was helpful but could explicitly mention "Use `json` type for multi-dimensional arrays"

---

## 2025-02-23 22:08 PST - mcporter Directory Path Expansion

**What I was trying to do:** Validate files using `~/xs/reshape-matrix` path

**What the issue was:** The tilde (`~`) wasn't expanded to the home directory:
```
No .xs files found in directory: ~/xs/reshape-matrix
```

**Why it was an issue:** Had to switch to absolute path `/Users/justinalbrecht/xs/reshape-matrix` for validation to work.

**Potential solution:** 
1. Support shell-style path expansion (tilde ~) in the MCP tools
2. Document that absolute paths are required

---
