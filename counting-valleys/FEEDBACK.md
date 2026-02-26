# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 06:02 PST] - MCP Tool Parameter Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The first attempt used `"files"` as the parameter name, but the MCP expects `"file_paths"`. The error message was: `Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required`

**Why it was an issue:** This required trial and error to figure out the correct parameter name. The documentation at `xanoscript_docs` doesn't include MCP tool signatures, only XanoScript language documentation.

**Potential solution:** The MCP could:
1. Include tool parameter documentation in the `xanoscript_docs` output
2. Accept multiple common aliases like `"files"`, `"paths"`, `"file_paths"`
3. Provide a more helpful error message listing the valid parameter names

---

## [2025-02-26 06:03 PST] - Successful Implementation

**What I was trying to do:** Create a complete XanoScript exercise (run.job + function) for the "counting valleys" problem

**What went well:** 
- The `xanoscript_docs` topic system was helpful for finding relevant documentation
- Having clear examples in the quickstart guide made it easy to understand the function structure
- The validation tool worked well once the correct parameters were used
- Both files passed validation on the first attempt

**Why it worked:**
- The documentation clearly shows the difference between `run.job` (has `main`) and `run.service` (has `pre`)
- The `function` structure with `input`, `stack`, and `response` blocks is well-documented
- Common mistakes section in quickstart helped avoid pitfalls like using `elseif` instead of `else if`

---