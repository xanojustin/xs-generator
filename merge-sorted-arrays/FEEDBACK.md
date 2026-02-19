# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 14:35 PST] - Parameter naming confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my .xs files

**What the issue was:** The first attempt used `files=` as the parameter name, but the MCP expected `file_paths=`. The error message was clear: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** I had to guess which parameter name to use. The documentation in the xanoscript_docs didn't specify the exact MCP tool parameter names.

**Potential solution (if known):** The xanoscript_docs could include a section on MCP tool usage with exact parameter names for each tool.

---

## [2025-02-19 14:35 PST] - Documentation was excellent

**What I was trying to do:** Write XanoScript code for merging sorted arrays

**What the issue was:** No issues - the documentation was comprehensive and accurate. I was able to write valid XanoScript on the first attempt.

**Why it was helpful:** The syntax documentation covered:
- `while` loops with proper syntax
- `array.push` function usage
- `math.add` for incrementing variables  
- Array access with `$array[$index]` syntax
- `count` filter for array length
- Proper conditional blocks with `if`/`elseif`/`else`

**Potential improvement:** Consider adding a complete working example of a while loop with array operations, as this is a common pattern in algorithmic exercises.

---
