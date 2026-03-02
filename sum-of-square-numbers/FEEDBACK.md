# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 13:05 PST] - Parameter passing format confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths

**What the issue was:** The MCP tool expects parameters in `key=value` format (e.g., `directory=/path/to/dir`), not JSON format (e.g., `'{"directory": "/path/to/dir"}'`). Multiple attempts with JSON syntax failed with error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** The tool documentation shows JSON examples (`"file_paths": ["/path/to/file.xs"]`) which suggests JSON format, but mcporter actually requires key=value pairs.

**Potential solution:** Update the documentation to show mcporter-style examples: `mcporter call xano validate_xanoscript file_path=/path/to/file.xs` or `directory=/path/to/dir`

---

## [2025-03-02 13:08 PST] - File paths array parameter format unclear

**What I was trying to do:** Pass multiple files using the `file_paths` array parameter

**What the issue was:** Could not determine the correct mcporter syntax for passing an array of file paths. Tried `file_paths:=["path1", "path2"]` and `file_paths:="path1" file_paths:="path2"` but neither worked.

**Why it was an issue:** Ended up using `directory` parameter as a workaround, but for specific file validation, array syntax would be preferred.

**Potential solution:** Document the exact mcporter syntax for array parameters - possibly `file_paths.0=/path/1 file_paths.1=/path/2` or similar.

---

## [2025-03-02 13:10 PST] - Positive: Clean validation success

**What went well:** Once the correct syntax was found (`directory=/path/to/dir`), validation worked perfectly. Both files passed on first attempt with clear output showing "2 valid, 0 invalid".

**No issues to report here** - the validation logic itself is solid and helpful.

---
