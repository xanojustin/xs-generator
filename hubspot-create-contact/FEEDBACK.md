# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 01:17 PST] - MCP Parameter Naming Confusion

**What I was trying to do:**
Validate XanoScript files using the Xano MCP `validate_xanoscript` tool.

**What the issue was:**
I initially tried to use `file_path` as the parameter name to validate a file:
```
mcporter call xano.validate_xanoscript file_path="/Users/justinalbrecht/xs/hubspot-create-contact/run.xs"
```

The error returned was: `Error: 'code' parameter is required`

This was confusing because typically validation tools accept a file path. The error message didn't specify what the correct parameter name should be - it just said `code` was required.

**Why it was an issue:**
I had to guess that the parameter was `code` instead of `file_path` or `source` or similar. Most MCP tools for validation work with file paths rather than requiring the raw code content.

**Potential solution (if known):**
1. Accept both `file_path` AND `code` parameters - if file_path is provided, read the file; if code is provided, use it directly
2. Improve the error message to say: "Parameter 'code' is required. Pass the XanoScript source code as a string, or use 'file_path' to validate a file."

---

## [2026-02-14 01:18 PST] - Shell Escaping Issues with Code Parameter

**What I was trying to do:**
Pass multi-line XanoScript code to the validate_xanoscript tool via mcporter CLI.

**What the issue was:**
The XanoScript code contains double quotes, curly braces, and other special characters that make shell escaping difficult. For example:
```xs
text email filters=trim { description = "Contact email address" }
```

When passing this through shell commands, the quotes and braces need to be carefully escaped. I had to switch between double quotes and single quotes to make it work, which is fragile.

**Why it was an issue:**
The validation tool requires the raw code content, but shell escaping makes it error-prone and difficult to work with programmatically. If I had a syntax error in my escaping, the validation might fail incorrectly.

**Potential solution (if known):**
1. Support `file_path` parameter as mentioned above - this would eliminate the need for shell escaping entirely
2. Support stdin input: `cat file.xs | mcporter call xano.validate_xanoscript -`
3. Document the recommended approach for passing multi-line code (e.g., use heredocs or base64 encoding)

---

## [2026-02-14 01:15 PST] - Documentation Discovery

**What I was trying to do:**
Find documentation for the `validate_xanoscript` tool to understand its parameters.

**What the issue was:**
I couldn't find specific MCP tool documentation. The `xanoscript_docs` topic is great for language documentation, but there's no equivalent for MCP tool documentation. I had to discover the `code` parameter through trial and error.

**Why it was an issue:**
Without knowing the exact parameter names, I had to guess and test multiple times. This slows down development when trying to use MCP tools.

**Potential solution (if known):**
1. Add an MCP tool schema endpoint: `xano.tool_schema` that returns parameter documentation for all available tools
2. Include MCP tool documentation in the main `xanoscript_docs` output
3. Support `mcporter list xano --schema` to show detailed parameter info

---

## [2026-02-14 01:16 PST] - No File Path Validation Support

**What I was trying to do:**
Validate files directly without reading them into memory first.

**What the issue was:**
The validation tool only accepts raw code strings, not file paths. For a proper workflow, you typically want to validate files on disk. Currently, you must:
1. Read the file content
2. Escape it for shell
3. Pass it as the `code` parameter

**Why it was an issue:**
This adds unnecessary complexity to the validation workflow. Most other validation tools (eslint, prettier, etc.) accept file paths natively.

**Potential solution (if known):**
Add a `file_path` parameter to `validate_xanoscript`:
```json
{
  "code": "string (optional) - XanoScript source code",
  "file_path": "string (optional) - Path to .xs file to validate"
}
```
At least one of `code` or `file_path` must be provided.

---

## Summary

Overall, the Xano MCP server worked well once I figured out the parameter requirements. The main pain points were:

1. **Parameter discovery** - Had to guess `code` was the parameter name
2. **Shell escaping complexity** - Multi-line code with special characters is hard to pass via CLI
3. **No file path support** - Forces reading and escaping file content manually

The `xanoscript_docs` tool is excellent - very comprehensive and well-organized. The validation tool works correctly once you know how to use it, but the developer experience could be improved with file path support and better parameter documentation.
