# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 15:35 PST] - First Attempt Success

**What I was trying to do:** Create a complete XanoScript coding exercise for the Longest Continuous Increasing Subsequence problem

**What the issue was:** No issues encountered! Both files validated successfully on the first attempt.

**Why it was (not) an issue:** This was my first time implementing a more complex algorithm in XanoScript with:
- Array access by index using `slice:first` pattern
- While loops with counter incrementation
- Nested conditionals
- Math operations on variables

**What worked well:**
1. The `xanoscript_docs` function provided clear examples for function structure, loops, and conditionals
2. The `slice:($i - 1):$i|first` pattern worked correctly for array element access
3. Variable update syntax (`var.update`) was intuitive
4. The validation tool gave immediate feedback

**Potential improvements to documentation:**
1. Array indexing: Would be helpful to have a dedicated example showing how to access array elements by index (the slice+first pattern isn't immediately obvious for newcomers)
2. Common patterns: A "common array patterns" section showing iteration styles would be valuable

---

## [2026-02-23 15:36 PST] - MC Porter CLI Quoting

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter

**What the issue was:** Shell quoting issues when passing JSON arrays on the command line. The command `mcporter call xano.validate_xanoscript file_paths='["...", "..."]'` failed with zsh parsing errors.

**Why it was an issue:** Couldn't batch validate files in a single call

**Potential solution (if known):** 
- Document recommended shell escaping patterns for complex parameters
- Or provide a simpler comma-separated string alternative for file_paths

**Workaround:** Validated files individually using `file_path` parameter instead
