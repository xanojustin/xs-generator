# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 17:35 PST] - 2D Array Type Syntax

**What I was trying to do:** Define a function input that accepts a 2D array of integers (costs matrix for the paint house problem).

**What the issue was:** I tried to use `int[][] costs` following common programming language conventions, but XanoScript doesn't support multi-dimensional array type notation.

**Why it was an issue:** The validator gave a cryptic error: "Expecting token of type --> Identifier <-- but found --> '['". This didn't clearly indicate that `int[][]` is invalid syntax.

**Potential solution:**
1. The documentation could explicitly mention that only 1D arrays (`int[]`, `text[]`, etc.) are supported
2. The validator could give a more helpful error like: "Multi-dimensional array types are not supported. Use `json` type for arbitrary nested arrays."
3. Consider supporting `int[][]` syntax or at least `json` with array validation

---

## [2025-03-01 17:40 PST] - Confusion Between `response` and `return`

**What I was trying to do:** Implement early returns for edge cases (empty input, single house) inside the function stack.

**What the issue was:** I used `response = 0` inside conditional blocks within the stack, but this is invalid syntax. The error message "Expecting --> } <-- but found --> 'response'" was confusing because it didn't explain *why* response was unexpected.

**Why it was an issue:** I had to re-read the documentation multiple times to understand that:
- `response = ...` is only valid at the function level (after the stack block)
- Inside the stack, you must use `return { value = ... }` for early returns

**Potential solution:**
1. The validator could give a specific error like: "`response` cannot be used inside stack blocks. Use `return { value = ... }` for early returns."
2. The documentation could have a clearer distinction between `response` (function-level output) and `return` (stack-level early exit)
3. A side-by-side comparison in the docs would help:
   ```
   WRONG:
   stack {
     if ($condition) { response = value }  // Invalid!
   }
   
   RIGHT:
   stack {
     if ($condition) { return { value = value } }  // Correct!
   }
   response = $default_value  // Function-level default
   ```

---

## [2025-03-01 17:45 PST] - Filter Syntax for Complex Expressions

**What I was trying to do:** Get the minimum value from an array using `($prev_dp|sort)|first`.

**What the issue was:** I wasn't sure if parentheses were required around filter expressions when chaining them. The documentation mentions parentheses are needed for filters in concatenation, but I wasn't sure about other contexts.

**Why it was an issue:** XanoScript requires careful parenthesization of filter expressions in certain contexts, and it's not always clear when they're mandatory vs optional.

**Potential solution:**
1. A more explicit rule in the documentation: "Always wrap filter expressions in parentheses when they appear in compound expressions or as operands"
2. The validator could auto-suggest adding parentheses when a filter expression might be ambiguous

---

## [2025-03-01 17:50 PST] - While Loop Variable Shadowing

**What I was trying to do:** Update loop variables inside while loops (e.g., `var $house_idx { value = $house_idx + 1 }`).

**What the issue was:** I was redeclaring variables with the same name inside the while loop body using `var`. This might create new variables instead of updating existing ones.

**Why it was an issue:** The documentation shows `var.update` for updating existing variables, but I wasn't sure if redeclaring with `var` inside a loop would shadow or update.

**Potential solution:**
1. Clarify in the docs whether `var` inside a loop body creates a new scope or not
2. Show more loop examples with variable updates
3. Consider adding a lint warning for variable shadowing inside loops

---

## General Observations

**Positive:**
- The `validate_xanoscript` tool is fast and provides line/column numbers
- The error messages include the actual code context
- Having separate documentation topics (essentials, functions, run) is helpful

**Suggestions for Improvement:**
1. **Better error messages:** Instead of generic parser errors, suggest the likely fix
2. **Type system clarity:** More examples of complex types (nested objects, 2D arrays)
3. **Control flow examples:** More examples showing `return` vs `response` patterns
4. **Interactive validation:** Would be nice to have a "fix suggestion" mode in the validator
