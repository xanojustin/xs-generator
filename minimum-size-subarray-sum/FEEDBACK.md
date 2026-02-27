# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 05:05 PST] - File Path Handling in validate_xanoscript

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool via mcporter

**What the issue was:** Initially tried using `~/xs/...` (tilde expansion for home directory) but got "File not found" errors. The tool doesn't expand the tilde to the full path.

**Why it was an issue:** Had to figure out the correct path format. The error message was clear but it took an extra step to resolve.

**Potential solution:** Consider adding support for shell-style path expansion (tilde `~`) in the MCP tool, or document that absolute paths are required.

---

## [2026-02-27 05:06 PST] - JSON Argument Passing in mcporter

**What I was trying to do:** Pass an array of file paths to the `validate_xanoscript` tool

**What the issue was:** The shell had trouble parsing the command with nested quotes when using `file_paths='[...]'` syntax. Got "unmatched `"" error from zsh.

**Why it was an issue:** Had to switch to using `--args '{"file_paths": [...]}'` syntax instead of inline parameters.

**Potential solution:** The mcporter inline parameter syntax with complex JSON arrays is tricky. The `--args` approach works well but could be better documented as the recommended approach for array parameters.

---
