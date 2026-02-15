# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 19:50 PST] - MCP Server Configuration Missing

**What I was trying to do:**
Validate XanoScript files using the Xano MCP server's `validate_xanoscript` tool.

**What the issue was:**
The Xano MCP server was not configured in mcporter. When running `mcporter call xano.validate_xanoscript`, it returned "Unknown MCP server 'xano'".

**Why it was an issue:**
I had to manually create a Node.js script to spawn the MCP server via npx and communicate with it over stdio, which is cumbersome and not the intended workflow.

**Potential solution (if known):**
- Provide documentation on how to properly configure the Xano MCP in mcporter
- Or provide a CLI wrapper that doesn't require mcporter configuration

---

## [2026-02-14 19:55 PST] - Reserved Variable Names Not Documented

**What I was trying to do:**
Create a function that returns a response by storing data in a variable named `$response`.

**What the issue was:**
The validator returned: "'$response' is a reserved variable name and should not be used as a variable."

I then tried `$output` and got the same error. I had to guess variable names until I found one that wasn't reserved.

**Why it was an issue:**
The XanoScript documentation doesn't list which variable names are reserved. This is trial-and-error debugging which wastes time.

**Potential solution (if known):**
- Add a section to the documentation listing all reserved variable names
- Or include this in the quickstart/syntax documentation

---

## [2026-02-14 19:48 PST] - Dynamic Property Access Confusion

**What I was trying to do:**
Access nested properties from the CoinGecko API response using dynamic keys (coin_id and currency variables).

**What the issue was:**
Initially tried to use syntax like `$api_result.response.result[$input.coin_id]` but wasn't sure if that was valid XanoScript. Had to use chained `|get:` filters instead.

**Why it was an issue:**
The documentation shows object access with `|get:"key"` but doesn't clearly show how to use variable keys. I had to guess: `$result|get:($input.coin_id|to_lower)`.

**Potential solution (if known):**
- Add examples of dynamic property access using variables as keys
- Clarify if bracket notation is supported

---

## [2026-02-14 19:52 PST] - MCP Tool Discovery Difficult

**What I was trying to do:**
Find available tools in the Xano MCP server.

**What the issue was:**
Running `mcporter list xano` didn't work (server not configured). There was no easy way to discover the available tools without reading the skill documentation or the task instructions.

**Why it was an issue:**
Had to rely on the task description mentioning `validate_xanoscript` and `xanoscript_docs` rather than discovering them myself.

**Potential solution (if known):**
- Make the MCP tools discoverable via standard mcporter commands
- Or provide a standalone `xano` CLI that lists available commands

---

## Summary

Overall the XanoScript syntax is clean and readable, but the tooling setup and documentation gaps around reserved words made the development process more difficult than necessary. The validation tool worked well once I could access it, catching my variable naming issues immediately.
