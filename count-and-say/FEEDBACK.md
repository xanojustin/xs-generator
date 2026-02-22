# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 10:05 PST] - Inline Comments Cause Parsing Errors

**What I was trying to do:** Write a count-and-say function with inline comments to explain the algorithm

**What the issue was:** The XanoScript parser failed when encountering inline comments (comments at the end of a line) inside `each` blocks. The error message was:
```
[Line 51, Column 49] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

The code that caused the error:
```xs
var $j { value = $len } // Break out of inner while
```

**Why it was an issue:** The parser error was confusing because:
1. The error message doesn't clearly indicate that comments are the problem
2. The error suggests looking for NewlineToken but found `/`, which is cryptic
3. The suggestion about using "text" instead of "string" was irrelevant to the actual issue

**Potential solution (if known):** 
1. Improve the parser to either:
   - Support inline comments consistently throughout the language
   - Provide a clearer error message like "Inline comments not allowed inside blocks - move comment to separate line"
2. Update documentation to explicitly note this limitation
3. The MCP validation tool could detect this pattern and warn about it

---

## [2026-02-22 10:00 PST] - MCP Tool Parameter Format Unclear

**What I was trying to do:** Call the `validate_xanoscript` MCP tool with multiple file paths

**What the issue was:** The documentation showed `file_paths?: string[]` as a parameter, but passing it as JSON or comma-separated string both failed:
- JSON format `{"file_paths": ["...", "..."]}` didn't work
- Comma-separated `file_paths="path1,path2"` was interpreted as individual characters

**Why it was an issue:** Lost time figuring out the correct format. Eventually discovered that:
- Using `directory` parameter works well for validating multiple files
- The `file_path` (singular) parameter works for single files

**Potential solution (if known):** 
1. Provide clearer examples in the MCP tool documentation showing the exact command format
2. Consider supporting JSON input for complex parameters
3. The error message when using wrong format was confusing - it showed each character as a separate "file not found" error

---

## [2026-02-22 10:00 PST] - Documentation Topics Return Generic Content

**What I was trying to do:** Get specific XanoScript documentation for run jobs and functions

**What the issue was:** Calling `xanoscript_docs({ topic: "run" })` and `xanoscript_docs({ topic: "functions" })` both returned the same generic README content instead of specific documentation for those topics.

**Why it was an issue:** Had to rely on existing code examples to understand the syntax patterns instead of having proper reference documentation

**Potential solution (if known):** 
1. Ensure topic-specific documentation is properly indexed and returned
2. If certain topics don't have specific content, return an error or indication that generic content is being shown

---

## General Observations

### Positive
- The MCP validation tool is fast and gives line/column numbers for errors
- The suggestion feature (💡 Suggestion) is helpful when relevant
- Directory validation works well for batch checking files

### Areas for Improvement
1. Error messages could be more human-readable for common syntax mistakes
2. Documentation could use more code examples, especially for complex patterns like nested loops
3. Clarify comment placement rules in the syntax documentation
