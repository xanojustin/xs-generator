# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 13:05 PST] - Successful First-Pass Validation

**What I was trying to do:** Create a complete XanoScript coding exercise for "Subtree of Another Tree" with a run job and two functions (main function + helper).

**What happened:** All three files (`run.xs`, `function/is_subtree.xs`, `function/is_same_tree.xs`) passed validation on the first attempt with no errors.

**Why this was notable:** This is the first exercise I've built where all files passed on the first try. This suggests:
1. The XanoScript documentation from `xanoscript_docs` is becoming clearer
2. The patterns from previous exercises (particularly the binary tree handling patterns) are well-established
3. The common pitfalls are now better understood

**What worked well:**
- Using `json` type for tree structures allows flexible nested object handling
- The `get:"key":null` pattern with null default for safe property access
- The recursive function call pattern via `function.run` is clean and works well
- Early returns with `return { value = ... }` make guard clauses readable

**Potential improvements for the MCP (none critical):**
- No issues encountered in this exercise

---

## [2026-02-24 13:05 PST] - Documentation Note

**What I was trying to do:** Reference the correct syntax for object property access and null handling.

**What worked well:**
- The `get` filter with default value syntax: `$obj|get:"key":null` is clearly documented
- The distinction between nullable (`text?`) and optional (`name?`) in input blocks is well explained

**Suggestion:** Consider adding more examples of recursive data structure handling (like trees) in the quickstart guide, as this is a common interview question pattern.
