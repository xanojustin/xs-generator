# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 11:32 PST] - Validation Success

**What I was trying to do:** Validate the XanoScript files for the predict-the-winner exercise.

**What happened:** Both files passed validation on the first attempt.

**Result:** Success! The syntax patterns I used were correct:
- `var $name { value = ... }` for variable declaration
- `var.update $name { value = ... }` for variable updates
- `while (condition) { each { ... } }` for while loops
- `conditional { if (...) { } elseif (...) { } else { } }` for conditionals
- Array operations with filters like `|count`, `|get`, `|set`, `|append`
- String concatenation with `~` operator
- Nullish coalescing with `??` operator

---

## [2025-02-27 11:30 PST] - Initial Implementation Concern

**What I was trying to do:** Implement the "predict-the-winner" coding exercise using dynamic programming with a 2D DP table simulated as a 1D array.

**What the issue was:** First draft used lambda function syntax `($i, $j) => { ... }` which is not valid XanoScript syntax.

**Why it was an issue:** Lambda functions/closures are not documented in the XanoScript documentation. The syntax would have been invalid.

**Solution:** Rewrote without lambda functions, using direct array manipulation with index calculations instead.

---
