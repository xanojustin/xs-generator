# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 21:32 PST] - Run Job Syntax Confusion

**What I was trying to do:** Create a run job that executes test cases for the largest BST subtree exercise

**What the issue was:** I completely misunderstood the `run.job` syntax. I wrote it like a function with `description`, `stack`, and `response` properties, but run.job has a completely different structure with only `main` and `env` properties.

**Why it was an issue:** The validation error messages were clear about what was wrong (`'description' is not valid in this context`), but I didn't have the correct mental model for how run jobs work. I assumed they were like functions that you write logic in, when actually they're just configuration files that point to functions.

**Potential solution (if known):** 
- The `xanoscript_docs` for the `run` topic could benefit from a clearer "Common Mistake" section showing the wrong vs right way to write run.job
- A side-by-side comparison: "Don't write this:" vs "Write this instead:"

---

## [2025-03-03 21:35 PST] - Object Equality/Comparison Limitation

**What I was trying to do:** In the solution, I needed to find child nodes in an array by comparing objects. The algorithm requires post-order traversal where we process children before parents.

**What the issue was:** XanoScript doesn't seem to have object identity comparison or a way to reference objects by pointer/reference. I had to work around this by doing a linear search through an array and comparing objects with `==`, which feels inefficient (O(n) per lookup, leading to O(n²) overall).

**Why it was an issue:** For a binary tree algorithm, this is a significant performance hit. In other languages, we'd use pointers/references or object identity checks.

**Potential solution (if known):**
- Documentation on how to properly handle object references in XanoScript
- A `find_index` or `index_of` filter for arrays that takes a value to find
- Clarification on what `==` does for objects (deep equality vs reference equality)

---

## [2025-03-03 21:37 PST] - While Loop Variable Scope Confusion

**What I was trying to do:** Use a `while` loop with a counter variable that gets updated each iteration

**What the issue was:** The `while` loop in XanoScript requires an `each` block inside it. I initially tried to write `while ($i >= 0) { var.update $i ... }` but learned that while must contain `each { }`.

**Why it was an issue:** The documentation mentions this, but it's easy to miss. The error message when you forget `each` might not be immediately clear about what's missing.

**Potential solution (if known):**
- A more prominent example in the essentials documentation showing the full while loop structure
- Better error message when `each` is missing from a while loop

---

## General Observations

### Good:
- The `validate_xanoscript` tool is fast and gives helpful line/column error messages
- The `xanoscript_docs` tool with `mode=full` provides comprehensive examples
- The quick reference mode is useful once you know what you're looking for

### Could Be Improved:
- The directory structure for run jobs vs functions could be more clearly documented in the essentials
- More examples of complete, working run job + function combinations
- A "Getting Started with Exercises" guide that walks through the run.job -> function -> solution pattern
