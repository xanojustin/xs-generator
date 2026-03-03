# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 01:35 PST] - File Path Handling

**What I was trying to do:** Validate the newly created XanoScript files using the MCP `validate_xanoscript` tool.

**What the issue was:** The MCP tool doesn't expand the tilde (`~`) character in file paths. When I passed `~/xs/longest-palindromic-subsequence/run.xs`, it returned "File not found" errors.

**Why it was an issue:** This required me to use absolute paths (`/Users/justinalbrecht/xs/...`) instead of the more convenient tilde notation that works in most shell commands.

**Potential solution (if known):** 
- The MCP could expand `~` to the user's home directory before attempting to access files
- Or the documentation could explicitly mention that absolute paths are required

---

## [2025-03-03 01:38 PST] - First Try Success

**What I was trying to do:** Write and validate the complete Longest Palindromic Subsequence solution in XanoScript.

**What the issue was:** No issues! Both the `run.xs` and `function/solve.xs` files passed validation on the first attempt.

**Why it was an issue:** N/A - This is positive feedback that the Xano MCP validation is working well and the documentation was clear enough to get the syntax right on the first try.

**Positive notes:**
- The `xanoscript_docs` topic system provided excellent guidance on:
  - Function structure with `input`, `stack`, and `response` blocks
  - Run job syntax with `main` property
  - Loop constructs (`for`, `each`, `while`)
  - Array manipulation with filters like `get`, `set`, `append`
  - String operations with `substr`
  - Conditional logic patterns
- The distinction between block properties (`=`) and object literals (`:`) was well-documented
- The reserved variable names list helped avoid naming conflicts

---

## [2025-03-03 01:40 PST] - Array Manipulation Complexity

**What I was trying to do:** Implement a 2D dynamic programming table in XanoScript for the LPS algorithm.

**What the issue was:** Working with 2D arrays (arrays of arrays) requires careful handling. The `set` filter returns a new array rather than modifying in place, so I had to use patterns like:
```xs
var $row { value = ($dp|get:$i)|set:$j:$new_val }
var $dp { value = $dp|set:$i:$row }
```

**Why it was an issue:** This functional approach to array updates is different from imperative languages where you might do `dp[i][j] = value` directly. It took some thought to structure the nested updates correctly.

**Potential solution (if known):**
- A `var.update` variant for array elements could be helpful, though the current pattern is consistent with XanoScript's functional approach
- More examples of multi-dimensional array manipulation in the docs would be valuable

---

## Overall Experience

The Xano MCP and documentation performed well for this exercise:
- ✅ Clear syntax documentation
- ✅ Helpful error messages during validation
- ✅ Good examples in the docs for common patterns
- ⚠️ Path handling could be more flexible
- ⚠️ Complex array operations could use more examples

