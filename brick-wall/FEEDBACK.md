# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 02:00 PST] - int[][] type not supported

**What I was trying to do:** Define a 2D array input parameter for the brick wall problem where each row contains an array of brick widths.

**What the issue was:** The XanoScript syntax `int[][] wall` is not valid. The validator returned: "Expecting token of type Identifier but found '['" with a suggestion to "Use type[] instead of array".

**Why it was an issue:** I based my syntax on an existing file (`minimum_height_trees/function/minimum_height_trees.xs`) which also uses `int[][] edges`, but that file also fails validation. This suggests either:
1. The syntax was once valid but no longer is
2. Those files were never validated
3. There's a different way to declare 2D arrays

**Potential solution (if known):** The workaround is to use `json` type instead of `int[][]`, which works but loses type safety. The documentation should clarify how to declare multi-dimensional arrays, or the validator should provide a clearer error message suggesting to use `json` for nested arrays.

---

## [2025-03-03 02:05 PST] - Filter expressions need parentheses in conditionals

**What I was trying to do:** Check if an array is empty using `$input.wall|count == 0`.

**What the issue was:** The validator returned: "An expression should be wrapped in parentheses when combining filters and tests".

**Why it was an issue:** This is a subtle syntax requirement. I had to change `$input.wall|count == 0` to `($input.wall|count) == 0`.

**Potential solution (if known):** The error message was clear enough, but it would be helpful if the documentation included this pattern more prominently. This is easy to forget when coming from other languages.

---

## [2025-03-03 02:05 PST] - Cannot use response = inside conditional blocks

**What I was trying to do:** Return early from a function using `response = 0` inside a conditional block for the empty wall edge case.

**What the issue was:** The validator returned: "Expecting } but found response". The `response =` assignment only works at the top level of the stack block, not inside conditionals.

**Why it was an issue:** In many languages, early return is a common pattern. In XanoScript, I need to use `return { value = 0 }` instead.

**Potential solution (if known):** The documentation should clearly distinguish between:
- `response = $var` - sets the final response (only at end of stack)
- `return { value = ... }` - early return from within conditionals/loops

---

## [2025-03-03 02:00 PST] - MCP validate_xanoscript parameter format confusion

**What I was trying to do:** Validate multiple files at once using the validate_xanoscript tool.

**What the issue was:** The parameter format was unclear. I tried several approaches:
- JSON format: `'{"file_paths": [...]}'` - didn't work
- Array syntax with flags: `--file_paths '["..."]'` - didn't work
- Eventually found: `file_path="/path/to/file"` works for single files

**Why it was an issue:** The mcporter help shows the parameter types but not the exact CLI syntax needed. The error messages weren't helpful for figuring out the correct format.

**Potential solution (if known):** The MCP documentation or mcporter help should include clear examples of the exact CLI syntax for each parameter type (string, array, object).
