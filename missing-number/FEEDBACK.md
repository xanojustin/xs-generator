# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 00:32 PST] - Missing iterate construct in documentation

**What I was trying to do:** Iterate over an array to sum its elements

**What the issue was:** I assumed XanoScript had an `iterate` construct like many other languages. The error message was clear about the syntax error but the suggestion about using "int" instead of "integer" was not relevant to the actual problem.

**Why it was an issue:** I had to look at existing implementations in `~/xs/` to discover that XanoScript uses `while` loops with index-based array access (`$array[$i]`) rather than iterator-style loops.

**Potential solution (if known):** 
- The quickstart or syntax documentation could include a section on "How to iterate over arrays" showing the while-loop pattern
- A comparison table of "If you're used to X in other languages, do Y in XanoScript" would be helpful
- The `iterate` keyword could potentially be added as syntactic sugar for the while-loop pattern

---

## [2026-02-21 00:32 PST] - Documentation examples needed for array operations

**What I was trying to do:** Understand how to sum elements of an integer array

**What the issue was:** The general documentation showed basic patterns but didn't have specific examples for common array operations like summing, finding max/min, or filtering.

**Why it was an issue:** Had to grep through existing exercises to find examples in `find-duplicates/function/find_duplicates.xs` which showed the `while` + index pattern.

**Potential solution (if known):** 
- Add a "Common Array Patterns" section to the quickstart docs with examples for: summing, finding max/min, filtering, mapping
- Include example: "Sum all elements in an int[] array" as a basic pattern

---
