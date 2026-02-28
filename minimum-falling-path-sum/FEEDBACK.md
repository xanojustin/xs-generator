# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 12:35 PST] - 2D Array Type Declaration

**What I was trying to do:** Declare a 2D integer array as input to represent a matrix.

**What the issue was:** I initially used `int[][] matrix` which is standard syntax in many languages (TypeScript, Java, C++), but XanoScript doesn't support this syntax.

**Why it was an issue:** The validation error was:
```
[Line 9, Column 10] Expecting token of type --> Identifier <-- but found --> '['
```

This error message doesn't clearly indicate that 2D array types aren't supported. It just says it found `[` when expecting an identifier.

**Potential solution (if known):** 
1. The MCP documentation could mention that multi-dimensional arrays should use `json` type
2. The validation error could be more helpful: "2D array types like `int[][]` are not supported. Use `json` type for nested arrays."
3. Add an example in the documentation showing how to declare matrix inputs

**How I fixed it:** I looked at existing exercises (`search-2d-matrix`) and saw they use `json` type for 2D arrays.

---

## [2026-02-28 12:36 PST] - MCP Documentation Format

**What I was trying to do:** Get detailed syntax documentation from the MCP to understand XanoScript patterns.

**What the issue was:** When I called `xanoscript_docs` with specific topics like `functions` or `essentials`, I received the same general overview documentation instead of detailed topic-specific content.

**Why it was an issue:** The documentation index mentions specific topics like:
- `functions` - "Reusable function stacks, async, loops"
- `essentials` - "Common patterns, quick examples, mistakes to avoid"

But calling `mcporter call xano xanoscript_docs '{"topic": "functions"}'` returned the same general overview.

**Potential solution (if known):**
1. Either the topic-specific documentation isn't being served correctly
2. Or the MCP should return an error/warning if the topic doesn't have specific content beyond the overview
3. Consider including actual detailed syntax examples in topic responses

**Workaround used:** I read existing exercise implementations from the `~/xs/` directory to understand patterns.

---

## [2026-02-28 12:37 PST] - MCP Tool Discovery

**What I was trying to do:** Find the correct syntax for calling `validate_xanoscript`.

**What the issue was:** Initially tried `mcporter call xano validate_xanoscript '{"files": [...]}'` but got an error about required parameters.

**Why it was an issue:** The parameter name is `file_paths` (plural) not `files`, and the tool expects a specific format.

**Potential solution (if known):**
1. The error message could list the available parameter options
2. Consider adding examples to the tool description showing proper usage

**Final working syntax:**
```bash
mcporter call xano.validate_xanoscript file_paths='["/path/to/file1.xs", "/path/to/file2.xs"]'
```

---

## General Notes

### What worked well:
- The validation tool provides clear line/column error locations
- The suggestion feature ("Use 'int' instead of 'integer'") is helpful
- Having existing exercises in `~/xs/` to reference is invaluable

### Suggestions for MCP improvement:
1. Add a `get_examples` tool that returns example XanoScript patterns for common use cases
2. Consider adding `int[][]` as an alias for `json` if it's commonly used for matrices
3. Add validation warnings for common mistakes (like using `integer` instead of `int`)

---
