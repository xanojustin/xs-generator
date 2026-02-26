# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 07:05 PST] - MCP Parameter Passing Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with file_paths parameter to validate multiple files at once

**What the issue was:** The MCP tool kept returning "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even when I was passing these parameters in JSON format

**Why it was an issue:** I couldn't figure out the correct syntax for passing parameters to the MCP tool. The documentation showed JSON format but mcporter CLI uses `key=value` syntax

**Potential solution:** 
- Document the mcporter CLI syntax more clearly in the tool description
- Show an example like: `mcporter call xano.validate_xanoscript file_path=/path/to/file.xs`
- Consider supporting both JSON and key=value formats consistently

---

## [2025-02-26 07:08 PST] - Input Block Validation Constraints Unclear

**What I was trying to do:** Add min/max constraints to input parameters (int n and int k) to enforce the problem constraints (1 <= n <= 9, 1 <= k <= n!)

**What the issue was:** Validation failed with errors like "The argument 'min' is not valid in this context" and "Expected value of `min` to be `null`"

**Why it was an issue:** I assumed input block fields would support the same validation constraints as other contexts (like API endpoints or table definitions), but they don't. The error message was confusing because it said the argument is not valid AND expected null.

**Potential solution:**
- Document which input validation constraints are available in which contexts
- Provide a clearer error message like "min/max constraints are not supported in function input blocks"
- Consider adding validation constraint support to function inputs for consistency

---

## [2025-02-26 07:10 PST] - Documentation Topic Content Identical

**What I was trying to do:** Get specific documentation for functions, quickstart, run, and syntax topics to understand different aspects of XanoScript

**What the issue was:** All four topics (functions, quickstart, run, syntax) returned identical content - the same generic overview with quick reference table and workspace structure

**Why it was an issue:** I couldn't get detailed syntax information for:
- How to write loops (while, foreach)
- Conditional syntax (if/elseif/else)
- Variable declaration and update patterns
- Function input/output patterns

I had to infer these from existing code examples instead.

**Potential solution:**
- Ensure each topic returns specific, relevant documentation
- The `functions` topic should detail function syntax, loops, conditionals
- The `run` topic should detail run.job syntax specifically
- The `syntax` topic should detail expression syntax, operators, filters

---

## [2025-02-26 07:12 PST] - No Documentation on Available Input Constraints

**What I was trying to do:** Find out what validation constraints are available for input fields (like min, max, optional, default, etc.)

**What the issue was:** Couldn't find documentation listing all available input field constraints and which contexts support them

**Why it was an issue:** Had to guess what constraints might work and rely on trial-and-error with the validator

**Potential solution:**
- Add a "types" or "input" topic to xanoscript_docs that lists all validation constraints
- Document context-specific constraint availability (function inputs vs API inputs vs table fields)

---

## Summary

Overall the Xano MCP is functional but the documentation system needs improvement:
1. CLI parameter syntax should be clearer
2. Documentation topics should return specific content, not generic overviews
3. Input validation constraints need better documentation
4. Error messages could be more helpful for unsupported features
