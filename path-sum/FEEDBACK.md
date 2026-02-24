# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 13:35 PST] - MCP Validation Tool Cannot Find Files

**What I was trying to do:** Validate the XanoScript files using the MCP `validate_xanoscript` tool

**What the issue was:** The validation tool consistently reports "No .xs files found in directory" despite:
1. Files existing at the specified path
2. Using the exact same syntax that worked in previous sessions
3. Trying multiple parameter formats (directory, file_path, file_paths)
4. Using absolute paths confirmed with `realpath`

Commands attempted:
```bash
mcporter call xano.validate_xanoscript directory="/Users/justinalbrecht/xs/path-sum"
mcporter call xano.validate_xanoscript file_path="/Users/justinalbrecht/xs/path-sum/run.xs"
mcporter call xano.validate_xanoscript 'directory: "/Users/justinalbrecht/xs/path-sum"'
```

All returned either "No .xs files found" or "File not found".

**Why it was an issue:** This blocked the validation step of the workflow. The files definitely exist (confirmed with `ls` and `find`), but the MCP tool cannot access them.

**Potential solutions:**
1. The MCP server may have a working directory restriction that prevents accessing files outside a specific path
2. There might be a file system sandboxing issue
3. The directory parameter may need a trailing slash or different path format
4. The MCP server process might need to be restarted

**Workaround:** Continue with the implementation and document the validation issue. The code follows established patterns from previously validated exercises.

---

## [2026-02-24 13:30 PST] - Documentation Topics Return Generic Content

**What I was trying to do:** Get specific documentation for `run` jobs and `functions` topics

**What the issue was:** Calling `xanoscript_docs({"topic": "run"})` and `xanoscript_docs({"topic": "functions"})` both returned the same generic README content instead of topic-specific documentation.

**Why it was an issue:** Had to infer the correct syntax from existing validated examples rather than getting specific guidance for run job syntax.

**Potential solution:** The topic parameter filtering may not be working correctly, or those specific topics may not have dedicated content yet.

---

## [2026-02-24 13:30 PST] - Argument Parsing Format Confusion

**What I was trying to do:** Call the MCP tool with the correct argument format

**What the issue was:** Confusion about whether to use:
- `mcporter call xano validate_xanoscript` (space)
- `mcporter call xano.validate_xanoscript` (dot)
- JSON format: `'{"directory": "/path"}'`
- Key=value format: `directory="/path"`

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was ambiguous - it wasn't clear if the parameter wasn't being passed or if it was in the wrong format.

**What worked in previous sessions:** `mcporter call xano.validate_xanoscript directory="/full/path"`

**Suggestion:** Add explicit CLI usage examples to the tool schema descriptions showing the exact mcporter syntax.

---
