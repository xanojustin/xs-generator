# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-22 12:05 PST] - File Path Handling Issue

**What I was trying to do:** Validate multiple files by passing comma-separated file paths to the `validate_xanoscript` tool

**What the issue was:** When using `mcporter call xano.validate_xanoscript file_paths=/path/to/file1.xs,/path/to/file2.xs`, the comma-separated string was being split into individual characters, resulting in errors like "File not found: U", "File not found: s", "File not found: e", etc. (each character of the path was treated as a separate file).

**Why it was an issue:** This made it impossible to validate multiple specific files at once using the `file_paths` parameter. I had to work around this by using the `directory` parameter instead.

**Potential solution:** The MCP tool should properly parse comma-separated file paths or accept a JSON array format for the `file_paths` parameter.

---

## [2025-02-22 12:05 PST] - Successful Implementation

**What I was trying to do:** Create a complete XanoScript exercise for the "rotate list" problem

**What worked well:** 
- The `xanoscript_docs` tool with `topic=cheatsheet` provided excellent quick reference
- The `validate_xanoscript` tool with `directory` parameter worked correctly
- Both files passed validation on the first attempt

**Observations:**
- The XanoScript syntax is intuitive once you understand the block structure
- The `conditional { if () {} elseif () {} else {} }` pattern is clean and readable
- Variable scoping inside loops works well - you can redeclare variables within `each` blocks
- The `merge` filter for arrays is useful for building lists incrementally

---

## General Notes

- The documentation through `xanoscript_docs` is comprehensive and helpful
- The validation tool provides clear feedback on errors
- Having the cheat sheet topic saves time vs reading full syntax documentation
