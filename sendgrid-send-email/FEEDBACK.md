# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-18 16:16 PST - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The tool kept returning "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even though I was passing parameters. The issue was with how mcporter parses JSON arguments vs key=value arguments.

**Why it was an issue:** I tried multiple formats:
1. `mcporter call xano validate_xanoscript '{"directory": "."}'` - JSON string, didn't work
2. `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` - JSON with escaped paths, didn't work
3. The working format was: `mcporter call xano.validate_xanoscript directory="/full/path"`

The key learning was:
- Use `xano.validate_xanoscript` (dot notation) not `xano validate_xanoscript` (space)
- Use `key="value"` format, not JSON

**Potential solution:** Better examples in the tool description showing the exact mcporter CLI syntax would help. The current schema shows JSON parameters but mcporter actually wants key=value format.

---

## 2025-02-18 16:15 PST - MCP Server Connection Issue

**What I was trying to do:** Run validation from a subdirectory

**What the issue was:** When running from `~/xs/sendgrid-send-email` directory, mcporter couldn't find the 'xano' server and returned "Unknown MCP server 'xano'"

**Why it was an issue:** The working directory affected MCP server discovery. This was confusing because the server was listed as healthy from the home directory.

**Potential solution:** Clarify in docs that mcporter should be run from the directory where mcporter.json exists or use absolute paths.

---

## 2025-02-18 16:12 PST - Documentation Topics Not Returning Specific Content

**What I was trying to do:** Get specific documentation for 'run' and 'quickstart' topics

**What the issue was:** When calling `xanoscript_docs({"topic": "run"})` and `xanoscript_docs({"topic": "quickstart"})`, both returned the same generic README content instead of topic-specific documentation.

**Why it was an issue:** I was hoping to get specific syntax patterns for run jobs, but had to infer from the generic documentation and existing examples instead.

**Potential solution:** The topic filtering may not be working correctly, or those topics don't have specific content yet. Either way, clearer indication would help.

---

## Overall Feedback

**What worked well:**
- The validation tool is fast and provides clear output
- The generic documentation was enough to infer patterns from existing examples
- The xano MCP is well-integrated with mcporter once you figure out the syntax

**Suggestions for improvement:**
1. Add CLI usage examples directly in the tool schema descriptions
2. Ensure topic-specific docs return different content than the README
3. Consider a `validate_single` tool that takes a file_path as the primary param for simpler use
