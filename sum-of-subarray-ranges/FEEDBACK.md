# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-04 09:35 PST] - mcporter argument syntax confusion

**What I was trying to do:** Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** Initially had difficulty figuring out the correct mcporter CLI syntax for passing parameters. Tried several approaches:
- `mcporter call xano validate_xanoscript --directory <path>` - Failed
- `mcporter call xano validate_xanoscript --file_path <path>` - Failed  
- `mcporter call xano validate_xanoscript '{"file_path": "..."}'` - Failed
- `mcporter call xano.validate_xanoscript file_path=/Users/...` - **Worked!**

**Why it was an issue:** The error messages were confusing - it kept saying "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even when I was passing those parameters. This made it seem like the parameters weren't being recognized at all.

**Potential solution (if known):** The correct syntax uses `server.tool` dot notation and `key=value` format without dashes. It would be helpful if:
1. The tool help message showed an example of the correct syntax
2. The error message suggested trying the `server.tool` dot notation format
3. Documentation explicitly showed the mcporter call syntax patterns

---

## [2026-03-04 09:37 PST] - Documentation topics return same content

**What I was trying to do:** Get specific documentation for functions, run jobs, and essentials topics

**What the issue was:** Calling `xanoscript_docs` with different topics ("functions", "run", "essentials") all returned the same general README content instead of topic-specific documentation.

**Why it was an issue:** I was hoping to get specific syntax patterns for run jobs and functions, but instead got the same general overview each time. I had to rely on existing code examples in `~/xs/` to understand the correct structure.

**Potential solution (if known):** The topic parameter may not be working correctly, or the documentation may not have detailed topic-specific content yet. Having working topic-specific docs would help understand:
- The exact structure for `run.job` blocks
- All available options for function inputs and responses
- Specific patterns for loops, conditionals, and variable operations

---
