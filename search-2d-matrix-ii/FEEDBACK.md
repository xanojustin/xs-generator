# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 08:35 PST] - 2D Array Type Syntax Unclear

**What I was trying to do:** Define a 2D integer array as input for the matrix search function.

**What the issue was:** I initially tried `int[][] matrix` which is intuitive coming from Java/C++/TypeScript, but this syntax is not valid in XanoScript.

**Why it was an issue:** The error message was somewhat helpful but didn't tell me what the correct syntax should be: `Expecting token of type --> Identifier <-- but found --> '['`

**Potential solution:** 
- Document the correct pattern for multi-dimensional arrays clearly in the essentials guide
- Consider adding a specific error message for `int[][]` suggesting to use `json` type instead
- Or ideally, support `int[][]` syntax as syntactic sugar for 2D arrays

**Workaround found:** Looking at existing code (spiral-matrix exercise), I found that `json` type is used for 2D arrays.

---

## [2026-02-27 08:40 PST] - While Loop Inside Conditional Block

**What I was trying to do:** Implement a while loop to search the matrix.

**What the issue was:** I mistakenly placed the `while` loop inside a `conditional` block, thinking it would provide better scoping or structure.

**Why it was an issue:** The error messages were confusing:
- `conditional is missing the if statement`
- `Expecting --> } <-- but found --> 'while'`

These didn't clearly explain that `conditional` blocks only accept `if/elseif/else` statements.

**Potential solution:**
- Improve error message to explicitly state: "conditional blocks only support if/elseif/else statements, not while loops"
- Or consider allowing while loops inside conditional blocks (though this may not fit the language design)

**Workaround:** Move `while` loops directly inside `stack` blocks.

---

## [2026-02-27 08:30 PST] - MCP validate_xanoscript Path Expansion

**What I was trying to do:** Validate files using tilde (`~`) for home directory expansion.

**What the issue was:** The MCP tool doesn't expand `~/xs/...` paths, resulting in "File not found" errors.

**Why it was an issue:** Had to use full absolute paths (`/Users/justinalbrecht/xs/...`) which is less convenient.

**Potential solution:** 
- Add shell-style path expansion for `~` and environment variables in the MCP
- Or document that full paths are required

---

## General Notes

**Positive feedback:**
- The validation tool is very helpful and catches syntax errors precisely with line numbers
- The error recovery is good - one file's errors don't prevent validation of other files
- Having structured error output (JSON) is great for programmatic handling

**Suggested documentation improvements:**
- Add a "Common Patterns" section specifically for matrix/2D array problems
- Include a syntax comparison table showing "What you might expect" vs "XanoScript syntax"
- Document which constructs can be nested inside which other constructs
