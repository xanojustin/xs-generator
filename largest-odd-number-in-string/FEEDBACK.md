# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 00:03 PST] - Successful Implementation

**What I was trying to do:** Implement a XanoScript coding exercise (largest-odd-number-in-string) with a run job and function.

**What happened:** Both files passed validation on the first attempt. No errors encountered.

**Notes:**
- The XanoScript documentation was clear and helpful
- The `run.job` syntax with `main = { name: "...", input: { ... } }` worked as documented
- Function structure with `input`, `stack`, and `response` was straightforward
- The while loop and conditional syntax worked correctly
- String filters like `strlen`, `substr`, and `to_int` functioned as expected

## Documentation Feedback

**Positive:**
- The `xanoscript_docs` tool with topic parameter is well-organized
- The quickstart guide covers common mistakes which helps avoid errors
- Examples in the functions and run job documentation were clear

**Potential Improvements:**
- Could use more examples of string manipulation patterns
- The `foreach` vs `while` loop decision tree could be clearer
