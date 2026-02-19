# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-18 21:30 PST - MCP Server Discovery Issue

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter using the configured xano server

**What the issue was:** The mcporter `call` command could not find the xano server despite it being listed in `mcporter list`. Error: "Unknown MCP server 'xano'"

**Why it was an issue:** The server is clearly configured and shown as "ok" in the list, but the dot-notation call (`xano.validate_xanoscript`) fails to resolve it.

**Workaround used:** Used the `--stdio` flag to run the MCP server directly: `mcporter call --stdio "npx @xano/developer-mcp" validate_xanoscript file_path:function.xs`

**Potential solution:** The mcporter call command may have a bug with server name resolution when using dot notation, or there may be a different syntax expected.

---

## 2025-02-18 21:32 PST - Documentation Content Gap

**What I was trying to do:** Get detailed XanoScript syntax documentation for loops, conditionals, and variable operations

**What the issue was:** The `xanoscript_docs` tool returns the same index/overview content regardless of the topic requested. I tried `quickstart`, `functions`, and `syntax` but all returned the same general documentation.

**Why it was an issue:** Without access to detailed syntax documentation, I had to rely on reading existing example files to understand patterns like:
- How to write `while` loops with `each` blocks
- Proper `conditional` syntax with `if/elseif/else`
- How to use `var` and `var.update` for variable operations
- Filter syntax like `|sqrt` and `|floor`

**Potential solution:** The MCP server may need to return different content based on the topic parameter, or the documentation may need to be expanded with more specific examples.

---

## 2025-02-18 21:35 PST - No Validation Errors (Positive Feedback)

**What I was trying to do:** Validate my XanoScript code

**What happened:** The code passed validation on the first attempt with no errors

**Why this is worth noting:** Once I understood the pattern from existing examples, the XanoScript syntax was intuitive and the validation tool provided clear confirmation. The error messages from previous attempts (with other exercises) have been helpful when there were issues.

