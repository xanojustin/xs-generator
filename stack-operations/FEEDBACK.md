# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 05:32 PST] - Negative array indices not supported

**What I was trying to do:** Implement a stack "pop" operation that removes the last element from an array.

**What the issue was:** I tried to use `$stack|slice:0,-1` to get all elements except the last one (similar to JavaScript/Python slice syntax), but XanoScript doesn't support negative indices.

**Why it was an issue:** The validation error message was clear but didn't explain what the correct alternative was. I had to look at other examples to understand the proper syntax.

**Potential solution (if known):** 
- Document that negative indices are not supported in the slice filter documentation
- Consider adding support for negative indices (or at least `-1` for "last element")
- Provide a clearer error message suggesting to calculate the index manually

---

## [2025-02-19 05:32 PST] - MCP server connection intermittent

**What I was trying to do:** Validate XanoScript code using the MCP server.

**What the issue was:** The MCP server connection was intermittent. Sometimes `mcporter call xano.validate_xanoscript` worked, sometimes it returned "Unknown MCP server 'xano'".

**Why it was an issue:** Had to retry multiple times to get validation results, slowing down the development loop.

**Potential solution (if known):** 
- This might be a local environment issue with mcporter or the MCP server
- Consider adding retry logic or better error handling in the CLI
