# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 07:35 PST] - File Path Parsing Issue with file_paths Parameter

**What I was trying to do:** Validate multiple XanoScript files by passing a comma-separated list of file paths to the `validate_xanoscript` tool.

**What the issue was:** When using the `file_paths` parameter with comma-separated values like:
```
file_paths="/path/to/file1.xs,/path/to/file2.xs"
```

The MCP server parsed each character as a separate file path, resulting in errors like:
- "File not found: U"
- "File not found: s"
- "File not found: e"
- etc.

**Why it was an issue:** This made the `file_paths` parameter unusable for batch validation. The tool tried to validate 122 "files" (which was actually individual characters from the path strings), all of which failed.

**Potential solution (if known):** 
1. The MCP server should properly parse comma-separated file paths as an array of strings, not as individual characters
2. Alternatively, the documentation could be updated to recommend using the `directory` parameter instead when validating multiple files
3. Or support a different delimiter format that doesn't get parsed incorrectly

**Workaround used:** I successfully used the `directory` parameter instead, which validated all `.xs` files in the directory recursively without issues.

---

## [2025-02-21 07:35 PST] - Successful First-Attempt Validation

**What I was trying to do:** Write a complete XanoScript run job and function for decimal-to-binary conversion.

**What the issue was:** None - both files passed validation on the first attempt.

**Why it matters:** This indicates the XanoScript syntax documentation is clear enough to write correct code without trial and error. The patterns for:
- Function definition with input/output blocks
- Run job with main function invocation
- Control flow (conditional, while loops)
- Variable manipulation (text.prepend, math.div)

were all well-documented and worked as expected.

**Positive feedback:** The quick_reference mode of `xanoscript_docs` was particularly helpful for getting the basic structure right without being overwhelmed by details.
