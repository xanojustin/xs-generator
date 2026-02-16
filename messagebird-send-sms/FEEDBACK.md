# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-16 06:50 PST - Reserved Variable Name Error

**What I was trying to do:**
Create a XanoScript function that returns a response object containing SMS sending results.

**What the issue was:**
I initially used `$response` as a variable name inside the function stack:
```xs
var $response {
  value = { success: true, ... }
}
```

The validator correctly caught this error: `'$response' is a reserved variable name and should not be used as a variable.`

**Why it was an issue:**
This blocked validation and required me to rename the variable to `$sms_result`. While the error message was clear, I had to re-read the documentation to understand that `$response` is reserved for the function's output only (in the `response = ...` line at the end).

**Potential solution (if known):**
The documentation mentions this, but perhaps the quickstart could highlight this more prominently as a "Common Mistake" since it's an intuitive name developers would reach for.

---

## 2025-02-16 06:47 PST - MCP Tool Discovery

**What I was trying to do:**
Find and use the xanoscript_docs tool to get documentation before writing code.

**What the issue was:**
The xanoscript_docs command was not in my PATH even though `@xano/developer-mcp` was installed globally. I had to use `mcporter call xano.xanoscript_docs` instead of calling it directly.

**Why it was an issue:**
It took extra time to figure out the correct invocation pattern. The task instructions mentioned calling `xanoscript_docs` directly which didn't work.

**Potential solution (if known):**
- Add a note in documentation that mcporter is the preferred way to call MCP tools
- Or create wrapper scripts for common tools like `xanoscript_docs`

---

## 2025-02-16 06:45 PST - Documentation Format

**What I was trying to do:**
Understand the exact syntax for run.job definitions.

**What the issue was:**
The documentation is thorough but finding specific examples required reading through multiple topic sections (quickstart, run, integrations).

**Why it was an issue:**
It took several MCP calls to get all the information needed: one for the overview, one for run-specific docs, one for quickstart patterns, and one for integrations (API requests).

**Potential solution (if known):**
Consider adding a "complete example" topic that includes a full working run job with:
- run.xs
- function definition
- API request pattern
- Error handling

This would reduce the number of documentation calls needed.

---

## General Observations

1. **Validation is helpful** - The validate_xanoscript tool caught my reserved variable issue immediately. This is much better than finding out at runtime.

2. **Documentation quality** - The docs are comprehensive and well-structured once you find what you need.

3. **No syntax highlighting issues** - Writing XanoScript was straightforward with the clear examples.

4. **MC Porter integration works well** - Once I figured out the mcporter call pattern, everything worked smoothly.
