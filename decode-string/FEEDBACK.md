# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 23:05 PST] - Filter naming confusion: `length` vs `strlen`

**What I was trying to do:** Write a while loop to iterate through each character of a string, checking if the index is less than the string length.

**What the issue was:** I used the filter `|length` which seemed intuitive (similar to JavaScript's `.length` property), but the validator reported: `Unknown filter function 'length'`.

**Why it was an issue:** This caused the validation to fail and required me to look up the correct filter name in the documentation. The error message was helpful but didn't suggest the correct filter name.

**Potential solution (if known):** 
- The documentation in the quick reference shows `strlen` for string length and `count` for array length
- It might be helpful if the error message suggested `strlen` as an alternative when `length` is used on a string context
- Or consider aliasing `length` to work for both strings and arrays (like many other languages)

---

## [2026-02-22 23:06 PST] - MCP `file_paths` parameter parsing issue

**What I was trying to do:** Validate multiple files at once by passing comma-separated file paths to the `validate_xanoscript` tool.

**What the issue was:** When I called `mcporter call xano.validate_xanoscript file_paths=/path/to/file1.xs,/path/to/file2.xs`, the MCP treated the comma-separated string as individual file path characters, resulting in errors like:
- `File not found: U`
- `File not found: s`
- etc.

**Why it was an issue:** This made it seem like the tool was completely broken. I had to switch to using the `directory` parameter instead to validate files.

**Potential solution (if known):**
- The MCP should either:
  1. Properly parse comma-separated file paths
  2. Or accept an array format for file_paths parameter
  3. Or update the documentation/tool description to clarify the expected format
- Using `--args '{"file_paths": ["path1", "path2"]}'` syntax might work but this should be clearer
