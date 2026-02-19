# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 10:05 PST] - Filter expressions with comparisons need parentheses

**What I was trying to do:** Check if an array has fewer than 2 elements using `$input.numbers|count < 2`

**What the issue was:** The validator reported: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The syntax for combining filters with comparison operators isn't intuitive. I had to write `($input.numbers|count) < 2` instead of the more natural `$input.numbers|count < 2`.

**Potential solution:** The error message is helpful but could be more explicit: "When using a filter in a comparison, wrap the filter expression in parentheses: `($var|filter) < value`"

---

## [2025-02-19 10:06 PST] - No `index as` syntax in foreach loops

**What I was trying to do:** Get the current index while iterating through an array using `foreach` with `index as $idx`

**What the issue was:** The syntax `index as $idx {` is not valid in XanoScript. The parser expected `}` but found `index`.

**Why it was an issue:** Many programming languages support getting the index in a foreach loop (e.g., `enumerate()` in Python, `for i, v := range` in Go). I assumed XanoScript would have similar syntax.

**Potential solution:** 
1. Add explicit documentation about how to iterate with indices (the solution is to use the range operator `(start..end)`)
2. Consider adding `index as` or `with_index` syntax to foreach for better ergonomics

---

## [2025-02-19 10:08 PST] - Cannot reassign variables with `set`

**What I was trying to do:** Update a variable inside a loop using `set $idx = $idx + 1`

**What the issue was:** The validator reported "Expecting --> } <-- but found --> 'set'" when trying to use `set` on a regular variable.

**Why it was an issue:** The documentation shows `set` being used for object properties (`set $seen[$complement] = $idx`), but it's not clear that `set` cannot be used on regular variables. I assumed variables could be reassigned.

**Potential solution:**
1. Add explicit documentation stating that variables are immutable once declared
2. Provide clearer error messages: "Variables cannot be reassigned. Consider using `return` for early exit or restructuring your logic."
3. The `quickstart` or `functions` topic should mention the functional/immutable nature of XanoScript variables

---

## [2025-02-19 10:10 PST] - Had to pivot from O(n) to O(n²) algorithm

**What I was trying to do:** Implement the optimal O(n) hash map solution for Two Sum

**What the issue was:** Without variable reassignment, maintaining a hash map that gets updated during iteration became overly complex. I had to switch to a brute-force O(n²) nested loop approach using range-based indices.

**Why it was an issue:** XanoScript's functional/immutable style forces algorithmic compromises. The hash map solution requires mutating state (the `seen` map) as we iterate.

**Potential solution:**
1. Consider adding a `reduce` or `fold` operation that allows accumulating state (the docs mention `reduce` filter but it's not clear how to use it with complex logic)
2. Document functional programming patterns for common algorithmic problems
3. Provide examples of how to implement hash-map based solutions in XanoScript

---

## [2025-02-19 10:00 PST] - MCP validation tool worked great

**Positive feedback:** The `validate_xanoscript` tool via mcporter worked smoothly. The error messages included line/column numbers and helpful suggestions. Being able to validate a directory recursively made the iteration loop fast.

**Suggestion:** Consider adding a `--watch` mode to the validation tool for automatic re-validation on file changes during development.
