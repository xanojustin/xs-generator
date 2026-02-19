# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 12:10 PST] - MCP Tool Discovery

**What I was trying to do:** Access the Xano MCP server to get XanoScript documentation before writing code

**What the issue was:** The `xanoscript_docs` command was not in my PATH. I had to discover the correct binary location at `/opt/homebrew/bin/xano-developer-mcp` and learn how to communicate with it via JSON-RPC over stdio.

**Why it was an issue:** The subagent instructions mentioned calling `xanoscript_docs` but didn't provide details on how to actually invoke the MCP server. I had to figure out the JSON-RPC protocol and manually construct requests.

**Potential solution (if known):** 
- Document the MCP server invocation pattern in the subagent instructions
- Consider providing a wrapper script or alias for common MCP operations
- The MCP server could expose a simpler CLI interface alongside the stdio JSON-RPC interface

---

## [2026-02-19 12:12 PST] - Successful First-Pass Validation

**What I was trying to do:** Validate my first XanoScript run job and function

**What the issue was:** No issues! Both files passed validation on the first attempt.

**Why it was an issue:** N/A - success case

**Potential solution (if known):** N/A

**Positive feedback:** The `validate_xanoscript` MCP tool worked perfectly and provided clear results. The documentation from `xanoscript_docs` was comprehensive and helped me write correct code on the first try.

---

## [2026-02-19 12:13 PST] - Documentation Quality

**What I was trying to do:** Understand the correct syntax for run.job and function primitives

**What the issue was:** No issues - the documentation was excellent and included clear examples of exactly what I needed to build.

**Why it was an issue:** N/A - the docs were great

**Potential solution (if known):** The documentation quality is high. The quick reference sections are particularly useful for getting started quickly.

---

## Summary

Overall experience was very positive. The main friction was discovering how to invoke the MCP server, but once that was figured out, everything worked smoothly. The validation tool is fast and accurate, and the documentation is comprehensive enough to write correct code on the first attempt.
