# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 08:35 PST] - MCP Daemon Not Auto-Starting

**What I was trying to do:** Call `validate_xanoscript` tool on the Xano MCP server

**What the issue was:** The mcporter daemon was not running, and when I tried to start it with `mcporter daemon start`, it said "No MCP servers are configured for keep-alive; daemon not started." This was confusing because `mcporter list` showed the xano server.

**Why it was an issue:** I couldn't call the validation tool without the daemon running or using the `--stdio` workaround

**Potential solution (if known):** 
- Better error messaging explaining that stdio-based MCPs don't need the daemon
- Or auto-start the daemon when a tool call is attempted
- Document the `--stdio` flag workaround more prominently

---

## [2025-02-19 08:36 PST] - Unclear Parameter Names for validate_xanoscript

**What I was trying to do:** Validate the XanoScript file

**What the issue was:** The error message said "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" but when I first tried `path="function.xs"` (which seemed natural), it failed. I had to try `file_path="function.xs"` instead.

**Why it was an issue:** The parameter naming is inconsistent - sometimes MCP tools use `path`, sometimes `file_path`. Without a clear schema, this is trial and error.

**Potential solution (if known):**
- Accept both `path` and `file_path` as aliases
- Or provide a clearer error: "Use file_path=..., not path=..."
- The `--schema` flag should show the exact parameter names

---

## [2025-02-19 08:37 PST] - Stdio Transport Requires Manual --stdio Flag

**What I was trying to do:** Use the Xano MCP which is configured as a stdio transport

**What the issue was:** Even though `mcporter config list` showed xano was configured with stdio transport, I had to explicitly use `--stdio "npx @xano/developer-mcp"` instead of just `mcporter call xano.validate_xanoscript`

**Why it was an issue:** The configuration exists but isn't being used automatically. The named reference `xano` doesn't work even though it's configured.

**Potential solution (if known):**
- Make `mcporter call xano.<tool>` work when xano is configured as stdio
- Auto-detect transport type from config and invoke appropriately

---

## General Feedback

The documentation from `xanoscript_docs` was very helpful and comprehensive. The main friction was around:
1. MCP server invocation (daemon vs stdio)
2. Parameter naming conventions
3. Error message clarity

Once I figured out the `--stdio` workaround with the correct `file_path` parameter, validation worked perfectly.
