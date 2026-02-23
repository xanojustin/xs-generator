# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 03:05 PST] - 2D Array Type Not Documented Clearly

**What I was trying to do:** Define a function input that accepts a 2D array (matrix) of integers

**What the issue was:** Used `int[][] matrix` syntax which seemed logical but got error:
```
[Line 8, Column 10] Expecting token of type --> Identifier <-- but found --> '[' <--
```

**Why it was an issue:** XanoScript doesn't support `int[][]` syntax for 2D arrays. I had to search existing codebases to discover that `json` type should be used instead.

**Potential solution:** Document this explicitly in the types documentation — mention that multi-dimensional arrays should use `json` type.

---

## [2025-02-23 03:08 PST] - Return Inside Conditional Block

**What I was trying to do:** Return early from a function when handling edge cases (empty matrix)

**What the issue was:** Used `response = 0` followed by `return` inside a conditional, which caused:
```
[Line 15, Column 9] Expecting --> } <-- but found --> 'response' <--
```

**Why it was an issue:** The syntax `response = value` can only be used at the end of a function (the response block), not inside the stack. Inside conditionals, you must use `return { value = 0 }`.

**Potential solution:** Better documentation on early returns — the distinction between `response = $var` at function end vs `return { value = ... }` inside stack logic is not obvious.

---

## [2025-02-23 03:10 PST] - For Loop Syntax Ambiguity

**What I was trying to do:** Create a simple for loop to initialize an array

**What the issue was:** Used `for ($cols) { each { ... } }` but got:
```
[Line 33, Column 12] Expecting --> as <-- but found --> '{' <--
```

**Why it was an issue:** The `for` loop requires `each as $var` syntax, not just `each`. Also, inside the loop I was incorrectly using `var $heights { value = $heights|merge:[0] }` instead of `array.push`.

**Potential solution:** The quick reference shows `for (10) { each as $i { ... } }` but it's easy to miss that `as $i` is required, not optional.

---

## [2025-02-23 03:15 PST] - Array Element Update Syntax

**What I was trying to do:** Update an element in an array: `$heights[$col_idx] = $heights[$col_idx] + 1`

**What the issue was:** Used `var $heights[$col_idx] { value = ... }` which is invalid syntax.

**Why it was an issue:** Array element updates require `var.update $heights[$col_idx] { value = ... }` syntax, which is different from regular variable declaration.

**Potential solution:** Document array operations more clearly — creating arrays vs updating elements vs pushing items are all different syntaxes (`var`, `var.update`, `array.push`).

---

## [2025-02-23 03:18 PST] - Filter Expression Parentheses

**What I was trying to do:** Compare the result of a filter: `$input.matrix|count == 0`

**What the issue was:** Got error about expressions needing parentheses when combining filters and tests.

**Why it was an issue:** Filters bind greedily, so `$arr|count == 0` parses as `$arr | (count == 0)` instead of `($arr|count) == 0`.

**Potential solution:** The documentation does mention this, but it's buried. A more prominent warning or linter suggestion would help.

---

## [2025-02-23 03:20 PST] - MCP Server Connection Issues

**What I was trying to do:** Validate files using the Xano MCP

**What the issue was:** Initially got "Unknown MCP server 'xano'" errors when calling from different directories or using `--output json` flag.

**Why it was an issue:** The MCP tool works inconsistently depending on how you call it. Sometimes `mcporter call xano.tool` works, sometimes it needs the full path specification.

**Potential solution:** More robust MCP daemon handling — the "Unknown MCP server" error is confusing when the server is clearly listed as healthy.
