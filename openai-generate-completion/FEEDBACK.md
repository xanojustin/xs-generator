# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 12:48 PST] - MCP Server Discovery Issue

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter to validate my .xs files

**What the issue was:** The mcporter CLI was unable to find the 'xano' server despite it being listed in `mcporter list`. The error was "Unknown MCP server 'xano'."

**Why it was an issue:** This blocked my ability to validate files through the normal mcporter interface. I had to work around it by manually invoking the MCP server via STDIO with raw JSON-RPC.

**Potential solution (if known):** The xano MCP uses STDIO transport (`npx @xano/developer-mcp`), and mcporter may not be correctly handling STDIO-based servers when calling tools. This could be a mcporter configuration issue or the server needs to be accessed differently.

**Workaround used:**
```bash
echo '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"validate_xanoscript","arguments":{"file_paths":["..."]}}}' | npx @xano/developer-mcp
```

---

## [2026-02-18 12:48 PST] - XanoScript Documentation Was Excellent

**What I was trying to do:** Write correct XanoScript syntax for the OpenAI run job

**What the issue was:** None - the documentation was very helpful!

**Why it matters:** The `xanoscript_docs` tool with topics `quickstart`, `run`, and the overview provided clear guidance. Key things that helped:
- The quickstart's "Common Mistakes" section prevented errors
- The run job documentation clearly showed the structure
- Examples of api.request with headers and error handling

**Positive feedback:** The documentation calling out specific mistakes (like using `body` instead of `params` for api.request) saved me from errors.

---

## [2026-02-18 12:48 PST] - Validation Passed First Try

**What I was trying to do:** Validate 3 .xs files (run.xs, function/generate_completion.xs, table/completion_log.xs)

**What happened:** All files passed validation on the first attempt

**Why this is notable:** The documentation was clear enough that I wrote valid XanoScript without any iteration. This suggests the quickstart guide and examples are well-designed.

---

*End of feedback for this run job.*
