# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 07:35 PST] - Issue: while loops not supported

**What I was trying to do:** Implement a classic iterative solution using a `while` loop to iterate over array indices.

**What the issue was:** XanoScript does not support `while` loops. The error message was:
```
[Line 15, Column 39] Expecting --> each <-- but found --> '\n'
```

**Why it was an issue:** I had to completely change my approach from a familiar `while` loop pattern to using `foreach` with a range operator `(0..n)`. This wasn't obvious from any documentation I initially saw.

**Potential solution (if known):** 
- Document the available loop constructs clearly in the quick reference
- Consider adding `while` loop support for more familiar programming patterns
- The error message could be more helpful — "while loops not supported, use foreach with range instead"

---

## [2026-02-26 07:36 PST] - Issue: Array element access syntax unclear

**What I was trying to do:** Access array elements by index using `$input.nums[$i]` syntax.

**What the issue was:** I was unsure if the bracket notation `$array[index]` was correct XanoScript syntax since it wasn't explicitly shown in the quick reference documentation I reviewed.

**Why it was an issue:** Had to guess/experiment with array access syntax. The documentation shows filters like `|get:N` for array access but doesn't clearly document if bracket notation is supported.

**Potential solution (if known):** 
- Add explicit documentation for array access patterns: `$array[index]` vs `$array|get:index`
- Include examples of both approaches in the syntax documentation

---

## [2026-02-26 07:37 PST] - Issue: Appending to arrays - set vs array.push

**What I was trying to do:** Append elements to the result array during iteration.

**What the issue was:** Initially tried using `$result = $result|set:$i:$value` but this sets by key/index. For building an array progressively, `array.push` is more appropriate but was in a different section of the docs (Array Functions vs Array Filters).

**Why it was an issue:** The distinction between array filters (`|set`, `|push`) and array functions (`array.push`, `array.filter`) is not immediately clear. They behave similarly but have different syntax.

**Potential solution (if known):** 
- Clarify when to use filter syntax vs function syntax
- Provide a "building an array incrementally" example in the documentation

---

## [2026-02-26 07:38 PST] - Issue: Filter precedence with range operator

**What I was trying to do:** Create a range from 0 to array length minus 1: `(0..(($input.nums|count) - 1))`

**What the issue was:** Had to carefully place parentheses around the filtered expression `($input.nums|count)` before doing arithmetic. Without parentheses, the filter binds incorrectly.

**Why it was an issue:** This is documented (the "Parentheses and Filter Precedence" section is very clear), but it's easy to forget and the error messages don't always indicate this is the problem.

**Potential solution (if known):** 
- The existing documentation is actually quite good on this point
- Maybe a linter warning when operators follow filters without parentheses?

---

## MCP Server Feedback

The MCP server worked well overall:
- `validate_xanoscript` tool was fast and helpful
- Error messages included line/column numbers
- `xanoscript_docs` provided comprehensive documentation

One improvement: It would be helpful to have a "common patterns" or "cookbook" topic in the docs that shows how to do things like "iterate over array with index" or "build an array progressively".
