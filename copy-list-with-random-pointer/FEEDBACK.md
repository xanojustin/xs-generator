# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-23 04:05 PST - MCP Parameter Format Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The parameter format for `mcporter call` was unclear. I tried multiple approaches that all failed:
- JSON format: `'{"file_path": "/path/to/file"}'`
- JSON with file_paths array: `'{"file_paths": ["...", "..."]}'`
- JSON with directory: `'{"directory": "/path"}'`

All of these returned: `Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required`

**Why it was an issue:** It took multiple attempts and checking `mcporter describe xano` to discover that the correct format is `key=value` without JSON wrapping: `mcporter call xano validate_xanoscript file_path=/path/to/file.xs`

**Potential solution:** The error message could suggest the correct format, or the documentation could show clearer examples. The `describe` output shows `Examples: mcporter call xano.validate_xanoscript(file_path: "/path/to/file.md", file, ...)` which uses a different syntax than what actually works.

---

## 2026-02-23 04:02 PST - xanoscript_docs Returns Same Content for All Topics

**What I was trying to do:** Get specific documentation for functions, quickstart, syntax, and run topics

**What the issue was:** Calling `xanoscript_docs` with different topics (`functions`, `quickstart`, `syntax`, `run`) all returned the same general documentation overview instead of topic-specific content

**Why it was an issue:** I needed specific syntax details for functions and run jobs but kept getting the same high-level overview. The documentation mentions "For common patterns and quick examples, use: `xanoscript_docs({ topic: 'quickstart' })`" but this didn't return quickstart-specific content.

**Potential solution:** Either the topic parameter isn't being respected, or the documentation files haven't been populated with topic-specific content yet. The MCP could validate topics and return an error/warning if content isn't available, or fall back to showing the general docs with a notice that specific content isn't loaded.

---

## 2026-02-23 04:00 PST - No Issues with Core Validation

**What I was trying to do:** Write and validate XanoScript code for a coding exercise

**What went well:** Once I figured out the correct parameter format, the validation worked perfectly. Both files passed on the first attempt with no errors.

**Positive feedback:** The validation is fast and gives clear ✓/✗ feedback. The error message format (when there are errors in other exercises) typically includes line/column positions which is very helpful.

---

## General Notes

- The `mcporter describe xano` command was essential for understanding the correct parameter format
- The XanoScript language itself was intuitive enough that I could write valid code by following existing examples in the `~/xs/` directory
- The validation tool appears to work correctly once the parameter format is understood
