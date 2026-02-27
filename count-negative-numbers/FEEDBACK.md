# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 13:05 PST] - 2D Array Type Syntax

**What I was trying to do:** Define a function input parameter for a 2D integer matrix (grid)

**What the issue was:** I tried to use `int[][] grid` syntax which is common in many languages, but XanoScript doesn't support multi-dimensional array type declarations.

**Why it was an issue:** The validation error was: `Expecting token of type --> Identifier <-- but found --> '[' <--`

This error message doesn't clearly indicate that multi-dimensional arrays aren't supported or suggest the correct alternative. I had to look at the types documentation to discover that `json` type should be used for complex nested structures.

**Potential solution:** 
1. Improve error message to suggest using `json` type for multi-dimensional arrays
2. Add explicit documentation about 2D arrays in the types topic
3. Consider supporting `int[]` for 1D and suggesting `json` for 2D+ in validation hints

---

## [2025-02-27 13:08 PST] - Conditional Syntax Discovery

**What I was trying to do:** Write an `if` statement to handle the empty grid edge case

**What the issue was:** I wrote:
```xs
if ($row_count == 0) {
  response = 0
  return
}
```

But XanoScript requires `if` statements to be wrapped in a `conditional` block.

**Why it was an issue:** The validation error was: `Expecting --> } <-- but found --> 'if' <--`

This error message is confusing - it suggests a missing closing brace rather than indicating that `if` statements must be inside `conditional` blocks. I had to look at existing examples (fizzbuzz) to understand the correct pattern.

**Potential solution:**
1. Improve parser error messages to detect standalone `if` statements and suggest wrapping in `conditional`
2. Add a "Common Mistakes" section in the essentials documentation about conditional syntax
3. Consider supporting standalone `if` statements for simpler logic (if syntactically feasible)

---

## [2025-02-27 13:10 PST] - Expression Backtick Syntax

**What I was trying to do:** Write complex expressions like `$row < $row_count` and `$col + 1`

**What the issue was:** Initially I wrote expressions directly without backticks, but complex expressions in conditionals and variable updates need to be wrapped in backticks.

**Why it was an issue:** This wasn't immediately clear from the initial documentation. I had to infer this from the fizzbuzz example which shows:
```xs
if (`$i % 15 == 0`) {
```

**Potential solution:**
1. Add explicit documentation about when backticks are required vs optional
2. Include more examples showing expression syntax in the essentials documentation
3. Consider a linter warning when complex expressions aren't wrapped in backticks

---

## [2025-02-27 13:00 PST] - MCP Tool Parameter Format

**What I was trying to do:** Call the `validate_xanoscript` tool using mcporter

**What the issue was:** Initially tried various formats:
- `mcporter call xano validate_xanoscript '{"file_path":"..."}'`
- `mcporter call xano validate_xanoscript file_path=value`

Neither worked. The correct format is:
```
mcporter call xano.validate_xanoscript --args '{"file_path":"..."}'
```

**Why it was an issue:** The error message was: `Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required` even when I was passing parameters.

**Potential solution:**
1. Better documentation in the MCP about how to call tools via mcporter CLI
2. Improve error messages to show what parameters were actually received vs expected
3. Support multiple calling conventions (with/without --args, dot vs space separator)

---

## Summary

Overall the development experience was manageable once I understood the patterns, but the learning curve was steep due to:
1. Limited error message guidance
2. Need to reference existing examples to understand correct syntax
3. Some non-obvious syntax requirements (conditional blocks, backticks)

The validation tool is valuable once you get the syntax right, but getting there required some trial and error.
