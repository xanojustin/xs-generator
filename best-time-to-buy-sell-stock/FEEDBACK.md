# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 01:35 PST] - While loop not supported

**What I was trying to do:** Implement a stock profit calculator that iterates through an array of prices using a while loop with an index counter.

**What the issue was:** XanoScript doesn't support `while` loops. When I tried to use:
```xs
while ($index < ($input.prices|count)) {
  // ...
}
```

I got this error:
```
[Line 25, Column 49] Expecting --> each <-- but found --> '
' <--
```

**Why it was an issue:** I assumed standard programming language constructs like `while` loops would be available. The error message was confusing because it suggested the parser was expecting `each` (which is part of `foreach`), but didn't explicitly say "while loops are not supported."

**Potential solution:**
1. Add explicit documentation about which control flow structures are supported (only `foreach` for iteration, no `while` or `for`)
2. Provide a clearer error message like: "While loops are not supported in XanoScript. Use foreach with a manual index counter instead."
3. Include examples in the syntax documentation showing how to do index-based iteration without while loops

---

## [2026-02-21 01:38 PST] - Documentation discovery for foreach patterns

**What I was trying to do:** Find the correct pattern for iterating through an array with index access.

**What the issue was:** The syntax documentation mentions `foreach` but doesn't provide clear examples of how to access the current index or how to skip the first N elements. I had to look at existing exercises (like `two_sum`) to understand the pattern of using a manual `var $index` counter with `var.update`.

**Why it was an issue:** Without access to existing code examples, it would have been difficult to discover this pattern from the documentation alone.

**Potential solution:**
1. Add a "Common Patterns" section to the syntax docs showing index-based iteration
2. Include an example like:
   ```xs
   var $index { value = 0 }
   foreach ($array) {
     each as $item {
       // Access index with $index, item with $item
       var.update $index { value = $index + 1 }
     }
   }
   ```

---

## General Feedback on MCP Experience

**Positive:**
- The `validate_xanoscript` tool is fast and provides helpful line/column error locations
- Having the Xano MCP integrated via mcporter makes the workflow smooth
- The documentation topics are well-organized

**Areas for improvement:**
1. A comprehensive language reference showing ALL supported syntax would be helpful
2. Error messages could be more descriptive for unsupported features
3. More examples in the quick_reference mode would reduce context switching
