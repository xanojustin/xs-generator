# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 15:03 PST] - File path expansion with tilde (~)

**What I was trying to do:** Validate XanoScript files using file_paths parameter with paths like `~/xs/reverse-string-ii/function/reverse_string_ii.xs`

**What the issue was:** The MCP validator returned "File not found" errors when using tilde (~) path expansion. The paths needed to be fully expanded to absolute paths like `/Users/justinalbrecht/xs/...`

**Why it was an issue:** Had to manually expand paths instead of using standard shell conventions. This adds friction to the validation workflow.

**Potential solution:** The MCP could expand `~` to the user's home directory before attempting to read files, or provide clearer documentation that absolute paths are required.

---

## [2025-02-26 15:04 PST] - Response placement confusion

**What I was trying to do:** Write a function that returns a result after processing in a stack block

**What the issue was:** Initially placed `response = ...` inside the `stack { }` block, which caused a parse error: "Expecting --> } <-- but found --> 'response' <--"

**Why it was an issue:** The documentation shows the response at the end of the function, but when looking at complex examples with nested blocks, it's easy to lose track of which block you're in. The error message was helpful in pointing to the exact location, but didn't clearly explain that response must be at the function level, not inside stack.

**Potential solution:** The error message could be more explicit: "The 'response' statement must be at the function level, not inside a stack block." Or the documentation could emphasize this more prominently with a "❌ Wrong / ✅ Correct" example.

---

## [2025-02-26 15:05 PST] - No issues encountered with MCP tools

**What I was trying to do:** Use the `mcporter call xano validate_xanoscript` and `xanoscript_docs` tools

**What happened:** Both tools worked correctly. The xanoscript_docs topic=quickstart provided excellent documentation with common patterns and mistakes. The validate_xanoscript tool gave clear error messages with line/column numbers.

**Notes:** The quickstart documentation was particularly helpful with its "Common Mistakes" section showing what not to do. This saved time compared to learning through trial and error.

---
