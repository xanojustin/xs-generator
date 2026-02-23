# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-22 22:30 PST - No Issues Encountered

**What I was trying to do:** Create a XanoScript coding exercise for the "Largest Number" problem

**What the issue was:** No issues encountered - both the run.xs and function/largest_number.xs files passed validation on the first attempt

**Why it was an issue:** N/A - smooth development experience

**Potential solution (if known):** N/A

---

## Notes on Implementation

The Xano MCP `xanoscript_docs` tool provided excellent documentation that made it straightforward to implement this exercise:

1. The `run.job` syntax was clear from the documentation
2. The `function` structure with `input`, `stack`, and `response` blocks was well-documented
3. The bubble sort algorithm was implementable using `while` loops and `conditional` blocks
4. The `var.update` syntax for modifying variables in loops worked as expected

One minor observation: Accessing array elements by index (`$sorted[$j]`) worked without issues, though the documentation could be more explicit about this syntax.

Overall, the MCP validation tool worked correctly and caught no errors in the initial implementation.
