# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 14:46 PST] - No Issues Encountered - Development Success

**What I was trying to do:**
Create a Google Sheets integration run job that appends a row to a spreadsheet using the Google Sheets API.

**What the issue was:**
No issues encountered. All files validated successfully on first attempt.

**Why it was an issue:**
N/A - Everything worked smoothly.

**Potential solution (if known):**
The Xano MCP and documentation worked exactly as expected. The `xanoscript_docs` tool provided clear, comprehensive documentation that allowed me to write valid XanoScript code without trial and error.

---

## [2026-02-14 14:46 PST] - Documentation Clarity - api.request params naming

**What I was trying to do:**
Make an HTTP POST request to the Google Sheets API.

**What the issue was:**
Initially confusing - the `api.request` uses `params` for the request body (not query parameters), which is counterintuitive but well-documented.

**Why it was an issue:**
Minor cognitive load - I had to pause and read the docs carefully. The docs explicitly call this out as "counterintuitive but consistent across XanoScript" which was helpful.

**Potential solution (if known):**
Consider adding an alias like `body` for `params` in future versions, or keep the explicit warning in docs as it currently exists.

---

## [2026-02-14 14:46 PST] - Positive Feedback - Excellent Documentation Structure

**What I was trying to do:**
Learn XanoScript syntax for run jobs, functions, and HTTP requests.

**What the issue was:**
None - the documentation is exceptionally well-organized with the topic-based retrieval system.

**Why it was an issue:**
N/A

**Potential solution (if known):**
The quick_reference mode is perfect for AI agents - concise enough to fit in context windows while providing actionable syntax examples. The full mode provides excellent detail when needed. Keep this dual-mode approach.

---

## Summary

This run job development session was smooth and successful. The Xano MCP tools worked correctly:

- `xanoscript_docs` provided comprehensive, well-structured documentation
- `validate_xanoscript` correctly validated both files with no false positives or negatives
- Documentation topics are logically organized (run, functions, syntax, integrations)
- The quick_reference mode is ideal for maintaining context window efficiency

The Google Sheets API integration was straightforward to implement using the `api.request` statement with proper error handling for various HTTP status codes.
