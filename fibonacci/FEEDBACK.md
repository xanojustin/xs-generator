# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 11:32 PST] - Initial MCP Tool Discovery

**What I was trying to do:** Call the Xano MCP to get documentation for XanoScript syntax

**What the issue was:** Initially tried calling `xanoscript_docs` directly without knowing the proper MCP server name. The error indicated "Unknown MCP server 'xanoscript_docs'"

**Why it was an issue:** Had to run `mcporter list` to discover the Xano MCP was named "xano" not "xanoscript_docs" (which is the tool name, not the server name)

**Potential solution:** The prompt says to call `xanoscript_docs` on the Xano MCP which is slightly confusing since that's the tool name, not the server name. A clearer instruction would be "call the `xanoscript_docs` tool on the Xano MCP server" or specify that the server is named "xano".

---

## [2026-02-19 11:33 PST] - Path Expansion in Validation

**What I was trying to do:** Validate the XanoScript files using the `validate_xanoscript` tool with a directory path

**What the issue was:** Used `~/xs/fibonacci` as the directory path but the tool reported "No .xs files found in directory: ~/xs/fibonacci"

**Why it was an issue:** The tilde (`~`) wasn't being expanded to the home directory. Had to use the full absolute path `/Users/justinalbrecht/xs/fibonacci`

**Potential solution:** The MCP tool could support shell-style path expansion (tilde expansion) to make it more user-friendly, or the documentation could note that absolute paths are required.

---

## [2026-02-19 11:34 PST] - Successful Validation (No Issues)

**What I was trying to do:** Validate the XanoScript files after implementing the Fibonacci exercise

**What happened:** Both files passed validation on the first attempt with no errors

**Why this worked:** Following the XanoScript documentation closely from `xanoscript_docs` helped avoid common mistakes:
1. Used `int` instead of `integer` for type names
2. Used `elseif` (single word) instead of `else if`
3. Used proper filter syntax with parentheses: `($i|to_text)`
4. Used correct structure for `run.job` with `main` attribute
5. Used correct `function` structure with `input`, `stack`, and `response`

**Positive feedback:** The documentation provided by `xanoscript_docs` was comprehensive and clear, especially the "Common Mistakes" section in the quickstart guide.
