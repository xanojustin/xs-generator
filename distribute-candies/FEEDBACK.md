# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 11:33 PST] - MCP Tool Parameter Format Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool via mcporter

**What the issue was:** The parameter syntax for mcporter calls was unclear. I tried several formats:
- `--files path1 path2` (like a CLI)
- `--file_paths '["path1", "path2"]'` (JSON array)
- `--directory .` (directory flag)
- `'{"directory": "/path"}'` (JSON object)

All of these failed with various errors.

**Why it was an issue:** The documentation examples show `mcporter call xano.validate_xanoscript(file_path: "/path/to/file.md", file, ...)` but the actual working syntax is `file_path=/Users/justinalbrecht/xs/distribute-candies/run.xs` (key=value format without dashes).

**Potential solution (if known):** The mcporter help text should include a clear example of the key=value syntax, or the error messages should suggest the correct format when parameters are malformed.

---

## [2026-02-26 11:35 PST] - No Other Issues

**What I was trying to do:** Write XanoScript code for the "distribute-candies" exercise

**What the issue was:** None - the code validated on first attempt

**Why it was an issue:** N/A

**Potential solution (if known):** The documentation accessed via `xanoscript_docs` topic was comprehensive and helpful. The examples from existing code in `~/xs/` were also very useful for understanding the run.job → function pattern.

---

## General Feedback

### Documentation Quality
The `xanoscript_docs` topic documentation is excellent - comprehensive with clear examples. The syntax reference covering filters, operators, and common patterns was particularly helpful.

### MCP Tool Reliability
Once the correct parameter format was discovered, the validation tool worked quickly and provided clear results.

### Suggestions
1. Add a `validate_directory` or batch validation example to the mcporter help output
2. Include a working example of the key=value parameter format in tool documentation
