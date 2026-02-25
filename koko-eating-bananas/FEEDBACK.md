# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 18:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Write a conditional check to see if the input array is empty using the `count` filter.

**What the issue was:** The validator rejected this code:
```xs
if ($input.piles|count == 0) {
```

The error message was: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The syntax seemed natural coming from other languages where you can chain operations. The requirement to wrap filter expressions in parentheses when comparing wasn't immediately obvious from the quick reference docs.

**Potential solution (if known):** 
- The quickstart docs mention "With filters (use parentheses)" for string concatenation, but could be more explicit about comparison operations
- A code example showing `($array|count) == 0` would be helpful in the quickstart

---

## [2025-02-24 18:36 PST] - Documentation Access Pattern

**What I was trying to do:** Get XanoScript syntax documentation before writing code.

**What the issue was:** Had to call two separate documentation queries to get enough context:
1. `topic:"run"` for run job syntax
2. `topic:"functions"` for function syntax
3. `topic:"quickstart"` for common patterns

**Why it was an issue:** It took multiple round trips to get the full picture. Each call returns only the specific topic requested.

**Potential solution (if known):** 
- A single `topic:"beginner"` or `topic:"coding-exercise"` that combines run.job + function + quickstart patterns would be helpful for this use case
- Or allow multiple topics in one call: `topics: ["run", "functions", "quickstart"]`

---

## [2025-02-24 18:37 PST] - Missing Binary Search Pattern in Docs

**What I was trying to do:** Implement a binary search algorithm with a while loop and variable updates.

**What the issue was:** Couldn't find clear documentation on while loop syntax and variable update patterns in the quick reference.

**Why it was an issue:** Had to infer from the quickstart example:
```xs
while ($counter < 10) {
  each {
    var.update $counter { value = $counter + 1 }
  }
}
```

But wasn't sure if `var.update` was the correct pattern for modifying variables in loops.

**Potential solution (if known):** 
- A "common algorithms" section with binary search, DFS/BFS patterns would be valuable
- More detail on `var.update` vs `var` redeclaration would help

---
