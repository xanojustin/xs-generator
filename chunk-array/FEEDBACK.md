# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 23:00 PST] - Successful Exercise Creation

**What I was trying to do:** Create a new XanoScript coding exercise (chunk-array) following the required structure with a run job calling a function.

**What the issue was:** No issues encountered. The implementation passed validation on the first attempt.

**Why it was an issue:** N/A - This was a successful exercise creation.

**Observations:**
- The `run.job` syntax was straightforward following the documentation
- The `function` structure with `input`, `stack`, and `response` blocks was clear
- Array manipulation using `var`, `var.update`, and `while` loops worked as expected
- The `math.add` operation for incrementing counters was useful
- Array concatenation with `~` operator worked correctly for building chunks

---

## [2025-02-27 23:00 PST] - Documentation Clarity

**What I was trying to do:** Understand how to structure the chunk array algorithm using XanoScript.

**What the issue was:** Had to carefully read the documentation to understand:
1. How to declare and update variables properly
2. How to use `while` loops for index-based iteration
3. How to build arrays incrementally

**Why it was an issue:** The documentation is comprehensive but requires careful reading to piece together patterns like:
- `var $name { value = ... }` for declaration
- `var.update $name { value = ... }` for updates
- Using `~` for array concatenation

**Potential solution (if known):** 
- More complete algorithmic examples in the documentation would help
- A "cookbook" of common patterns (building arrays, nested loops, etc.) would be valuable

---

## [2025-02-27 23:00 PST] - MCP Tool Usage

**What I was trying to do:** Validate the XanoScript files using the MCP server.

**What the issue was:** Initially struggled with the parameter format for `validate_xanoscript`. The error message indicated that one of 'code', 'file_path', 'file_paths', or 'directory' was required, but I was passing `files` instead of `file_paths`.

**Why it was an issue:** Had to check the tool schema to discover the correct parameter name is `file_paths` (not `files`).

**Potential solution (if known):** 
- The error message could be more helpful by showing the correct parameter names
- Example usage in the initial prompt would help
