# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 11:05 PST] - Issue Title: Nested array type syntax unclear

**What I was trying to do:** Define an input parameter for an array of integer arrays (int[][]) representing multiple sorted lists.

**What the issue was:** Used `int[][] lists` syntax which resulted in a parse error: "Expecting token of type --> Identifier <-- but found --> '[' <--"

**Why it was an issue:** XanoScript doesn't support multi-dimensional array type notation like `int[][]`. I had to discover through trial and error that `json` type should be used instead for nested array structures.

**Potential solution (if known):** 
- Document the proper way to handle nested arrays in the types documentation
- Either support `int[][]` syntax or clearly document that `json` should be used for nested arrays
- Provide examples of complex data structures in the quickstart guide

---

## [2025-02-21 11:05 PST] - Issue Title: Unclear error message for type syntax

**What I was trying to do:** Parse the validation error to understand what went wrong.

**What the issue was:** The error message "Expecting token of type --> Identifier <-- but found --> '[' <--" was somewhat cryptic. It wasn't immediately clear that `int[][]` was invalid syntax.

**Why it was an issue:** Had to guess that the issue was with the type declaration and try `json` instead. A more helpful error might suggest valid alternatives.

**Potential solution (if known):**
- Improve error messages to suggest valid type alternatives
- Add a hint like "Use 'json' type for nested arrays" when detecting nested bracket syntax

---
