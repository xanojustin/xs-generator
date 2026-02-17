# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 01:50 PST] - HTML Entity Encoding Issue in XanoScript Files

**What I was trying to do:**
Create a XanoScript function file with comments using the `write` tool.

**What the issue was:**
When I initially wrote the file with comments containing `&&` (logical AND operator), the file was written with HTML entity encoding (`&amp;&amp;`). This caused the Xano MCP validator to fail with a cryptic error:

```
[Line 4, Column 1] Expecting --> function <-- but found --> '
' <--
```

The validator was seeing the HTML entity instead of the actual `&&` characters.

**Why it was an issue:**
This blocked validation and was confusing because the error message didn't clearly indicate the problem. I had to rewrite the file without comments first to isolate the issue, then narrow it down to the `&&` characters being HTML-encoded.

**Potential solution (if known):**
- The MCP validator could detect and report HTML entity encoding issues more clearly
- Documentation could warn about this encoding pitfall when using certain tools to write XanoScript files

---

## [2026-02-17 01:52 PST] - Validator Error Messages Could Be More Specific

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` tool.

**What the issue was:**
The initial error message was:
```
[Line 4, Column 1] Expecting --> function <-- but found --> '
' <--
```

This was misleading because:
1. Line 4 actually contained `function "upload_image" {`
2. The error said it found a single quote character instead
3. The real issue was HTML entity encoding of `&&` operators on a different line

**Why it was an issue:**
The error message sent me on a wild goose chase looking for encoding issues, hidden characters, and file format problems when the actual issue was HTML entity encoding elsewhere in the file.

**Potential solution (if known):**
- The parser could validate the entire file and report multiple errors
- Better error context showing the actual line content
- Detection of common encoding issues like HTML entities

---

## [2026-02-17 01:55 PST] - Documentation is Excellent and Well-Organized

**What I was trying to do:**
Learn XanoScript syntax to create a run job.

**What the issue was:**
No issue - the documentation is actually very well organized! The `xanoscript_docs` tool with different topics (run, quickstart, integrations/external-apis) provided exactly what I needed.

**Why it was helpful:**
- The quickstart topic had clear examples of common patterns
- The run topic showed the exact syntax for run.job
- The external-apis topic showed how to use api.request correctly
- Common mistakes section was particularly valuable

**Potential improvement:**
- Add more real-world examples for popular APIs
- Include a troubleshooting section for common validation errors

---

## Summary

The Xano MCP worked well overall. The main friction point was the HTML entity encoding issue which caused confusing validation errors. Once I rewrote the files without encoded characters, everything validated perfectly. The documentation is comprehensive and the validation tool is fast and helpful (when the encoding is correct).

Tools used successfully:
- `xanoscript_docs` - Excellent for learning syntax
- `validate_xanoscript` - Fast validation, helpful when files are clean

Overall development time: ~15 minutes (mostly spent debugging the encoding issue)
