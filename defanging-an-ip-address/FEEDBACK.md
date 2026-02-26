# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 22:00 PST] - MCP file_paths parameter parsing issue

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated paths

**What the issue was:** When calling `validate_xanoscript` with `file_paths="/path1,/path2"`, the MCP server interprets the comma-separated string as individual characters/files, resulting in errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

The tool apparently splits the string by commas and then treats each character as a separate file path.

**Why it was an issue:** This made it impossible to use the `file_paths` parameter as documented. I had to switch to using the `directory` parameter instead, which worked fine.

**Potential solution (if known):** 
- The MCP should properly parse array parameters from the CLI
- Consider accepting multiple `--file-path` arguments instead of comma-separated
- Document the expected format more clearly if there's a specific syntax required

---

## [2025-02-25 22:00 PST] - Documentation clarity on string replace filter

**What I was trying to do:** Find the correct syntax for string replacement in XanoScript

**What the issue was:** The quick_reference documentation didn't show the replace filter syntax clearly. I had to search through the full syntax documentation to find it.

**Why it was an issue:** String replacement is a very common operation. It would be helpful if the cheatsheet or quick_reference included common string manipulation examples.

**Potential solution (if known):** 
- Add `replace` to the cheatsheet with an example like: `$text|replace:"old":"new"`
- Include a "Common String Operations" section in the quick_reference

---
