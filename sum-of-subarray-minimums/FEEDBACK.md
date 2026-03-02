# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-03-02 02:33 PST - Missing random filter

**What I was trying to do:** Create a "random-pick-with-weight" exercise that requires generating random numbers

**What the issue was:** I attempted to use `$total_weight|random` to generate a random number, but the `random` filter doesn't exist in XanoScript

**Why it was an issue:** This blocked my first exercise choice. I had to switch to a different exercise (sum-of-subarray-minimums) that doesn't require randomness

**Potential solution (if known):** 
- Document available math/utility filters more prominently
- Consider adding a `random` filter for generating random integers within a range
- Could also be useful for testing scenarios

---

## 2025-03-02 02:45 PST - Filter expression parentheses requirement

**What I was trying to do:** Write expressions using filters like `$stack|count > 0` and `$stack|last - $i`

**What the issue was:** The validator rejected expressions like:
- `while (($stack|count > 0) && ...)` 
- `if ($stack|count == 0)`
- `value = $stack|last - $i`

With error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** Had to wrap ALL filter expressions in parentheses, even when it seemed redundant:
- `($stack|count)` instead of `$stack|count`
- `($stack|last)` instead of `$stack|last` when used in arithmetic

This was confusing because `$input.arr|count` worked without parentheses in some contexts but failed in others.

**Potential solution (if known):**
- The error message could be clearer about WHERE to add parentheses
- Could suggest: "Wrap the entire filter expression in parentheses: `($var|filter)`"
- Documentation could show more examples of filter usage in complex expressions

---

## 2025-03-02 02:30 PST - MCP parameter passing

**What I was trying to do:** Call the `validate_xanoscript` tool with file_paths parameter

**What the issue was:** Initial attempts with `file_paths:='["path1", "path2"]'` failed with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** The parameter passing syntax wasn't intuitive. Had to use `--args '{"directory": "/path"}'` format instead.

**Potential solution (if known):**
- Document the correct mcporter call syntax more clearly
- Provide examples for each parameter type in the MCP docs

---

## General Notes

**What worked well:**
- The validation tool provides helpful line/column numbers
- The suggestions (like "Use 'int' instead of 'integer'") are useful
- Once I understood the parentheses pattern, validation was straightforward

**Areas for improvement:**
1. **Documentation discoverability:** Had to call the docs multiple times to find relevant info
2. **Filter reference:** A complete list of available filters with examples would be helpful
3. **Error message clarity:** Some errors could suggest the exact fix needed
