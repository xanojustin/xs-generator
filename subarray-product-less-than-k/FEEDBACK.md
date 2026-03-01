# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 06:35 PST] - Run Job Syntax Confusion

**What I was trying to do:** Create a run.xs file that calls a function with test inputs

**What the issue was:** I initially wrote the run.xs using `stack { ... }` syntax similar to functions, but run.job requires completely different syntax with `main = { name: "...", input: {...} }`

**Why it was an issue:** The error message `Expecting: one of these possible Token sequences... but found: '{'` wasn't very helpful in understanding that I needed to use a completely different structure. I had to look at existing examples to figure out the correct pattern.

**Potential solution (if known):** 
- Better error messages that suggest "run.job requires a name and main block, see documentation"
- A link to the run.job documentation in the error message

---

## [2026-03-01 06:38 PST] - While Loop Backtick Syntax

**What I was trying to do:** Write a while loop with a compound condition: `while (($product >= $input.k) && ($left <= $right))`

**What the issue was:** The parser gave error `Expecting --> each <-- but found --> '\n'` which was confusing. I discovered that complex conditions in while loops need to be wrapped in backticks.

**Why it was an issue:** The error message didn't clearly indicate that backticks were needed. It just said it expected `each` but found a newline, which made me think the issue was with the loop body structure, not the condition syntax.

**Potential solution (if known):**
- Error message could suggest: "Complex conditions in while loops must be wrapped in backticks, e.g., `while (`$condition`)`"
- Documentation could have a more prominent note about this requirement

---

## [2026-03-01 06:40 PST] - Object Literal Syntax Inconsistency

**What I was trying to do:** Write `input: {}` inside the run.job main block

**What the issue was:** I initially wrote `input = {}` (using equals) because that's how variable assignment works elsewhere in XanoScript, but run.job main blocks use colon syntax like object literals.

**Why it was an issue:** The inconsistency between `var $x { value = ... }` (equals) and `main = { input: {} }` (colon) is confusing. It's not clear when to use which syntax.

**Potential solution (if known):**
- Documentation could have a side-by-side comparison showing: "Inside function/stack blocks use `=` for assignment, inside object literals use `:` for key-value pairs"
- The run.job `main` block is conceptually an object literal, so the colon syntax makes sense, but this isn't immediately obvious

---

## [2026-03-01 06:42 PST] - No Tool to List Existing Exercises

**What I was trying to do:** Find which exercises haven't been implemented yet

**What the issue was:** I had to manually `ls` the directory and visually scan through 300+ folders to find one that was empty/incomplete. The `subarray-product-less-than-k` folder existed but was empty.

**Why it was an issue:** It's time-consuming and error-prone to manually check each folder. I might have missed some incomplete implementations.

**Potential solution (if known):**
- A tool or command that lists incomplete exercises (folders missing run.xs or function files)
- Or a status command that shows validation status of all exercises

---

## [2026-03-01 06:45 PST] - Overall Documentation Discovery

**What I was trying to do:** Learn XanoScript syntax for this exercise

**What the issue was:** The `xanoscript_docs` tool has comprehensive documentation, but finding the right topic requires some trial and error. I needed to call it multiple times with different topics (run, functions, syntax, essentials, array-filters) to piece together what I needed.

**Why it was an issue:** While the docs are thorough, there's no single "getting started for developers coming from other languages" guide that covers the most common patterns.

**Potential solution (if known):**
- A "quick start for algorithm exercises" topic that covers: function structure, run.job structure, loops, conditionals, and array operations
- Or a curated list of "most common patterns" with examples

---

## General Feedback

**What worked well:**
- The `validate_xanoscript` tool is very helpful with specific line/column error reporting
- The MCP provides comprehensive documentation via `xanoscript_docs`
- Once I figured out the patterns, the syntax is clean and readable

**What could be improved:**
- Error messages could be more actionable (suggest fixes, not just report errors)
- A single "algorithm exercise template" document would save time
- Consider standardizing syntax (equals vs colon) or making it clearer when each is used
