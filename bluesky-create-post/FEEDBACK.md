# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 04:18 PST] - Validate Tool Requires 'code' Parameter Instead of 'file'

**What I was trying to do:**
Validate .xs files using the Xano MCP validate_xanoscript tool by passing a file path.

**What the issue was:**
The validate_xanoscript tool accepts a `code` parameter containing the actual source code, not a `file` parameter with a path. I initially tried passing `file="/path/to/file.xs"` but got the error: "Error: 'code' parameter is required".

**Why it was an issue:**
This was unexpected since many validation tools accept file paths. I had to read the file content and then pass it as the `code` parameter, which requires an extra step and makes the tool harder to use.

**Potential solution (if known):**
Either:
1. Accept both `file` and `code` parameters (mutually exclusive)
2. If `code` is required, clearly document this in the tool description
3. Provide an example in the MCP tool description showing the correct usage

---

## [2026-02-16 04:20 PST] - Filter Expression Requires Parentheses in Conditionals

**What I was trying to do:**
Check if an array has items using `$input.facets != null && $input.facets|count > 0` in a conditional block.

**What the issue was:**
The validator reported: "An expression should be wrapped in parentheses when combining filters and tests" on line 39 where I used `$input.facets|count > 0`.

I had to change it to `($input.facets|count) > 0` to satisfy the validator.

**Why it was an issue:**
This syntax requirement wasn't obvious from the documentation. The error message was helpful, but it's a subtle rule that's easy to forget. The quickstart documentation shows filter usage but doesn't emphasize this parenthesis requirement in conditionals.

**Potential solution (if known):**
1. Add a specific note in the "Common Mistakes" section of the quickstart docs about this
2. Consider if the parser could handle this more gracefully (auto-wrap or better inference)
3. Provide a linter/formatter that auto-fixes these issues

---

## [2026-02-16 04:15 PST] - Documentation for 'run' Topic is Excellent

**What I was trying to do:**
Create a run.job configuration for the Xano Job Runner.

**What worked well:**
The `xanoscript_docs({ topic: "run" })` documentation was comprehensive and clear. It included:
- Complete syntax for run.job and run.service
- Directory structure examples
- Properties table with required/optional indicators
- Multiple examples showing different use cases
- Best practices section

**Why it helped:**
I could immediately understand how to structure the run.xs file without trial and error. The examples showed exactly what I needed.

**Suggestion:**
Keep this level of detail for all topics. The run documentation is a gold standard.

---

## General Feedback on MCP Experience

**Strengths:**
1. The `xanoscript_docs` tool is well-organized with topic-based retrieval
2. Documentation is comprehensive and includes working examples
3. The validate_xanoscript tool provides specific line/column error locations

**Areas for Improvement:**
1. The validate tool should accept file paths OR have clearer parameter naming
2. Could benefit from a "quick reference" card for common syntax patterns
3. Would be helpful to have an "init" or "scaffold" tool that generates boilerplate for run jobs, functions, etc.
4. Consider adding auto-fix suggestions to validation errors where possible

**Overall:**
The MCP works well and the documentation quality is high. The main friction points are around the validation tool interface and some subtle syntax rules that could be better highlighted.
