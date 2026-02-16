# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 19:22 PST] - Missing Type Documentation for Arrays

**What I was trying to do:**
Create a function input parameter that accepts an array of strings (for candidate labels in zero-shot classification).

**What the issue was:**
I initially used `list candidate_labels?` which is intuitive but wrong. The correct syntax is `text[] candidate_labels?`. The validation error was:
```
[Line 10, Column 5] Expecting --> } <-- but found --> 'list' <--
```

This error message was confusing because it suggested a closing brace was expected, making me think I had a syntax error in my block structure, when really `list` isn't a valid type keyword.

**Why it was an issue:**
The quickstart documentation shows `list candidate_labels?` in one place but the types documentation clarifies arrays use `text[]` syntax. The error message didn't indicate that `list` was an invalid type.

**Potential solution:**
1. Improve error messages to say something like "'list' is not a valid type. Did you mean 'text[]'?"
2. Add a more prominent note in the quickstart that arrays use `type[]` notation
3. Consider aliasing `list` to mean array for better discoverability

---

## [2026-02-15 19:23 PST] - Boolean Type Name Confusion

**What I was trying to do:**
Define a boolean input parameter with a default value.

**What the issue was:**
I used `boolean wait_for_model? = true` which seemed logical, but the correct type name is `bool` not `boolean`.

**Why it was an issue:**
The documentation shows `bool` in the types table, but as someone used to TypeScript/JavaScript where it's `boolean`, this is an easy mistake. The validation error would have appeared on my next validation attempt.

**Potential solution:**
1. Accept both `bool` and `boolean` as aliases
2. Add a clear "Common Gotchas" section to the quickstart
3. Include this in the input validation error hints

---

## [2026-02-15 19:20 PST] - validate_xanoscript Tool Requires Code String

**What I was trying to do:**
Validate multiple .xs files by passing file paths to the validate_xanoscript tool.

**What the issue was:**
I initially tried to pass `{ "files": [...] }` but the tool requires `{ "code": "file content as string" }`. This means validating multiple files requires multiple MCP calls instead of a batch operation.

**Why it was an issue:**
Most validation tools accept file paths. Having to read files and pass content as strings adds extra steps and complexity.

**Potential solution:**
1. Support both `code` (string) and `file_path` (path to read) parameters
2. Support `files` parameter for batch validation with a results array
3. Return a structured JSON response with file-by-file results

---

## [2026-02-15 19:18 PST] - Documentation Discovery

**What I was trying to do:**
Find the correct syntax for input parameters with optional values and defaults.

**What the issue was:**
The quickstart shows basic patterns but the full type syntax (like `text[]` for arrays, `?` for optional, `?=default` for defaults) is spread across different documentation sections.

**Why it was an issue:**
I had to read through multiple documentation topics (quickstart, types, run) to find all the patterns I needed. It wasn't immediately clear where to look for specific syntax questions.

**Potential solution:**
1. Create a single "Input Parameters Cheat Sheet" that shows all variations
2. Add a "Syntax Quick Reference" at the top of the main documentation
3. Include more inline examples in the quickstart patterns

---

## Overall Assessment

The MCP server worked well for getting documentation and validating code. The main friction points were:

1. **Type syntax discoverability** - Arrays and booleans have non-obvious syntax
2. **Error message quality** - Validation errors could be more helpful with suggestions
3. **Batch validation** - Would be nice to validate multiple files at once

The documentation is comprehensive once you find the right section. A single-page "Common Patterns" reference would significantly improve the developer experience.
