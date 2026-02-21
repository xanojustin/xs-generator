# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 04:32 PST] - Working directory affects MCP server connection

**What I was trying to do:** Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** When running `mcporter call xano validate_xanoscript` from different working directories, the MCP server would intermittently fail with "Unknown MCP server 'xano'" errors. The same command would work from the home directory but fail from within the `~/xs/permutations` directory.

**Why it was an issue:** This caused confusion and required switching directories to get consistent results. The error message suggests the server connection is lost when changing directories.

**Potential solution:** The MCP server connection should be directory-agnostic. If there's a configuration file or lock that's directory-dependent, it should be documented.

---

## [2025-02-21 04:35 PST] - Parentheses required for filter expressions in comparisons

**What I was trying to do:** Write a while loop and if condition that compare the result of a filter expression to a value

**What the issue was:** The validator rejected:
- `while ($stack|count > 0)`
- `if ($curr_perm|count == $input.nums|count)`

With error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The syntax is intuitive without parentheses, and the documentation examples don't clearly show this requirement. It took two validation cycles to identify and fix.

**Potential solution:** 
1. The quickstart documentation could include a clear example of this pattern
2. The error message could show the corrected code: `Did you mean: while (($stack|count) > 0)`
3. Allow the intuitive syntax and auto-wrap internally

---

## [2025-02-21 04:33 PST] - Array element access syntax unclear

**What I was trying to do:** Access array elements by index in the permutations function

**What the issue was:** The syntax `$input.nums[$idx]` for array access wasn't clearly documented in the quickstart or functions topics. I assumed it worked like other languages but wasn't 100% sure.

**Why it was an issue:** Had to make an educated guess about syntax instead of having clear documentation.

**Potential solution:** Add a "Common Patterns" section to the quickstart showing:
- Array element access: `$array[$index]`
- Array length: `$array|count`
- Array iteration with index

---
