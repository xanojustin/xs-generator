# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 01:05 PST] - Successful First-Time Validation

**What I was trying to do:** Create a complete "Delete and Earn" coding exercise with run job and function

**What the issue was:** No issues encountered - both files passed validation on the first attempt

**Why it was a positive experience:** The existing exercises in `~/xs/` provided excellent reference patterns. The XanoScript documentation from `xanoscript_docs` was comprehensive and accurate.

**What worked well:**
1. The `quickstart` and `cheatsheet` topics provided clear, actionable patterns
2. Existing exercise files (fizzbuzz, house-robber) served as reliable templates
3. The `validate_xanoscript` tool gave fast, clear feedback
4. Common mistakes section in documentation prevented typical errors

**Potential improvements:** None for this specific exercise - the development experience was smooth.

---

## [2025-02-26 01:05 PST] - Documentation Quality Note

**What I was trying to do:** Understand the run.job structure

**What the experience was:** The run.job documentation was harder to find than other constructs. I had to look at existing example files to understand the `main = { name: "...", input: {...} }` structure.

**Why it could be improved:** While the examples worked well, having explicit run.job documentation in the `xanoscript_docs` would help new developers.

**Potential solution:** Add a dedicated `run.job` or `run` topic to `xanoscript_docs` that covers:
- The `run.job` construct syntax
- The `main` field structure
- How to pass inputs to functions
- Any other run.* constructs (run.service, etc.)

---

## General Observations

**Strengths of XanoScript:**
1. Filter pipeline syntax (`|filter:arg`) is intuitive for data transformations
2. The type system with `text`, `int`, `bool`, `decimal` is clear
3. Reserved variable names prevent common naming conflicts
4. `var` vs `var.update` distinction makes mutation explicit

**Patterns that felt natural:**
- Using `foreach` with `each as $item` for array iteration
- Building objects with `|set` and `|merge` filters
- Using filters like `|get:"key":default` for safe property access
- The ternary operator for simple conditionals

**No issues to report** - this exercise implementation went smoothly from start to finish.
