# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 12:35 PST] - File Path Resolution with ~

**What I was trying to do:** Validate the XanoScript files using the `validate_xanoscript` tool with file_paths parameter.

**What the issue was:** When using `~` (tilde) in file paths like `~/xs/max-chunks-to-sorted/run.xs`, the MCP server returned "File not found" errors.

**Why it was an issue:** The tilde wasn't being expanded to the home directory by the MCP tool. This required switching to absolute paths (`/Users/justinalbrecht/xs/...`).

**Potential solution (if known):** The MCP server could expand `~` to the user's home directory before attempting to read files, making the tool more user-friendly.

---

## [2025-02-27 12:35 PST] - Shell Quote Escaping Issues

**What I was trying to do:** Pass multiple file paths to the validate_xanoscript tool using the file_paths array parameter.

**What the issue was:** Shell escaping of nested quotes in the mcporter command line caused syntax errors: `zsh:1: unmatched "`

**Why it was an issue:** Complex JSON arrays with nested quotes are difficult to escape correctly in shell commands.

**Potential solution (if known):** Using the `directory` parameter instead of `file_paths` worked perfectly and was much simpler. The directory parameter is a great feature that avoids this issue entirely.

---

## [2025-02-27 12:35 PST] - Overall Experience

**What went well:**
- The `xanoscript_docs` tool with `topic=essentials` provided excellent guidance
- The documentation was clear about common mistakes (elseif vs else if, variable naming, etc.)
- The `directory` parameter for validation is very convenient
- First-pass validation success suggests the documentation is effective

**Suggestions for improvement:**
1. Consider supporting `~` expansion in file paths
2. The `file_paths` array parameter is tricky to use from shell - the directory option should be highlighted more prominently
3. Could benefit from an "init" or "scaffold" command to create the run.xs/function structure
