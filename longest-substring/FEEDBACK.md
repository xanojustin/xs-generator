# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-20 19:35 PST - Initial Attempt

**What I was trying to do:** Create a new XanoScript coding exercise for "Longest Substring Without Repeating Characters" following the established pattern.

**What the issue was:** Initially attempted to use `~` (tilde) for home directory in the `file_paths` parameter of `validate_xanoscript`. The MCP tool did not expand the tilde and instead tried to validate each character as a separate file path, resulting in 82 "file not found" errors for individual characters like 'x', 's', 'l', 'o', etc.

**Why it was an issue:** The error messages were confusing at first - seeing "File not found: x" and "File not found: s" made it seem like there was a syntax error in my XanoScript code, when actually the file path wasn't being resolved.

**Potential solution (if known):** 
- Option 1: Have the MCP expand `~` to the user's home directory before processing file paths
- Option 2: Document in the tool description that absolute paths are required
- Option 3: Add a note that shell expansions like `~` are not supported

**Workaround used:** Switched to using the `directory` parameter with full absolute path (`/Users/justinalbrecht/xs/longest-substring`) which worked perfectly.

---

## 2025-02-20 19:37 PST - Validation Success

**What I was trying to do:** Validate the XanoScript files for syntax errors.

**What the issue was:** No issues encountered - both files passed validation on the first attempt.

**Why it was an issue:** N/A - Success case

**Potential solution (if known):** N/A

**Note:** The documentation from `xanoscript_docs` was clear and sufficient to write correct code on the first attempt. The sliding window algorithm using `while` loops, `conditional` blocks, and variable operations worked as expected.
