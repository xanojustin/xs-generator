# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 17:16 PST] - Directory Path Expansion Issue

**What I was trying to do:**
Validate all .xs files in the plaid-get-balance directory using the validate_xanoscript tool with the `directory` parameter.

**What the issue was:**
When using `directory=~/xs/plaid-get-balance`, the MCP returned "No .xs files found in directory: ~/xs/plaid-get-balance". Similarly, when using `file_path=~/xs/plaid-get-balance/run.xs`, it returned "File not found".

**Why it was an issue:**
The tilde (~) path expansion wasn't being handled by the MCP. I had to use the full absolute path `/Users/justinalbrecht/xs/plaid-get-balance/` for validation to work.

**Potential solution (if known):**
The MCP should expand shell shortcuts like `~` to the user's home directory before attempting file operations, or the documentation should clarify that absolute paths are required.

---

## [2026-02-17 17:15 PST] - Learning Curve on XanoScript Syntax

**What I was trying to do:**
Write proper XanoScript code for the Plaid integration, including API requests, conditionals, and database operations.

**What the issue was:**
Even with the documentation, there were several syntax nuances that weren't immediately clear:
1. Using `elseif` instead of `else if` (common mistake)
2. Using `params` for request body in api.request (counterintuitive naming)
3. String concatenation with `~` operator
4. Proper use of parentheses around filtered expressions

**Why it was an issue:**
I had to carefully read the quickstart documentation multiple times to avoid common mistakes. Without the docs explicitly calling out these differences from other languages, I would have made many syntax errors.

**Potential solution (if known):**
The MCP could potentially include a "lint" or "suggest" mode that warns about common syntax patterns from other languages (like suggesting `elseif` when `else if` is detected).

---

## [2026-02-17 17:14 PST] - Documentation Navigation

**What I was trying to do:**
Find the specific documentation needed for creating a run job with API calls and database operations.

**What the issue was:**
The documentation is organized by topic, but it wasn't immediately clear which topics I needed to consult. I ended up calling:
- `topic=run` - for run job structure
- `topic=quickstart` - for common patterns
- `topic=functions` - for function syntax
- `topic=integrations/external-apis` - for API requests

**Why it was an issue:**
I had to make multiple documentation calls to gather all the necessary information. A single "run job with API integration" consolidated guide would have been more efficient.

**Potential solution (if known):**
Consider adding a "recipes" or "cookbook" documentation topic that provides complete, copy-pasteable examples for common scenarios like "API integration run job with database logging".

---

## [2026-02-17 17:17 PST] - Validation Tool Success

**What I was trying to do:**
Validate the .xs files after writing them.

**What the issue was:**
None! The validation tool worked perfectly once I used absolute paths. The error messages were clear and helpful.

**Positive feedback:**
The validate_xanoscript tool is excellent - it quickly identified valid files and provided clear success messages. The ability to validate individual files, multiple files, or entire directories is very useful.

---

## Summary

Overall, the Xano MCP worked well for this task. The main friction points were:
1. Path handling (needs absolute paths)
2. Documentation scattered across multiple topics
3. Syntax differences from other languages require careful attention

The validation tool is a standout feature that made the development cycle much faster.
