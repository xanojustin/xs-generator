# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 19:10 PST] - Successful First-Pass Validation

**What I was trying to do:** Create a complete XanoScript coding exercise with a run job and function implementing BFS for shortest path in a binary matrix.

**What the issue was:** No issues encountered! Both the run.xs and function/shortest_path.xs files passed validation on the first attempt.

**Why it was an issue:** N/A - this is a positive feedback entry documenting that the MCP validation worked correctly and the documentation was sufficient to write valid XanoScript code.

**Potential solution (if known):** The quick reference documentation from `xanoscript_docs` was very helpful. Having the existing `number-of-islands` example as a reference for grid traversal patterns was invaluable for understanding:
- How to structure nested while loops for 2D array traversal
- How to use `array.push`, `array.pop`, `array.shift` for queue operations
- How to create and update visited matrices using `var.update` with the `set` filter
- Proper use of `$input.grid` syntax for accessing input parameters

---

## [2026-02-25 19:08 PST] - Documentation Request: Array/List Operations

**What I was trying to do:** Implement a BFS queue using arrays with enqueue (push to back) and dequeue (pop from front) operations.

**What the issue was:** Initially unclear about the specific array operation functions available in XanoScript. Wasn't sure if there was a dedicated queue data structure or if I should use array operations.

**Why it was an issue:** BFS requires efficient queue operations. I needed to know:
- How to add to the end of an array (enqueue)
- How to remove from the front of an array (dequeue)
- Whether `array.shift` was the correct operation for dequeue

**Potential solution (if known):** The existing examples (like number-of-islands) showed `array.push` and `array.pop` for stack operations. For BFS queue, I inferred `array.shift` would dequeue from the front. Having a clear documentation section on array operations with examples for common patterns (stack, queue) would be helpful.

---

## [2026-02-25 19:08 PST] - Documentation Clarification: 8-Directional Movement Syntax

**What I was trying to do:** Define the 8 possible movement directions for the BFS (including diagonals).

**What the issue was:** Wanted to confirm the correct syntax for defining a constant array of arrays (the direction vectors).

**Why it was an issue:** I used `var $directions { value = [[-1,-1], ...] }` syntax but wanted to ensure this was valid XanoScript for a constant array definition within a function.

**Potential solution (if known):** The syntax worked correctly. However, having more examples of complex array initialization in the quick reference would help build confidence when writing similar patterns.
