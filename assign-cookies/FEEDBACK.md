# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 18:35 PST] - MCP Parameter Format Confusion

**What I was trying to do:** Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** The parameter format was unclear. Initially tried using JSON format like `'{"file_paths": [...]}'` but the MCP expected a different format `'file_paths=["...", "..."]'`

**Why it was an issue:** Error messages said "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even when I was providing those parameters. It took multiple attempts to discover the correct format.

**Potential solution (if known):** The `mcporter describe` output shows the correct format in the examples section: `mcporter call xano.validate_xanoscript(file_path: "/path/to/file.md", file, ...)`. However, this doesn't match what actually worked for me. Perhaps clearer documentation on parameter formats or a more helpful error message would assist.

---

## [2025-02-23 18:35 PST] - Directory Validation Not Finding Files

**What I was trying to do:** Use the `directory` parameter to validate all .xs files in the exercise folder

**What the issue was:** The MCP reported "No .xs files found in directory" even though `find` command confirmed the files existed at that path.

**Why it was an issue:** Had to switch to using `file_paths` parameter with explicit file paths instead of the more convenient `directory` parameter.

**Potential solution (if known):** May be a path resolution issue in the MCP server. Could be related to how the server resolves paths vs how the shell resolves them.

---

## [2025-02-23 18:35 PST] - xanoscript_docs Returns Index Instead of Topic Content

**What I was trying to do:** Get specific documentation on functions, quickstart, and run topics using `xanoscript_docs({ topic: "functions" })`

**What the issue was:** Every call returned the same documentation index/overview page regardless of which topic was requested.

**Why it was an issue:** Couldn't access detailed syntax documentation for the specific constructs I needed (run.job syntax, function patterns, etc.). Had to rely on examining existing exercise files to understand the patterns.

**Potential solution (if known):** The topic parameter may not be working correctly, or the documentation server might be returning the wrong content. The index page shows available topics but the actual topic content isn't being retrieved.

---
