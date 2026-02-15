# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 05:48 PST] - MCP Tool Parameter Naming

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool.

**What the issue was:**
The MCP documentation in xanoscript_docs says to use `file` parameter, but the tool actually requires `code` parameter. When I tried to use `file`, I got error: "'code' parameter is required".

**Why it was an issue:**
Had to experiment to figure out the correct parameter name. The documentation didn't match the actual tool signature.

**Potential solution (if known):**
Update the MCP tool documentation to reflect that `code` (string content) is required, not `file` (file path). Or support both parameters.

---

## [2026-02-15 05:50 PST] - JSON Type Default Value Syntax

**What I was trying to do:**
Define an optional JSON input parameter with a default empty object value.

**What the issue was:**
Tried `json data?={}` based on documentation example showing `json settings?={}`, but validation failed with: "Expecting: one of these possible Token sequences... but found: '{'".

**Why it was an issue:**
The default value syntax for JSON types appears to not support inline object notation `{}`. Had to remove the default value and handle null checking in the stack instead.

**Potential solution (if known):**
Either fix the parser to support `={}` default values for JSON types, or update the documentation to show the correct syntax (perhaps use `null` or omit default entirely).

---

## [2026-02-15 05:52 PST] - Object vs JSON Type Confusion

**What I was trying to do:**
Define input parameters for arbitrary JSON objects (template data and provider overrides).

**What the issue was:**
Used `object data?={}` thinking it meant "any object", but `object` type requires a `schema` block defining the structure. The error was cryptic: "Expecting --> { <-- but found --> '=' <--".

**Why it was an issue:**
Confusing difference between `object` (structured schema-required) and `json` (arbitrary JSON). Had to consult the types documentation to understand the difference.

**Potential solution (if known):**
- Better error message explaining that `object` requires a schema block
- Documentation could emphasize that `json` is for unstructured data, `object` for structured
- Maybe add a note in the quickstart about this common confusion

---

## [2026-02-15 05:53 PST] - Multiline Code Validation Requires Shell Escaping

**What I was trying to do:**
Validate .xs files by passing their content to the MCP tool.

**What the issue was:**
When passing code with newlines via command line, the newlines get lost unless carefully escaped. Had to use `jq -Rs` to properly escape the file content for JSON.

**Why it was an issue:**
Simple parameter passing didn't work - code got flattened to single line which broke XanoScript syntax. Required trial and error to find working approach.

**Potential solution (if known):**
Support a `file` parameter that reads from disk, avoiding the need to shell-escape file contents. This would be much more ergonomic for CI/CD and scripts.

---

## [2026-02-15 05:54 PST] - MCP Server Discovery via npx

**What I was trying to do:**
Find and run the Xano MCP server to get documentation.

**What the issue was:**
Had to try multiple approaches before finding `npx -y @xano/developer-mcp@latest`. Initial attempts with `which npx` and other methods didn't immediately reveal how to access the MCP.

**Why it was an issue:**
No clear "getting started" for MCP usage in the documentation I accessed. Had to infer the package name from context.

**Potential solution (if known):**
Add a section in xanoscript_docs output showing exactly how to run the MCP via npx, or provide a `xano` CLI wrapper that handles MCP invocation.

---

## General Notes

- The documentation quality is generally good once you find the right topic
- The `mcporter` tool works well but the parameter mismatch was confusing
- Having validation at all is fantastic - would be even better with file path support
- More examples of common patterns (API integrations especially) would be helpful
