# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 02:15 PST] - MCP Server Connection Issues

**What I was trying to do:**
Validate XanoScript files using the Xano MCP's `validate_xanoscript` tool.

**What the issue was:**
The `mcporter call xano validate_xanoscript` command returned "Unknown MCP server 'xano'" error, even though `mcporter list` showed the xano server as healthy with 6 tools.

**Why it was an issue:**
This blocked validation entirely until I discovered the workaround using `--stdio` mode.

**Potential solution (if known):**
The daemon mode seems to have issues. The `--stdio` workaround works but is slower. Consider investigating daemon stability or defaulting to stdio mode when daemon fails.

---

## [2025-02-15 02:18 PST] - Validation Tool Parameter Confusion

**What I was trying to do:**
Validate XanoScript files by passing file paths to the MCP.

**What the issue was:**
Initially tried `file="$(pwd)/run.xs"` parameter but the `validate_xanoscript` tool only accepts a `code` parameter containing the actual code content as a string, not a file path.

**Why it was an issue:**
Had to read the schema documentation using `mcporter list xano --schema` to understand the correct parameter is `code` not `file`. This added extra discovery time.

**Potential solution (if known):**
The MCP could support both `file` and `code` parameters - if `file` is provided, read the file content. This would be more user-friendly for CLI workflows.

---

## [2025-02-15 02:20 PST] - Command Line Escaping Hell

**What I was trying to do:**
Pass multi-line XanoScript code through command line arguments for validation.

**What the issue was:**
When passing code with `//` comments via shell command line, the comments appear to get stripped or cause parsing issues. The validator returned:
```
Found 1 error(s):
1. [Line 3, Column 1] Expecting --> run <-- but found --> '' <---
```

Removing the comments made it validate successfully.

**Why it was an issue:**
Shell escaping of newlines and special characters is notoriously difficult. Had to strip comments from the validation call even though they're valid XanoScript syntax.

**Potential solution (if known):**
1. Support file path parameter (as mentioned above)
2. Or provide a CLI tool that can be called as `xano validate file.xs` that handles reading and encoding properly
3. Or document a recommended pattern for shell-based validation

---

## [2025-02-15 02:22 PST] - Lack of Clear MCP Tool Documentation

**What I was trying to do:**
Understand how to properly call the MCP validation tools.

**What the issue was:**
The `xanoscript_docs` function exists in the MCP but returns general XanoScript documentation, not MCP-specific usage instructions. There's no `mcp_docs` or tool usage documentation.

**Why it was an issue:**
Had to discover through trial and error that:
1. Daemon mode doesn't work reliably
2. `--stdio` mode is required
3. The exact parameter format for validate_xanoscript

**Potential solution (if known):**
Add an `mcp_docs` tool that documents how to use the MCP tools themselves, including examples of calling validate_xanoscript with proper escaping.

---

## [2025-02-15 02:25 PST] - Documentation Gap on Error Handling in api.request

**What I was trying to do:**
Implement proper error handling for external API calls using `api.request`.

**What the issue was:**
The documentation shows `api.request` with `as $result` but doesn't clearly document:
1. The exact structure of the response object ($result.response.status, $result.response.result)
2. Best practices for checking HTTP status codes
3. How to handle different error scenarios (network vs HTTP error vs parse error)

**Why it was an issue:**
Had to infer the response structure from examples rather than a clear schema. Used trial and error to understand that:
- `$api_result.response.status` contains HTTP status code
- `$api_result.response.result` contains parsed JSON response

**Potential solution (if known):**
Add a dedicated `api.request` documentation section with:
- Complete response object schema
- Common error handling patterns
- Examples for different HTTP methods and content types

---

## Summary

The Xano MCP is functional but has rough edges around:
1. **Stability**: Daemon mode reliability issues
2. **Usability**: File-based validation would be much easier than string-based
3. **Documentation**: Need MCP-specific usage docs, not just XanoScript language docs
4. **Tool Design**: Parameter naming and structure could be more intuitive

The `--stdio` workaround with `mcporter call --stdio 'npx -y @xano/developer-mcp@1.0.34'` is functional but slower and more verbose than it should be.
