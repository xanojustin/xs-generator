# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 10:05 PST] - No Issues Encountered

**What I was trying to do:** Create a "Jewels and Stones" coding exercise with a run job and function that counts how many stones are also jewels.

**What the issue was:** No issues encountered. Both the `function/jewels_and_stones.xs` and `run.xs` files passed validation on the first attempt.

**Why it was an issue:** N/A — no blockers.

**Potential solution (if known):** N/A

---

## [2025-02-24 10:00 PST] - Documentation Was Clear and Helpful

**What I was trying to do:** Understand XanoScript syntax for creating functions and run jobs.

**What the issue was:** None — the `xanoscript_docs` tool provided excellent documentation. I used:
- `topic=quickstart` for common patterns and mistakes to avoid
- `topic=functions` for function structure and calling conventions
- `topic=run` for run.job syntax
- `topic=syntax` for filters and operators

**Why it was an issue:** N/A

**Potential solution (if known):** The documentation is comprehensive. One minor enhancement could be more examples of string manipulation (like splitting strings into character arrays), but I was able to infer the `split:""` pattern from the available filters.

---

## General Observations

**What worked well:**
1. The `validate_xanoscript` tool with `directory` parameter made batch validation effortless
2. The quickstart documentation's "Common Mistakes" section was invaluable — I avoided several pitfalls:
   - Using `$input.field` instead of bare variables
   - Using proper type names (`text` not `string`, `int` not `integer`)
   - Wrapping filter expressions in parentheses when used with operators
   - Using `elseif` not `else if`

3. The `mode=quick_reference` option for syntax docs was efficient for context window management

**Suggestions for improvement:**
1. Consider adding a specific example for string-to-character-array conversion using `split:""` — this is a common pattern in coding exercises
2. The foreach loop syntax for iterating over arrays could benefit from a clearer example showing how to get both the item (no index built-in)

**Overall experience:** Smooth and straightforward. The documentation quality made this exercise much easier than previous attempts with other languages.
