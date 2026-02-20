# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 01:00 PST] - Initial Setup

**What I was trying to do:** Set up the Xano MCP and get documentation for XanoScript syntax to implement a matrix transpose exercise.

**What the issue was:** The `xanoscript_docs` tool returned generic documentation regardless of which topic I requested. I tried `quickstart`, `functions`, and `run` topics, but all returned the same generic documentation about XanoScript constructs without specific syntax details for:
- How to write `run.job` blocks
- The exact syntax for `function` definitions
- How to use loops, conditionals, and array operations

**Why it was an issue:** Without specific syntax documentation, I had to rely on reading existing implementations in the `~/xs/` directory to understand the correct XanoScript syntax patterns. This worked but was slower and less authoritative than having proper documentation.

**Potential solution (if known):** The MCP should return topic-specific documentation that includes:
- Syntax reference for each construct type (function, run.job, query, etc.)
- Examples of common patterns (loops, conditionals, array operations)
- A language reference guide with all available statements and their syntax

---

## [2025-02-20 01:05 PST] - Multi-dimensional Array Types Not Supported

**What I was trying to do:** Define a function input parameter for a 2D matrix (array of arrays) using `int[][] matrix` type declaration.

**What the issue was:** XanoScript does not support multi-dimensional array type declarations like `int[][]`. The validation error was:
```
[Line 7, Column 10] Expecting token of type --> Identifier <-- but found --> '[' <--
```

**Why it was an issue:** For matrix operations and other problems requiring 2D arrays, there's no clear way to declare the type. I had to use `json` type instead, which loses type safety and documentation clarity.

**Potential solution (if known):** 
1. Support multi-dimensional array syntax like `int[][]` or `int[] []`
2. Document the recommended approach for 2D arrays (using `json` type is the workaround)
3. Provide a `matrix` or `array[]` generic type for nested arrays

---

## [2025-02-20 01:10 PST] - MCP Configuration Path Issues

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool.

**What the issue was:** The MCP server runs from a different working directory context, so relative file paths don't work. I initially tried:
- `run.xs` - Failed with "File not found"
- `function/matrix_transpose.xs` - Failed with "File not found"

Had to use absolute paths like `/Users/justinalbrecht/xs/matrix-transpose/run.xs` for validation to work.

**Why it was an issue:** It's not intuitive that relative paths don't work. Most CLI tools handle relative paths relative to the current working directory.

**Potential solution (if known):**
1. Document that absolute paths are required
2. Or have the MCP resolve relative paths from the current working directory
3. Add a `cwd` parameter to specify the working directory for path resolution



