# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 19:10 PST] - Inline Comment Syntax Restriction

**What I was trying to do:** Add an inline comment at the end of a `var.update` statement to explain the purpose of the code.

**What the issue was:** The XanoScript parser rejected inline comments at the end of statements. The error message indicated it was expecting a NewlineToken but found `/` (the start of the comment).

**Code that failed:**
```xs
var.update $n { value = 1 }  // Force exit
```

**Error message:**
```
[Line 50, Column 42] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

**Why it was an issue:** This is unexpected behavior for most programmers who are used to being able to add inline comments at the end of lines. The documentation mentions that `//` is the comment syntax but doesn't clearly indicate that comments must be on their own lines.

**Potential solution (if known):** 
1. Update documentation to clearly state that comments must be on their own lines (not inline)
2. Or update the parser to support inline comments at end of lines
3. The error message could be more helpful - something like "Comments must be on their own line" instead of the cryptic "expecting NewlineToken" message

---

## [2025-02-19 19:08 PST] - MCP file_path Parameter Path Resolution

**What I was trying to do:** Validate XanoScript files using the `file_path` parameter with absolute paths.

**What the issue was:** The MCP `validate_xanoscript` tool with `file_path` parameter appears to need to be run from the workspace directory where the mcporter config is located. Running from other directories caused "Unknown MCP server 'xano'" errors or "File not found" errors.

**Why it was an issue:** It's not immediately obvious that the working directory matters for MCP tool calls. The error messages were misleading - "File not found" when the file clearly exists, or "Unknown MCP server" when the server is configured.

**Workaround discovered:** Run mcporter commands from the `~/.openclaw/workspace` directory where the mcporter.json config file is located.

**Potential solution (if known):**
1. The MCP server could resolve paths relative to the project root regardless of working directory
2. Better error messages indicating the working directory requirement
3. Documentation note about running from the workspace directory

---
