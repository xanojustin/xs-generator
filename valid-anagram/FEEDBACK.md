# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 00:35 PST] - MCP Server Discovery Issue

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter using the configured server name.

**What the issue was:** The command `mcporter call xano.validate_xanoscript` failed with "Unknown MCP server 'xano'" error, even though `mcporter list` showed the xano server as available.

**Why it was an issue:** The server name resolution wasn't working through the normal mcporter call syntax, requiring me to use the `--stdio` workaround with the full npx command.

**Potential solution:** The mcporter configuration might need to be refreshed, or there's an issue with how the server is registered. Using `--stdio "npx -y @xano/developer-mcp"` worked as a fallback.

---

## [2026-02-23 00:38 PST] - Unknown Filter Function Name

**What I was trying to do:** Split a string into an array of characters to implement the anagram check.

**What the issue was:** I initially used `str_split` filter which doesn't exist in XanoScript. The validation returned: "Unknown filter function 'str_split'".

**Why it was an issue:** My mental model from other languages (PHP uses `str_split`, JavaScript uses `split`) led me to the wrong filter name. I had to query the documentation to find the correct name.

**Potential solution:** The `xanoscript_docs` tool with the syntax topic was helpful, but it would be nice if the validation error suggested the correct filter name. For example: "Unknown filter 'str_split'. Did you mean 'split'?"

---

## [2026-02-23 00:38 PST] - Parentheses Required Around Filtered Expressions

**What I was trying to do:** Compare the lengths of two strings using the `strlen` filter in a conditional.

**What the issue was:** The code `$input.s|strlen != $input.t|strlen` caused a parse error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** I wasn't aware that filtered expressions need to be wrapped in parentheses when used in comparisons. The syntax requirement wasn't obvious from the documentation examples I saw.

**Potential solution:** The documentation mentions this in the "Common Mistakes" section, but it would be helpful to have this more prominently featured in the conditional/syntax docs. The error message was clear though, which helped.

---

## [2026-02-23 00:42 PST] - Overall Experience

**Positive:**
- The validation tool is fast and provides helpful line/column numbers
- The documentation is comprehensive and searchable via the MCP
- The error messages include suggestions (like "Use 'text' instead of 'string'")

**Areas for improvement:**
- The filter name suggestions in error messages could be more proactive (e.g., suggesting `split` when `str_split` is not found)
- The MCP server discovery issue was confusing - the server showed in `mcporter list` but couldn't be called directly

**General note:** The write → validate → fix loop worked well once I figured out the correct mcporter syntax. Having to validate frequently caught syntax errors early.
