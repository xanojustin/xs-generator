# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 09:35 PST] - MCP Parameter Passing Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The MCP tool parameters were unclear. I tried multiple approaches:
1. `--args '{"files": [...]}'` - Wrong parameter name
2. `file_paths:="path1,path2"` - Wrong syntax
3. Finally worked: `--args '{"file_paths": ["path1", "path2"]}'`

The documentation in the schema shows the parameter as `file_paths?: string[]` but doesn't give a clear CLI example of the proper JSON array format.

**Why it was an issue:** Wasted several attempts figuring out the correct way to pass an array of file paths. The error message just said "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even when I was using one of those parameters.

**Potential solution:** 
- Provide explicit CLI examples in the schema description
- Better error messages that indicate when a parameter name is recognized but the format is wrong
- Maybe support comma-separated strings for array parameters in CLI mode

---

## [2025-02-19 09:35 PST] - No XanoScript Syntax Issues

**What I was trying to do:** Write XanoScript code for a reverse string function and run job

**What the issue was:** No issues! The code validated successfully on the first attempt.

**Why it was an issue:** N/A - This was a success case

**Potential solution:** The documentation for `run.job` could be more prominent in the main docs. I had to find examples in existing code rather than finding it in the xanoscript_docs output directly.

---