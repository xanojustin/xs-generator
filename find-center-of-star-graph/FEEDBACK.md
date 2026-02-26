# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 22:30 PST] - Issue: 2D Array Type Syntax Not Supported

**What I was trying to do:** Declare a 2D array input parameter for the function (array of integer pairs representing graph edges)

**What the issue was:** Used `int[][] edges` syntax which is common in other languages, but XanoScript doesn't support multi-dimensional array type declarations

**Error message:**
```
[Line 4, Column 10] Expecting token of type --> Identifier <-- but found --> '[' <--
💡 Suggestion: Use "type[]" instead of "array"
```

**Why it was an issue:** The error message was helpful in pointing out that `type[]` is the correct format, but it didn't explicitly mention that multi-dimensional arrays like `int[][]` are not supported. I had to infer that `json` type should be used instead for nested array structures.

**Potential solution (if known):** 
- The documentation could explicitly state that multi-dimensional arrays are not supported in input types
- Suggest using `json` type for nested arrays
- Or consider adding support for `int[][]` syntax as it's a common pattern for matrix/2D data structures

---

## [2026-02-25 22:30 PST] - Positive Feedback: MCP Validation Tool

**What I was trying to do:** Validate the XanoScript code before committing

**What went well:** The `validate_xanoscript` tool worked excellently:
- Clear error messages with line/column positions
- Helpful suggestions ("Use 'type[]' instead of 'array'")
- Shows exactly which code caused the error
- Batch validation of multiple files at once

**Why it helped:** The validation caught the syntax error immediately and pointed me to the exact line. The suggestion guided me toward the correct fix even though it wasn't perfect for the 2D array case.

**Potential improvement:** The MCP could suggest `json` type when it detects multi-dimensional array syntax like `int[][]`
