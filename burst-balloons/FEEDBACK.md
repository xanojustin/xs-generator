# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 12:32 PST] - File Path Resolution in validate_xanoscript

**What I was trying to do:** Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** The tool returned "File not found" when using relative paths like `run.xs` or `function/burst_balloons.xs`, even when executed from the correct working directory with `cd ~/xs/burst-balloons && ...`

**Why it was an issue:** Had to use absolute paths (`/Users/justinalbrecht/xs/burst-balloons/run.xs`) for validation to work, which is less convenient and not documented clearly.

**Potential solution (if known):** Either:
1. Document that absolute paths are required
2. Make the tool respect the working directory of the shell command
3. Add a `working_directory` parameter to the validate_xanoscript tool

---

## [2025-03-02 12:33 PST] - response vs return Confusion in Conditionals

**What I was trying to do:** Implement early return for an edge case (empty array) inside a conditional block

**What the issue was:** Initially wrote `response = 0` inside the conditional block, which caused a parse error: "Expecting } but found 'response'"

**Why it was an issue:** The error message was a bit cryptic - it wasn't immediately clear that `response` cannot be used inside conditional blocks. The docs mention `return` can be used for early return, but the distinction between `response` (end-of-function only) and `return` (early exit) could be more prominent.

**Potential solution (if known):** 
1. A clearer error message like "'response' cannot be used inside conditional blocks. Use 'return' for early returns."
2. In the "essentials" docs, add a specific section about "Early Returns" that contrasts `return` vs `response` usage

---

## [2025-03-02 12:35 PST] - MCP Tool Worked Well Overall

**Positive feedback:**
- The `xanoscript_docs` tool with topic selection is excellent - very comprehensive documentation
- The validation error messages include line numbers and column numbers which is helpful
- The `validate_xanoscript` tool caught the syntax error correctly

**General observation:**
The documentation at `xanoscript_docs({ topic: "essentials" })` has a section on "Early Return" showing `return { value = null }` syntax, but it's somewhat buried. Making this more prominent or adding it to a "Common Patterns" section at the top would help.
