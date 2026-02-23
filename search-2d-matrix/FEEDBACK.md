# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-23 05:32 PST - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The tool documentation shows JSON format with quoted keys like `{"file_path": "/path/to/file.xs"}`, but this format doesn't work with mcporter. The actual working format is `key=value` without quotes: `file_path=/Users/justinalbrecht/xs/search-2d-matrix/run.xs`

**Why it was an issue:** I tried multiple JSON variations:
- `mcporter call xano validate_xanoscript '{"file_path": "/path"}'` - didn't work
- `mcporter call xano validate_xanoscript '{"file_paths": ["/path1", "/path2"]}'` - didn't work  
- `mcporter call xano validate_xanoscript --directory /path` - didn't work
- `mcporter call xano validate_xanoscript file_path=/path` - **worked!**

**Potential solution:** The MCP tool schema or mcporter documentation could clarify that parameters should be passed as `key=value` pairs, not JSON. The tool description mentions the JSON format which is misleading for mcporter users.

---

## 2025-02-23 05:33 PST - Documentation Topic Redirects

**What I was trying to do:** Get specific documentation for `run`, `functions`, and `quickstart` topics

**What the issue was:** All three topic queries (`xanoscript_docs topic=run`, `topic=functions`, `topic=quickstart`) returned the exact same general documentation overview instead of topic-specific content

**Why it was an issue:** I was expecting detailed syntax examples for run jobs and functions, but got the same generic reference guide each time. I had to infer patterns from existing exercise files instead.

**Potential solution:** The MCP could return topic-specific documentation or indicate when a topic doesn't have specialized content yet. The generic docs were helpful but not as targeted as expected.

---

## Summary

Overall the validation tool worked well once I figured out the parameter format. The files passed validation on the first try, which suggests the syntax patterns I inferred from existing exercises were correct.
