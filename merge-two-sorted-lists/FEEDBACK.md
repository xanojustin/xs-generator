# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 02:05 PST] - Successful First Attempt

**What I was trying to do:** Create a complete XanoScript coding exercise for "Merge Two Sorted Lists" following the required architecture (run.job calling a function).

**What the issue was:** No issues encountered! Both the run.xs and function/merge_two_sorted_lists.xs files validated successfully on the first attempt.

**Why it was an issue:** N/A - no issues.

**Potential solution (if known):** The documentation from xanoscript_docs was comprehensive and clear. Key helpful sections:
- Function structure (input/stack/response pattern)
- Run job structure (main = { name: ..., input: ... })
- Common patterns from quickstart guide (while loops, conditionals, variable handling)
- Type names (text, int, json, bool vs string, integer, etc.)

---

## [2026-02-22 02:05 PST] - Syntax Learning Observations

**What I was trying to do:** Implement the merge algorithm using linked list representation from existing exercises.

**What the issue was:** Understanding how to properly handle linked lists in XanoScript since there's no native linked list type. Had to infer the pattern from existing exercises (linked-list-reversal).

**Why it was an issue:** The documentation doesn't explicitly explain the linked list representation pattern used in coding exercises. I had to examine an existing exercise to understand:
- Linked lists are represented as arrays of objects with `value` and `next` properties
- `next` is an integer index or null for the tail
- A separate `head_index` tracks where the list starts

**Potential solution (if known):** Consider adding a brief section to the quickstart or functions documentation about common data structure representations for coding exercises (linked lists, trees, etc.). This would help developers creating similar exercises without needing to examine existing code.

---

## [2026-02-22 02:05 PST] - Filter Usage Pattern

**What I was trying to do:** Access object properties and manipulate arrays using filters.

**What the issue was:** Remembering to use `$obj|get:"key"` syntax for object property access in contexts where dot notation might not work consistently.

**Why it was an issue:** The syntax `$input.list1[$p1]|get:"value"` is a bit verbose compared to typical JavaScript object access. It's documented in the quickstart but easy to forget the exact pattern.

**Potential solution (if known):** The documentation is clear - just noting that the `get` filter pattern is essential for linked list node access in these types of exercises. A small reminder example in the common patterns section would help.

---

## Summary

This exercise was successfully completed with no validation errors on the first attempt. The existing documentation was sufficient, and examining the linked-list-reversal exercise provided the necessary context for linked list representation patterns.