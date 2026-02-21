# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 22:30 PST] - Pre-existing Code Validation

**What I was trying to do:** Validate the existing house-robber code that was already in the repository to check if it was syntactically correct.

**What the issue was:** No issue - all 3 files (run.xs, house-robber.xs, house-robber-test.xs) passed validation on the first attempt.

**Why it was a non-issue:** The code was already well-written and followed XanoScript conventions properly. This was a pleasant surprise.

**Note:** The main "issue" was that the exercise folder was incomplete - it was missing README.md, CHANGES.md, and FEEDBACK.md documentation files. The code itself was solid.

---

## [2025-02-20 22:38 PST] - run.job vs function Stack Block Confusion

**What I was trying to do:** Update run.xs to use a `stack` block with `function.run` to make the function call more explicit.

**What the issue was:** Validation failed with "The argument 'stack' is not valid in this context". I incorrectly assumed run.job could use a stack block like functions do.

**Why it was an issue:** The documentation for `run` configurations shows that `run.job` uses `main = { name: "...", input: {} }` syntax, but I conflated this with function syntax which uses `stack` blocks. These are different constructs with different valid properties.

**Resolution:** The original `main = { name: "...", input: {} }` syntax is correct for run.job. The validation error helped clarify that:
- `run.job` uses `main` property to specify which function to call
- `function` definitions use `stack` blocks for their logic
- You cannot mix these patterns

**Potential solution:** The documentation could include a more explicit "Common Mistakes" section highlighting that run.job cannot use stack blocks and must use the main property syntax.

---

## [2025-02-20 22:35 PST] - House Robber Algorithm Implementation

**What I was trying to do:** Review the dynamic programming implementation in house-robber.xs to understand the space-optimized approach.

**What the issue was:** The code uses a ternary expression with backticks for comparison: `(`$input.nums|first` >= `$input.nums|slice:1:2|first`) ? ...`. The backtick syntax for expressions within ternary operators wasn't immediately obvious.

**Why it was an issue:** The syntax `` `expression` `` for embedding expressions within ternary operators isn't prominently featured in the quickstart documentation. I had to infer its purpose from context.

**Potential solution:** The quickstart documentation could include a note about using backticks for expression grouping within ternary operators, or recommend using explicit conditional blocks instead for clarity.

---

## Overall Assessment

The Xano MCP worked well for this exercise:

**Strengths:**
- The `validate_xanoscript` tool was fast and gave clear results
- The `xanoscript_docs` tool provided comprehensive documentation
- The quick_reference mode was particularly useful for getting syntax patterns quickly

**Areas for improvement:**
- More explicit examples of run.job patterns (main vs stack)
- Better documentation of the backtick expression syntax
- Clearer guidance on when to use each pattern
