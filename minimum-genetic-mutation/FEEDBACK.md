# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 18:05 PST] - Cannot use `response` inside conditional blocks

**What I was trying to do:** Return early from a function when handling edge cases (e.g., `if start == end then return 0`)

**What the issue was:** The validator error said `Expecting --> } <-- but found --> 'response' <--` when using `response = 0` inside a conditional block

**Why it was an issue:** This pattern is common in many programming languages (early return for edge cases), but XanoScript requires `response` to only be set at the end of the function. This led to deeply nested conditionals to handle the control flow.

**Potential solution (if known):** 
- Document this constraint more prominently in the essentials/syntax docs
- Consider supporting early return with a `return` statement or allowing `response` in conditionals
- Or provide a pattern/example showing how to restructure early-return logic using variables and nested conditionals

---

## [2025-02-27 18:12 PST] - Filter expressions need parentheses when combined with comparisons

**What I was trying to do:** Use array filters like `count` in conditions: `if ($input.bank|count == 0)`

**What the issue was:** The parser gives error: `An expression should be wrapped in parentheses when combining filters and tests`

**Why it was an issue:** The fix is simple (wrap in parentheses), but the error message appears after the fact rather than being a documented convention. I had to validate multiple times to find all instances.

**Potential solution (if known):**
- Document this requirement in the syntax essentials with clear examples
- The error message is actually helpful (suggests the fix), but could be more discoverable

---

## [2025-02-27 18:00 PST] - MCP tool parameter passing via mcporter CLI

**What I was trying to do:** Call the `validate_xanoscript` tool via `mcporter call xano validate_xanoscript`

**What the issue was:** JSON parameter passing via mcporter CLI didn't work as expected. Tried multiple formats:
- `mcporter call xano validate_xanoscript '{"file_path": "/path"}'`
- `mcporter call xano validate_xanoscript --file_path /path`
- Various quoting and escaping attempts

All resulted in `Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required`

**Why it was an issue:** I had to bypass mcporter and use raw JSON-RPC via npx to get the tool to work, which is not ideal for regular use.

**Potential solution (if known):**
- Document the correct mcporter CLI syntax for JSON parameters
- Or fix mcporter to properly forward JSON arguments to MCP tools
- The workaround is using direct JSON-RPC: `echo '{"jsonrpc": "2.0", ...}' | npx -y @xano/developer-mcp`

---

## [2025-02-27 18:00 PST] - Documentation topics return same general content

**What I was trying to do:** Get specific documentation for `essentials`, `functions`, `syntax`, and `run` topics

**What the issue was:** All topic queries returned the same general documentation overview instead of topic-specific content

**Why it was an issue:** Couldn't get detailed syntax examples for specific constructs like loops, conditionals, or run jobs

**Potential solution (if known):**
- Verify the topic parameter is being respected in the MCP server
- Or the documentation structure may need to be updated to include more topic-specific details
