# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 03:05 PST] - Inline Comments Not Supported

**What I was trying to do:** Write a XanoScript function with inline comments (comments at the end of lines with code) to document the direction values.

**What the issue was:** The validator threw a parse error:
```
[Line 11, Column 35] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

**Why it was an issue:** I expected inline comments to work like in most programming languages (JavaScript, Python, etc.). The error message was cryptic and didn't clearly explain that inline comments aren't supported - it just said it expected a NewlineToken.

**Potential solution (if known):** 
1. The documentation in `essentials` mentions "XanoScript only supports `//` for comments" but doesn't explicitly state that inline comments (end-of-line comments) are NOT supported.
2. The error message could be improved to say something like: "Inline comments are not supported. Comments must be on their own line."
3. Consider adding a "Common Mistakes" section about comments if inline comments are a frequent issue.

---

## [2026-03-02 03:00 PST] - MCP Tool Discovery

**What I was trying to do:** Call the Xano MCP to get documentation and validate XanoScript code.

**What the issue was:** Initially I tried using incorrect syntax: `mcporter call xanoscript_docs --tool xanoscript_docs` and `mcporter call xano --tool xanoscript_docs --input '{"topic": "essentials"}'`

**Why it was an issue:** The mcporter CLI syntax wasn't immediately clear. The correct syntax is `mcporter call xano.xanoscript_docs topic=essentials` (using `server.tool` format with key=value args).

**Potential solution (if known):** 
1. The mcporter help text shows examples but it took a moment to understand the pattern.
2. Consider making the error messages more helpful when users use `--input` or other incorrect flag patterns.

---

## [2026-03-02 03:10 PST] - Validation Success

**What I was trying to do:** Validate multiple files at once using the validate_xanoscript tool.

**What the issue was:** No issues - the validation tool worked well once I figured out the correct syntax for passing multiple file paths.

**Why it was helpful:** The batch validation with `file_paths=["path1", "path2"]` was convenient and the error messages included line/column numbers and helpful suggestions.
