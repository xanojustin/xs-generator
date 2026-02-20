# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 23:05 PST] - validate_xanoscript file_paths parameter parsing

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated values as shown in the tool schema: `file_paths: ["apis/users/get.xs", "apis/users/create.xs"]`

**What the issue was:** When calling `validate_xanoscript` with `file_paths=/Users/justinalbrecht/xs/linked-list-reversal/run.xs,/Users/justinalbrecht/xs/linked-list-reversal/function/reverse_linked_list.xs`, the MCP server split the string by characters instead of by commas. It tried to validate each character as a file path ("U", "s", "e", "r", "s", etc.).

**Why it was an issue:** The comma-separated format doesn't work as documented. I had to use the `directory` parameter instead to validate all files in the folder.

**Potential solution:** Fix the argument parsing to properly handle comma-separated file paths, or update the documentation to recommend using the `directory` parameter for multiple files.

---

## [2026-02-19 23:08 PST] - object[] type not supported

**What I was trying to do:** Define an input parameter as an array of objects: `object[] list`

**What the issue was:** XanoScript doesn't support the `object[]` syntax. The validation error said "Expecting --> { <-- but found --> 'list'" with a suggestion to "Use type[] instead of list".

**Why it was an issue:** The error message was confusing - it suggested using `type[]` but that's exactly what I was trying to do. I had to guess that `json` type might work for flexible object arrays.

**Potential solution:** 
1. Better error message explaining that `object[]` is not valid
2. Documentation about what types support array notation (`int[]`, `text[]`, etc.)
3. Clarify that `object` type doesn't support array notation and suggest using `json` instead

---

## [2026-02-19 23:10 PST] - Filter expressions need parentheses in comparisons

**What I was trying to do:** Check if an array is empty: `if ($input.list|count == 0)`

**What the issue was:** XanoScript requires parentheses around filter expressions when they're used in comparisons. The error was: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This syntax requirement isn't obvious from the quick reference. I had to wrap the entire filtered expression: `(($input.list|count) == 0)`.

**Potential solution:** 
1. Add this to the quickstart/common mistakes documentation
2. Provide an example in the syntax quick reference showing filter expressions in conditionals

---

## [2026-02-19 23:10 PST] - Conditional blocks only allow single if statement

**What I was trying to do:** Write a conditional block with two separate `if` statements to handle different edge cases:
```xs
conditional {
  if (condition1) { ... }
  if (condition2) { ... }
}
```

**What the issue was:** XanoScript only allows one `if` per conditional block, followed by `elseif` and `else`. The parser rejected the second `if`.

**Why it was an issue:** This wasn't clear from the documentation. I had to change the second `if` to `elseif` even though the conditions were independent checks, not mutually exclusive branches.

**Potential solution:** 
1. Document the conditional block structure more explicitly: `if → elseif → else`
2. Provide an example showing multiple conditions in one block
3. Consider allowing multiple independent `if` statements for guard clauses

---

## General Feedback

### Documentation
The quick reference is helpful but could use more examples of:
1. Complex input types (nested objects, arrays of objects)
2. Common patterns for guard clauses and early returns
3. Filter expressions in comparisons

### Validation Tool
The validation tool is very helpful with line/column numbers and suggestions. The main issue is the `file_paths` parameter parsing.

### Type System
It would be helpful to have a comprehensive list of:
1. Which types support array notation
2. How to represent dynamic/unstructured data (the answer seems to be `json`)
3. More examples of `object` type usage with nested schemas
