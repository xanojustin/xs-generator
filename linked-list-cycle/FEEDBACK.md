# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 20:05 PST] - Issue: Unclear run.xs syntax for input objects

**What I was trying to do:** Create a run.xs file that passes an array of objects to a function

**What the issue was:** The validation error said "Expecting object {} but found '{'" when I had commas between objects in an array. I discovered that in XanoScript:
- Arrays of primitives use commas: `[1, 2, 3]`
- Arrays of objects use newlines, NOT commas:
  ```
  [
    { value: 1, next: 2 }
    { value: 3, next: 4 }
  ]
  ```

**Why it was an issue:** This is inconsistent and confusing - different syntax for arrays of primitives vs arrays of objects. The error message didn't help identify the actual problem.

**Potential solution:** Better error message like "Arrays of objects should not use commas as separators" or consistent syntax (always use commas or always use newlines).

---

## [2025-02-21 20:08 PST] - Issue: while loop syntax not documented in quick_reference

**What I was trying to do:** Use a while loop for Floyd's cycle detection algorithm

**What the issue was:** The quick_reference documentation for syntax doesn't mention `while` loops at all. I had to find an existing example to discover:
- while conditions must be wrapped in backticks: ``while (`$condition`)``
- while loops require an `each { ... }` block inside them

**Why it was an issue:** Without examples, I tried standard syntax like `while (!$detected)` which failed validation.

**Potential solution:** Add while loop syntax to the quick_reference documentation, or have the validation suggest using backticks for expressions.

---

## [2025-02-21 20:10 PST] - Issue: Inline comments not allowed

**What I was trying to do:** Add comments inline with code like `var $slow { value = 0 }  // Start at head`

**What the issue was:** XanoScript doesn't allow inline comments - they must be on their own lines. The error was "Expecting newline but found '/'."

**Why it was an issue:** Most programming languages allow inline comments. This is a surprising limitation.

**Potential solution:** Either support inline comments or provide a clearer error message like "Comments must be on their own line, not inline with code."

---

## [2025-02-21 20:12 PST] - Issue: mcporter call with multiple file_paths fails

**What I was trying to do:** Validate multiple files at once using comma-separated paths

**What the issue was:** The command `mcporter call xano.validate_xanoscript file_paths=/path/one,/path/two` treated each character as a separate file path, resulting in errors like "File not found: U", "File not found: s", etc.

**Why it was an issue:** The tool schema says `file_paths` accepts an array, but the CLI doesn't properly parse comma-separated values into an array.

**Potential solution:** Fix the CLI parsing for array parameters, or document the correct format (maybe JSON array or repeated flags).

---

## [2025-02-21 20:15 PST] - Issue: Input block formatting requirements

**What I was trying to do:** Define function inputs on one line like `object[] nodes { description = "..." }`

**What the issue was:** The validation failed with "expecting at least one iteration starting with newline." I had to reformat to:
```
object[] nodes {
  description = "..."
}
```

**Why it was an issue:** The error message is cryptic - "iteration" isn't clear in this context. Also inconsistent with other languages.

**Potential solution:** Better error message like "Input field descriptions must be on a new line" or allow one-line format.

---

## [2025-02-21 20:18 PST] - Issue: Object property syntax inconsistent

**What I was trying to do:** Understand when to use `:` vs `=` for key-value pairs

**What the issue was:** In run.xs input blocks, use `name: "value"` (colon)
In function input blocks, use `description = "value"` (equals)
This inconsistency is confusing.

**Why it was an issue:** Had to trial-and-error to figure out the correct syntax for each context. Validation errors weren't helpful.

**Potential solution:** Standardize on one syntax, or have the validator suggest the correct symbol when the wrong one is used.

---

## Summary

The main pain points were:
1. **Documentation gaps:** while loops, array syntax not fully documented
2. **Inconsistent syntax:** `:` vs `=`, commas vs newlines in arrays
3. **Cryptic error messages:** Many errors don't clearly indicate the actual problem
4. **CLI tool issues:** file_paths parameter parsing broken

Overall, having example files in ~/xs/ was crucial - I referenced them frequently to understand the correct syntax. The MCP validation tool works well once you know the syntax, but getting there requires a lot of trial and error.
