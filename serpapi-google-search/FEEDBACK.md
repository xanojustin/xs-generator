# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 14:20 PST] - Documentation Discovery Issue

**What I was trying to do:**
Find the correct XanoScript syntax for iterating through arrays and URL encoding strings.

**What the issue was:**
The initial documentation from `xanoscript_docs` didn't include specific filter names like `url_encode` or the correct loop syntax (`foreach` + `each`). I initially tried `urlencode` (no underscore) and `loop` keyword, both of which failed validation.

**Why it was an issue:**
Had to discover the correct syntax by reading existing implementation files in the ~/xs folder rather than having clear documentation available through the MCP. The quickstart guide mentioned `each` but didn't show the full `foreach...each` pattern.

**Potential solution:**
Include a complete list of available filters and their exact syntax in the quickstart or syntax documentation. Also document the `foreach ($array) { each as $item { ... } }` pattern more clearly.

---

## [2025-02-15 14:22 PST] - Array Append Filter Name

**What I was trying to do:**
Append items to an array while iterating through search results.

**What the issue was:**
Initially used `|append:` filter but the validator indicated this doesn't exist. Had to discover that the correct filter is `|push:` by examining other implementation files.

**Why it was an issue:**
Inconsistent naming - many languages use `append`, XanoScript uses `push`. The documentation doesn't clearly list array manipulation filters.

**Potential solution:**
Add a clear table of array filters (`push`, `pop`, etc.) in the quickstart or syntax documentation.

---

## [2025-02-15 14:25 PST] - MCP Server Connection Intermittency

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` MCP tool.

**What the issue was:**
The MCP server connection was intermittent - sometimes showing "Unknown MCP server 'xano'" error. The issue seemed related to the working directory - mcporter only found the config when running from `~/.openclaw/workspace/`.

**Why it was an issue:**
Validation would fail unexpectedly depending on which directory the command was run from. Had to navigate to the workspace directory each time.

**Potential solution:**
Make mcporter config discovery more robust or document that commands should be run from the workspace root. Alternatively, use a global config or environment variable to locate the MCP config.

---

## [2025-02-15 14:27 PST] - JSON Escaping Complexity for Validation

**What I was trying to do:**
Pass XanoScript code content to the validate_xanoscript tool via mcporter.

**What the issue was:**
The `code` parameter requires properly escaped JSON. Shell command escaping made this extremely difficult - newlines, quotes, and special characters all needed careful handling. The `--args` flag expects inline JSON which is fragile with multi-line code.

**Why it was an issue:**
Had to resort to writing to a temp file and using Node.js to properly JSON-escape the content. This added significant complexity to what should be a simple validation step.

**Potential solution:**
1. Accept a file path parameter in addition to `code`
2. Or accept raw stdin input
3. Or provide a CLI wrapper that handles the escaping automatically

---

## [2025-02-15 14:28 PST] - Missing Complete Filter Reference

**What I was trying to do:**
Find a complete list of all available filters in XanoScript.

**What the issue was:**
The documentation only shows "Common Filters" in the syntax quick reference. There's no comprehensive list of all available filters like `url_encode`, `push`, `json_encode`, etc.

**Why it was an issue:**
Had to grep through existing codebases to discover available filters. Trial and error with the validator is inefficient.

**Potential solution:**
Provide a comprehensive filter reference document or add a `list_filters` tool to the MCP that returns all available filters with descriptions.

---

## [2025-02-15 14:30 PST] - Variable Reassignment Confusion

**What I was trying to do:**
Update variables conditionally within the stack (e.g., setting `$success = true` after API success).

**What the issue was:**
The pattern of declaring `var $var { value = ... }` and then later trying to reassign with `var.update` or redeclaring `var $var { value = ... }` was unclear. Initially tried redeclaring the same variable name which may or may not work.

**Why it was an issue:**
The documentation shows `var.update` in one example but doesn't clearly explain when to use `var` vs `var.update` vs just reassigning. The examples in existing files showed inconsistent patterns.

**Potential solution:**
Clarify variable scoping and reassignment rules in the quickstart guide with explicit examples showing:
1. Initial declaration
2. Updating existing variables  
3. Variable shadowing rules

---

## General Feedback Summary

**What worked well:**
- The `validate_xanoscript` tool caught syntax errors with helpful line/column numbers
- The documentation structure with topics is good
- Examples in the quickstart were helpful once found

**What needs improvement:**
1. Complete filter/function reference
2. More comprehensive code examples for common patterns
3. Better MCP tool ergonomics (file path support, stdin support)
4. Consistent mcporter config discovery
5. Clearer variable scoping/reassignment documentation

**Suggested MCP additions:**
- `list_filters` - Return all available filters
- `list_functions` - Return all built-in functions
- `validate_xanoscript_file` - Accept file path instead of code content
- `format_xanoscript` - Auto-format XanoScript code
