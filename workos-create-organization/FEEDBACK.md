# FEEDBACK.md - Xano MCP/XanoScript Feedback

## Summary

This run job was created successfully after resolving several validation and tooling issues.

---

## [2025-02-15 16:45 PST] - MCP Server Connection Issues

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool.

**What the issue was:**
The MCP server was not consistently available. Error messages included:
- "Unknown MCP server 'xano'"
- Daemon not running errors

**Why it was an issue:**
Had to restart the daemon multiple times and eventually use `--stdio` mode with `npx -y @xano/developer-mcp` to get validation working.

**Potential solution:**
- Ensure the MCP daemon auto-starts or provide clearer error messages about how to start it
- Document the `--stdio` fallback approach for validation

---

## [2025-02-15 16:50 PST] - Empty Lines After Comments Cause Parse Errors

**What I was trying to do:**
Validate XanoScript files that had empty lines after comments for readability.

**What the issue was:**
The parser returned errors like:
```
[Line 3, Column 1] Expecting --> run <-- but found --> '
' <--
```

This occurred when there was an empty line between the comment block and the code:
```xs
// Comment here

run.job "Name" {  // Empty line above caused error
```

**Why it was an issue:**
Had to remove all empty lines after comments to make the code validate. This reduces readability.

**Potential solution:**
- Allow empty lines between comments and code blocks
- Document this restriction clearly in the syntax guide

---

## [2025-02-15 16:55 PST] - Complex String Concatenation in throw Blocks

**What I was trying to do:**
Create an error message with dynamic content in a throw block:
```xs
throw {
  name = "APIError"
  value = "WorkOS API error: " ~ ($api_result.response.status|to_text) ~ " - " ~ ($api_result.response.result|json_encode)
}
```

**What the issue was:**
The parser expected `}` but found `,` at the position where the string concatenation with filters occurred.

**Why it was an issue:**
Had to extract the expression into a separate variable first:
```xs
var $status_text { value = $api_result.response.status|to_text }
throw {
  name = "APIError"
  value = "WorkOS API error: " ~ $status_text
}
```

**Potential solution:**
- Document that complex expressions in throw value fields need to be pre-computed
- Or fix the parser to handle complex expressions in throw blocks

---

## [2025-02-15 16:48 PST] - Shell Escaping Challenges with Validation

**What I was trying to do:**
Pass multi-line XanoScript code to the MCP validate_xanoscript tool via command line.

**What the issue was:**
Multiple approaches failed:
- Direct `code='...'` with newlines caused escaping issues
- `$(cat file)` stripped newlines
- `base64` encoding wasn't supported by the tool
- `heredoc` approach didn't work with the CLI

**Why it was an issue:**
Had to write a Python script to use JSON-RPC directly to the MCP server over stdio.

**Potential solution:**
- Add a `--file` or `@file` syntax to read code from a file
- Support reading from stdin with `-` or `/dev/stdin`

---

## [2025-02-15 16:30 PST] -elseif vs else if Syntax

**What I was trying to do:**
Use `else if` for conditional branches (common in many languages).

**What the issue was:**
XanoScript requires `elseif` (single word), not `else if`. This is documented in the quickstart but easy to miss.

**Why it was an issue:**
Had to correct syntax after initially writing `else if`.

**Potential solution:**
- The documentation already covers this well in the "Common Mistakes" section
- An auto-formatter or linter could help catch this

---

## General Observations

1. **Documentation is helpful** - The `xanoscript_docs` MCP tool with topics like `run`, `quickstart`, and `integrations` provided good examples.

2. **Validation is essential** - Without the MCP validation tool, it would be very difficult to identify syntax errors since the error messages reference line/column positions.

3. **File structure conventions** - The documentation clearly explains the folder structure (`run.xs`, `function/`, etc.) which made organizing the code straightforward.

---

*Feedback compiled during development of workos-create-organization run job*
