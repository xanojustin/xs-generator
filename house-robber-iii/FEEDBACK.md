# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 15:35 PST] - Object vs json type confusion

**What I was trying to do:** Define a function input that accepts a nested object (binary tree node with optional left/right children)

**What the issue was:** Used `object? left` syntax thinking it was valid TypeScript-style nullable typing

**Why it was an issue:** XanoScript doesn't use `object` as a type name. The MCP validation error was helpful and suggested using `json` instead.

**Potential solution (if known):** The error message was actually very helpful! But it would be good to have this documented clearly in the quick reference - maybe add a table of "Types NOT to use" vs "XanoScript equivalents".

---

## [2025-03-01 15:38 PST] - Arrow functions not supported

**What I was trying to do:** Create a recursive helper function using arrow function syntax `->($node) { ... }` inside the stack block

**What the issue was:** XanoScript doesn't support first-class functions or lambda/arrow function syntax

**Why it was an issue:** I assumed XanoScript would have some form of function-as-value support since many languages do. I had to rewrite the algorithm to use `function.run` calls instead of passing functions as values.

**Potential solution (if known):** Add a note in the "essentials" documentation about what's NOT supported: "No first-class functions, no arrow functions, no function values. Use `function.run` for recursion."

---

## [2025-03-01 15:40 PST] - Recursive algorithm implementation challenge

**What I was trying to do:** Implement House Robber III which naturally lends itself to a recursive DFS solution returning two values (rob/skip)

**What the issue was:** Without arrow functions, I couldn't easily return a pair of values from a "helper function." I had to restructure the algorithm to compute values directly in each function call.

**Why it was an issue:** The natural DP solution uses a helper that returns `[skip_value, rob_value]`. Without tuples/arrays as return values from internal helpers, I had to expand the logic inline - checking grandchildren explicitly rather than recursively getting both values from children.

**Potential solution (if known):** This might just be a limitation to document. The workaround is to flatten the recursion logic - instead of "get child's decision pair," you compute "get child's grandchildren's values" explicitly.

---
