# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 01:05 PST] - Parentheses Required for Filter + Test Combinations

**What I was trying to do:** Write a while loop that checks if the stack has elements remaining

**What the issue was:** Got a validation error: "An expression should be wrapped in parentheses when combining filters and tests"

Code that failed:
```xs
while ($stack|count > 0) {
```

**Why it was an issue:** The validator correctly flagged that combining a filter (`|count`) with a comparison operator (`>`) requires parentheses around the filtered expression for clarity and correct parsing.

**Potential solution (if known):** The error message was clear and helpful. The fix was simple:
```xs
while (($stack|count) > 0) {
```

This is consistent with the documentation note about wrapping filtered expressions in parentheses when concatenating strings. It would be helpful to explicitly mention this applies to ALL filter + operator combinations, not just string concatenation.

---

## [2025-02-19 01:07 PST] - Iterative Approach Required (No Recursion)

**What I was trying to do:** Implement a flatten function for arbitrarily nested arrays

**What the issue was:** XanoScript functions don't appear to support recursion (no way for a function to call itself). I had to rewrite the algorithm to use an iterative stack-based approach instead of the more natural recursive solution.

**Why it was an issue:** Flattening nested arrays is typically solved with recursion in most languages. The iterative stack-based approach is less intuitive and requires manually managing a stack.

**Potential solution (if known):** Consider documenting whether recursion is supported in functions. If not, add examples of common recursive patterns (tree traversal, flattening) implemented iteratively.

---

## [2025-02-19 01:08 PST] - `is_array` Test Works Well

**What I was trying to do:** Check if an element is an array or a scalar value

**What the issue was:** None - the `is_array` test worked on first try

**Why it was an issue:** N/A - success case

**Potential solution (if known):** The `is_array` test is documented in the syntax quick reference and worked as expected. Consider adding `is_object`, `is_text`, `is_int`, etc. for type checking consistency.

---
