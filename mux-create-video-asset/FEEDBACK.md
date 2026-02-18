# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 21:45 PST] - Index Type Documentation Issue

**What I was trying to do:**
Create a table definition with indexes for faster lookups on `mux_asset_id` and `playback_id` fields.

**What the issue was:**
I initially used `type: "index"` for secondary indexes, which was rejected by the validator. The error message said the type must be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`.

**Why it was an issue:**
The quickstart documentation mentions indexes briefly but doesn't list the valid index types. "index" seems like a logical type name for a standard index, but it's not valid.

**Potential solution:**
Add a section to the tables documentation showing common index type examples:
- `primary` - Primary key
- `btree` - Standard B-tree index (most common)
- `btree|unique` - Unique constraint
- `gin` - For JSON/array columns
- `search` - For full-text search
- `vector` - For vector/similarity search

---

## [2026-02-17 21:50 PST] - Overall Positive Experience

**What went well:**
1. The `xanoscript_docs` tool is excellent - comprehensive and well-organized
2. The validation tool gives clear error messages with line/column numbers
3. The quickstart guide covers common mistakes which saved time
4. The examples for API requests were directly applicable

**Suggestions for improvement:**
1. Add a "Common Index Types" section to the tables documentation
2. Consider adding a `run.job` example with full supporting files (table + function) in one example
3. Document the `base64_encode` filter - I assumed it existed and it worked, but wasn't sure

---

## Summary

Total files created: 3
Total validation errors: 2 (both fixed by changing "index" to "btree")
Time to complete: ~15 minutes
Overall experience: Smooth - the docs and validation tools work well together.