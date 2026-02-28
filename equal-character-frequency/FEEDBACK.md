# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 19:35 PST] - mcporter call syntax for arrays

**What I was trying to do:** Validate multiple files using the `file_paths` parameter

**What the issue was:** The MCP tool expects `file_paths` as an array type, but I couldn't figure out the correct CLI syntax to pass an array. I tried:
- `file_paths="path1,path2"` (comma-separated string)
- `file_paths="path1" "path2"` (multiple arguments)

Both resulted in "Invalid input: expected array, received string"

**Why it was an issue:** I had to work around by using the `directory` parameter instead, which worked fine but isn't as precise for targeting specific files.

**Potential solution (if known):** The mcporter CLI documentation could clarify how to pass array parameters. Possibly something like `file_paths:=["path1","path2"]` or `file_paths=path1 file_paths=path2`?

---

## [2025-02-27 19:30 PST] - No syntax issues encountered

**What I was trying to do:** Write XanoScript code for a character frequency counting function

**What the issue was:** None - the code validated successfully on the first attempt

**Why it was an issue:** N/A

**Potential solution (if known):** N/A

**Notes:** The documentation was clear enough to write working code immediately. Key patterns that worked well:
- Using `split:""` to iterate over string characters
- Using object with `has`, `get`, `set` for the frequency map
- Using `values` filter to get all frequency counts
- Using `foreach` with `each as $var` for iteration
- Proper use of parentheses around filter expressions like `($input.s|strlen)`

