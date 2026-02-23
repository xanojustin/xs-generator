# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-23 08:05 PST - File Path Expansion Issue

**What I was trying to do:** Validate the XanoScript files using the Xano MCP

**What the issue was:** When using `file_paths` parameter with tilde (`~/xs/...`), the MCP returned "File not found" errors. The tilde was not expanded to the full home directory path.

**Why it was an issue:** The validation failed because the MCP couldn't find the files

**Potential solution:** Use `directory` parameter instead which worked perfectly, or document that full paths are required for `file_paths`

## 2026-02-23 08:06 PST - Shell Escaping with JSON Args

**What I was trying to do:** Pass multiple file paths to the validator

**What the issue was:** Shell escaping of JSON arrays with quotes caused parsing errors

**Why it was an issue:** Command failed with "unmatched quote" error

**Potential solution:** The `directory` parameter with a folder path is much easier to use and worked immediately

---

## Overall Feedback

The Xano MCP validation tool works well once you figure out the right approach. The `directory` parameter is the most reliable way to validate files - simpler than dealing with JSON arrays in shell commands.

Documentation was clear enough to write the code correctly on the first try thanks to the `xanoscript_docs` tool with the `functions` and `run` topics.
