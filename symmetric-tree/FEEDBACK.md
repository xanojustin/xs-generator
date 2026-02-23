# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-22 18:35 PST] - Documentation for Tree Data Structures

**What I was trying to do:** Implement a symmetric tree check that takes an array representation of a binary tree

**What the issue was:** The documentation for recursive patterns in XanoScript is minimal. I needed to implement a recursive tree traversal but wasn't sure if XanoScript supports true recursion (functions calling themselves). The `function.run` syntax requires calling a predefined function by name, making true recursion difficult without pre-declaring the recursive function.

**Why it was an issue:** Tree problems typically use recursion. Without clear recursion patterns, I had to implement an iterative solution using a manual stack, which is less intuitive for tree traversal problems.

**Potential solution (if known):** Document whether XanoScript supports recursion and provide examples. If not, provide patterns for iterative tree traversal using manual stacks.

---

## [2025-02-22 18:35 PST] - Array Index Access Syntax

**What I was trying to do:** Access array elements by index (e.g., `$input.tree[$index]`)

**What the issue was:** The documentation shows array access but it's scattered across examples. I had to infer from `db.query` examples and filter usage that array indexing uses bracket notation.

**Why it was an issue:** Without clear documentation on array indexing syntax, I wasn't certain if `$array[index]` was valid or if I needed to use a filter like `$array|get:index`.

**Potential solution (if known):** Add a clear section on array indexing syntax to the syntax documentation.

---

## [2025-02-22 18:35 PST] - Ternary/Conditional Expressions

**What I was trying to do:** Use a ternary operator to conditionally get values: `($left_idx < ($input.tree|count)) ? $input.tree[$left_idx] : null`

**What the issue was:** I assumed ternary syntax from other languages would work, but I didn't find explicit documentation confirming this pattern exists in XanoScript.

**Why it was an issue:** Without confirmation, I was gambling that the syntax would work. If it didn't, I would need to rewrite with conditional blocks which are more verbose.

**Potential solution (if known):** Document the ternary/conditional expression syntax clearly in the operators section.

---

## [2025-02-22 18:35 PST] - Positive Feedback: Validation Tool

**What I was trying to do:** Validate my XanoScript files

**What went well:** The validation tool worked perfectly the first time. It validated both files and reported success clearly.

**Why this matters:** Immediate feedback on syntax correctness helps catch errors early before deployment.

**Potential improvement:** Consider adding warnings for potentially problematic patterns (like complex nested conditionals or very deep nesting).
