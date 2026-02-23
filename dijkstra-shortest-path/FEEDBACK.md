# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-22 19:33 PST - Blank Lines Between Comments and Code Not Allowed

**What I was trying to do:** Create a XanoScript run job and function with comments explaining the code.

**What the issue was:** The validator rejected files with the error:
```
[Line 3, Column 1] Expecting --> run <-- but found --> '' <--
```

This happened because I had a blank line between the header comments and the actual code:
```xs
// Comment line 1
// Comment line 2

run.job "Name" {  // This line caused the error - blank line before it
```

**Why it was an issue:** This is a surprising constraint. Most programming languages allow blank lines between comments and code. The error message was also cryptic - saying it found a single quote character when it was actually a blank line.

**Potential solution:**
1. Allow blank lines between comments and code constructs for better readability
2. Improve the error message to say something like "Unexpected blank line before 'run.job' - blank lines not allowed between comments and construct definitions"

---

## 2026-02-22 19:35 PST - Smart Quote Character Caused Issues

**What I was trying to do:** Write "Dijkstra's Algorithm" in comments.

**What the issue was:** The smart quote character (') caused parsing issues. The validator complained about unexpected characters.

**Why it was an issue:** This is a common copy-paste issue where word processors or macOS replace straight quotes with smart quotes. The error message didn't clearly indicate this was the problem.

**Potential solution:**
1. Normalize smart quotes to straight quotes during parsing
2. Provide a clearer error message like "Invalid character ' found - use straight quotes instead"

---

## General Notes on MCP Experience

**Positive:**
- The `validate_xanoscript` tool is very helpful for catching syntax errors
- The `xanoscript_docs` tool provides comprehensive documentation
- Error messages include line and column numbers

**Areas for improvement:**
- Error messages could be more descriptive and suggest fixes
- The constraint about no blank lines between comments and code is unusual and should be documented more prominently
- Smart quote handling would improve developer experience
