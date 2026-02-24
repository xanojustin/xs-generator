# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 15:05 PST] - Issue: merge_at filter doesn't exist

**What I was trying to do:** Update an array element at a specific index by replacing it with a new value.

**What the issue was:** I assumed there would be a `merge_at` filter (similar to other languages' array manipulation methods) that would allow me to update an element at a specific index. The validation failed with "Unknown filter function 'merge_at'".

**Why it was an issue:** I had to restructure my approach from a simple one-line update to a multi-step slice-and-merge operation:
- Slice the array before the target index
- Slice the array after the target index  
- Merge: before + [new_value] + after

This is more verbose and less intuitive than having a direct array element update mechanism.

**Potential solution (if known):** 
- Add an `update_at` or `set_at` filter for arrays that updates an element at a specific index
- Or document the recommended pattern (slice + merge) more prominently in the array/filter documentation
- The `set` filter works for objects but there's no equivalent for arrays

---

## [2025-02-24 15:05 PST] - Issue: file_paths parameter parsing in validate_xanoscript

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated values.

**What the issue was:** When calling `validate_xanoscript` with `file_paths="/path1/file1.xs,/path2/file2.xs"`, the MCP parsed each character as a separate file path, resulting in errors like "File not found: U", "File not found: s", etc.

**Why it was an issue:** I had to call the validation tool twice (once per file) instead of batch validating, which is less efficient.

**Potential solution (if known):** 
- Fix the parameter parsing to properly handle comma-separated file paths
- Or document the expected format for the file_paths array parameter
- Consider accepting a JSON array format instead

---
