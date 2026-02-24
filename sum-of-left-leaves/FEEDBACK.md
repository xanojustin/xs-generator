# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 21:00 PST] - Initial Setup

**What I was trying to do:** Create a XanoScript coding exercise for "Sum of Left Leaves" binary tree problem

**What the issue was:** Had to figure out the correct mcporter syntax for calling xanoscript_docs with parameters

**Why it was an issue:** The documentation showed `xanoscript_docs({ topic: "functions" })` but mcporter uses `mcporter call xano.xanoscript_docs topic=functions` format

**Potential solution (if known):** The MCP documentation could include example CLI commands showing the proper parameter passing syntax

---

## [2026-02-23 21:05 PST] - Validation Success

**What I was trying to do:** Validate the XanoScript files using the Xano MCP

**What the issue was:** None - validation passed on first attempt

**Why it was an issue:** N/A - no issues encountered

**Positive feedback:** The validation tool worked perfectly and provided clear output showing 2 valid files with 0 invalid. The directory parameter made it easy to validate all files at once.

---

## Summary

Overall experience was very smooth:
1. Documentation via xanoscript_docs was comprehensive and well-organized
2. The function and run.job syntax was clear from the examples
3. Validation passed on first attempt with no errors
4. The Xano MCP integration via mcporter worked reliably

The exercise implements an iterative DFS solution for finding the sum of left leaves in a binary tree, demonstrating:
- json input type for nested tree structures
- while loops for iterative traversal
- The `get` filter for safe object property access with defaults
- The `merge` filter for array operations (stack push)
- The `slice` filter for array operations (stack pop)
