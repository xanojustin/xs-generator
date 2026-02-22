# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 13:45 PST] - Array element modification not supported

**What I was trying to do:** Implement the multiply strings algorithm which requires updating values at specific positions in an array during the multiplication process.

**What the issue was:** I initially tried to use `$array|edit:index:value` filter to modify array elements in place, but this filter doesn't exist in XanoScript. The validation error was: "Unknown filter function 'edit'".

**Why it was an issue:** This is a common pattern in algorithms where you need to accumulate values at specific indices. Without direct array element assignment, I had to work around by rebuilding the entire array each time I needed to update a value, which is inefficient.

**Potential solution (if known):** 
- Add an `array.edit` operation or `|edit:index:value` filter to modify array elements
- Alternatively, document the recommended pattern for array element updates (rebuilding vs other approaches)
- Consider adding `array.set` or similar for direct index assignment

---

## [2026-02-22 13:45 PST] - Conditional/else syntax confusion

**What I was trying to do:** Write an if-else block to handle the edge case where both inputs are zero.

**What the issue was:** I initially wrote:
```xs
conditional {
  if ($result == "") {
    var $result { value = "0" }
  }
}
```
But when trying to add an `else` clause, I got a syntax error: "Expecting --> } <-- but found --> 'else' <--"

**Why it was an issue:** The documentation doesn't clearly show that the `else` must be inside the `conditional` block alongside the `if`, not after it. The correct syntax is:
```xs
conditional {
  if (condition) {
    // code
  }
  else {
    // code
  }
}
```

**Potential solution (if known):**
- Add clearer examples of if-else syntax in the quickstart documentation
- The syntax is correct once you know it, but the error message could be more helpful

---

## [2026-02-22 13:45 PST] - MCP documentation topics returning same content

**What I was trying to do:** Get specific documentation for functions and run jobs by calling `xanoscript_docs` with different topic parameters.

**What the issue was:** Calling `xanoscript_docs({ topic: "functions" })`, `xanoscript_docs({ topic: "quickstart" })`, and `xanoscript_docs({ topic: "run" })` all returned the same general README content instead of topic-specific documentation.

**Why it was an issue:** I had to look at existing code examples in the `~/xs/` directory to understand the correct patterns instead of relying on the documentation.

**Potential solution (if known):**
- Fix the topic parameter handling in the MCP server
- Ensure each topic returns its specific documentation content
- The documentation index lists many topics but they may not be properly implemented

---

## [2026-02-22 13:45 PST] - No array element assignment operation

**What I was trying to do:** Build the multiply strings algorithm which requires accumulating values at specific array indices.

**What the issue was:** XanoScript doesn't appear to have any operation for directly assigning a value to a specific array index. I had to work around this by:
1. Creating a new temporary array
2. Looping through the original array
3. Pushing values to the new array (with the updated value at the target index)
4. Reassigning the variable

**Why it was an issue:** This is computationally inefficient (O(n) for each update instead of O(1)) and makes the code more verbose and harder to read.

**Potential solution (if known):**
- Add `array.set $array { index = 5, value = 10 }` operation
- Or support indexed assignment syntax like `$array[5] = 10`
- Document the recommended workaround pattern for this common use case

---

## [2026-02-22 13:45 PST] - Variable update patterns inconsistent

**What I was trying to do:** Update variable values throughout the function.

**What the issue was:** I found multiple ways variables are updated in existing code:
- `math.add $i { value = 1 }` - for arithmetic
- `var.update $carry { value = $new_carry }` - seen in other examples but didn't work
- `var $i { value = $i - 1 }` - redeclaring with new value

The validation showed that `math.add` is the correct approach for arithmetic updates, but the documentation doesn't clearly explain when to use each pattern.

**Why it was an issue:** Inconsistent patterns make it hard to write correct code without trial and error.

**Potential solution (if known):**
- Document the different variable update patterns clearly
- Explain when to use `math.add` vs `var.update` vs redeclaring
- Provide examples for common scenarios (increment, decrement, reassignment)

---

## Summary

Overall, the validation tool was very helpful - it caught syntax errors quickly and provided useful suggestions. The main struggles were:

1. **Missing array operations** - No way to edit array elements directly
2. **Documentation gaps** - Topics returning same content, unclear syntax examples
3. **Inconsistent patterns** - Multiple ways to update variables without clear guidance

The error messages were generally helpful (especially suggesting `$result` is reserved), but some could be more specific about the correct syntax.
