# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 23:08 PST] - Issue: 2D Array Type Not Supported

**What I was trying to do:** Define a 2D array (matrix) input for the celebrity problem where `knows_matrix[i][j]` indicates if person i knows person j.

**What the issue was:** I assumed XanoScript would support `int[][] matrix` syntax like TypeScript or Java, but this caused a parse error: `Expecting token of type --> Identifier <-- but found --> '['`.

**Why it was an issue:** Without 2D array types, I had to use `json` type which provides less type safety and no schema validation for the nested structure.

**Potential solution (if known):** 
- Document clearly that multi-dimensional arrays should use `json` type
- Consider adding support for `type[][]` syntax or provide an alternative like `array of array of int`

---

## [2025-02-25 23:15 PST] - Issue: Filters on Int Types in Input Block

**What I was trying to do:** Add validation to ensure `n >= 1` using `filters = min:1` on an `int` type in the input block.

**What the issue was:** The validation failed with two errors:
1. `The argument 'filters' is not valid in this context`
2. `Expecting: Expected a null but found: 'min'`

**Why it was an issue:** The documentation shows `filters=min:0` examples for int types, but apparently this doesn't work inside an input block for objects/functions. I had to move the validation to a `precondition` in the stack block instead.

**Potential solution (if known):**
- Clarify in documentation where `filters` can and cannot be used
- The quickstart shows `int quantity filters=min:0|max:100` but this might only work in certain contexts (tables? apis?)
- Consistent support for filters across all input contexts would be helpful

---

## [2025-02-25 23:05 PST] - Positive: Good Error Messages

**What I was trying to do:** Validate my XanoScript files.

**What went well:** The validation tool provided clear error messages with line and column numbers, plus the actual code at that location. This made debugging much faster.

**Why it was helpful:** The error messages like `Expecting token of type --> Identifier <-- but found --> '['` immediately told me what syntax was expected vs what I provided.

---

## [2025-02-25 23:00 PST] - Documentation Discovery

**What I was trying to do:** Learn XanoScript syntax from scratch.

**What went well:** The `xanoscript_docs` tool with topic-based access is excellent. Being able to call `xanoscript_docs({ topic: "functions" })` or `xanoscript_docs({ topic: "run" })` made it easy to find relevant information.

**Why it was helpful:** The topic-based organization meant I didn't have to parse through a massive document - I could get just the sections I needed for my current task.

---

## General Feedback

The Xano MCP and XanoScript have a good foundation, but there are some rough edges around:
1. Type system limitations (no multi-dimensional arrays)
2. Inconsistent filter support across contexts
3. Some trial-and-error required to discover valid syntax patterns

The validation tool is the saving grace - without it, development would be much harder.
