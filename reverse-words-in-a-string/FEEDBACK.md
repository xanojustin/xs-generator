# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-23 00:01 PST - MCP Parameter Format Unclear

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The tool documentation showed examples using a format like `mcporter call xano.validate_xanoscript(file_path: "/path/to/file.md", ...)` but the actual mcporter CLI requires a different format. I tried several approaches:
1. JSON object format: `'{"file_paths": [...]}'` - didn't work
2. Named parameter format: `'file_paths: ["...", "..."]''` - shell quoting issues
3. Finally worked with: `"file_paths: [\"...\", \"...\"]`"

**Why it was an issue:** The example in the tool description doesn't match the actual CLI usage. The example shows `xano.validate_xanoscript(file_path: ...)` format but mcporter uses `mcporter call xano validate_xanoscript "param: value"` format. Additionally, the quoting for arrays in shell is tricky.

**Potential solution (if known):** 
- Update the tool description examples to match the actual mcporter CLI format
- Provide clearer examples for array parameters which require careful shell escaping
- Consider adding a simpler `--directory` flag example that works reliably

---

## 2025-02-23 00:01 PST - Documentation Topics Return Same Content

**What I was trying to do:** Get specific documentation for functions, run jobs, and syntax by calling `xanoscript_docs` with different topics

**What the issue was:** All topic queries (functions, quickstart, run, syntax) returned the same general documentation overview instead of specific content for each topic

**Why it was an issue:** I couldn't get detailed syntax information for run.job structure or specific function patterns, which made it harder to know the exact syntax. I had to rely on reading existing implementations in the ~/xs/ directory.

**Potential solution (if known):**
- Ensure topic-specific content is returned for each topic parameter
- Or consider removing the topic parameter if all topics return the same content

---

