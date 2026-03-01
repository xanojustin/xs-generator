# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 22:05 PST] - Issue: Filter expressions need parentheses

**What I was trying to do:** Check if the input array has fewer than 3 elements

**What the issue was:** The expression `$input.nums|count < 3` caused a validation error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** I didn't know that filter operations like `|count` need to be wrapped in parentheses when used in comparisons. The error message was helpful but I had to guess the correct syntax.

**Potential solution:** The documentation could show more examples of combining filters with operators. Something like:
```xs
// WRONG
if ($array|count < 3) { }

// CORRECT
if (($array|count) < 3) { }
```

---

## [2025-02-28 22:08 PST] - Issue: While loops require `each` blocks

**What I was trying to do:** Write a while loop to iterate with two pointers

**What the issue was:** The validator complained "Expecting --> each <-- but found --> '\n'" after my while loop condition. I didn't know while loops require an `each { ... }` block inside them.

**Why it was an issue:** This is unusual syntax compared to other languages. I had to look at existing examples (3sum exercise) to discover this pattern.

**Potential solution:** 
1. Better error message explaining that `each { ... }` is required inside while loops
2. Documentation showing the while loop pattern more prominently

Example of correct syntax:
```xs
while ($i < $n) {
  each {
    // loop body here
    var $i { value = $i + 1 }
  }
}
```

---

## [2025-02-28 22:10 PST] - Issue: Array access syntax unclear

**What I was trying to do:** Access array elements by index

**What the issue was:** I initially wrote `$sorted|get:0` and `$sorted|get:$i` but then saw in existing code the syntax is `($sorted[0])` and `($sorted[$i])` with parentheses.

**Why it was an issue:** Both syntax variations might work, but the bracket notation with parentheses seems to be the standard. It was confusing to know which to use.

**Potential solution:** Clarify in documentation:
- When to use `|get:index` filter vs bracket notation
- Why parentheses are required around bracket access

---

## [2025-02-28 22:12 PST] - General Feedback: Need more function examples

**What I was trying to do:** Write a complete function with input, stack logic, and response

**What the issue was:** The documentation is good for reference but lacks complete, runnable function examples that show:
- Proper input parameter declaration
- Variable declaration patterns
- Control flow (if/else, while, foreach)
- Return statement usage

**Potential solution:** Add a "Function Examples" section with 3-5 complete, copy-pasteable functions of increasing complexity (hello world, simple math, array processing, nested loops).

---

## [2025-02-28 22:15 PST] - Positive Feedback: Validation tool is helpful

**What worked well:** The `validate_xanoscript` tool provides clear error messages with line numbers and suggestions. The "Use X instead of Y" hints (like using `int` instead of `integer`) are very helpful.

**Suggestion:** The validation tool could also warn about common style issues or suggest optimizations.
