# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 17:01 PST] - File Path Parsing Issue

**What I was trying to do:** Validate multiple `.xs` files by passing comma-separated file paths to the `validate_xanoscript` tool.

**What the issue was:** When using `file_paths` parameter with comma-separated values like `file_paths=/path/to/file1.xs,/path/to/file2.xs`, the MCP server interpreted each character after the comma as a separate file path. This resulted in errors like:
- "File not found: U"
- "File not found: s"
- "File not found: e"
- etc.

The comma appears to be splitting the string into individual characters rather than maintaining the file path list.

**Why it was an issue:** This prevented batch validation of multiple specific files. I had to work around this by using the `directory` parameter instead, which validates all files in a directory.

**Potential solution (if known):** 
1. The MCP should properly handle comma-separated values in the `file_paths` array parameter
2. Alternatively, document that `file_paths` should be passed as a JSON array format instead of comma-separated
3. As a workaround, using `directory` parameter with a specific subdirectory works well for batch validation

## [2026-02-19 17:01 PST] - Validation Success

**What I was trying to do:** Validate XanoScript code for syntax errors

**What the issue was:** None - validation worked correctly when using the `directory` parameter

**Why it was an issue:** N/A - this was a success case

**Notes:** The validation correctly identified 3 files (including a pre-existing file) and reported all as valid with no errors.