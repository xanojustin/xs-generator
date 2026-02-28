# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 14:03 PST] - Comment Syntax Limitation

**What I was trying to do:** Write a XanoScript function with inline comments explaining the code logic.

**What the issue was:** The XanoScript parser does not allow comments on the same line as code, specifically after a closing brace `}`. This code fails validation:
```xs
var $sum { value = 1 }  // Start with 1 since 1 is always a divisor
```

The error message was:
```
[Line 21, Column 29] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

**Why it was an issue:** This is a common pattern in most programming languages (C, Java, JavaScript, Python, etc.) where inline comments are allowed after code. The restriction forces comments to be on their own lines, which can reduce code readability when you want to explain a specific value or operation.

**Potential solution (if known):** 
1. Update the XanoScript parser to accept comments after closing braces on the same line
2. Document this limitation clearly in the XanoScript documentation under a "Known Limitations" or "Common Pitfalls" section
3. Improve the error message to say something like "Comments must be on their own line" instead of the cryptic parser error

---

## [2026-02-28 14:02 PST] - MCP Tool Parameter Naming

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter CLI using the documented parameter names.

**What the issue was:** The tool schema shows `file_path` as the parameter name, but the mcporter CLI requires using `--args` with JSON format instead of direct parameters. Using `file-path` or `file_path` as direct CLI arguments didn't work:
```bash
# These didn't work:
mcporter call xano.validate_xanoscript file-path="path/to/file.xs"
mcporter call xano.validate_xanoscript file_path="path/to/file.xs"
```

Only this worked:
```bash
mcporter call xano.validate_xanoscript --args '{"file_path":"/absolute/path/to/file.xs"}'
```

**Why it was an issue:** This is inconsistent with other mcporter tools that accept direct parameters. It took several attempts to figure out the correct invocation pattern. Also, relative paths didn't work - only absolute paths were accepted.

**Potential solution (if known):**
1. Make the tool accept direct parameters like other mcporter tools
2. Support relative paths from the current working directory
3. Document the correct invocation pattern more prominently

---
