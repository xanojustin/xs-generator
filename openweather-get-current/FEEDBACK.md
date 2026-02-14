# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 20:17 PST] - MCP Tool Parameter Confusion

**What I was trying to do:**
Validate XanoScript files using the Xano MCP's validate_xanoscript tool.

**What the issue was:**
The initial error said "'code' parameter is required" but the documentation didn't clearly indicate that I should pass the file content as a `code` parameter rather than using a `file_path` parameter.

**Why it was an issue:**
I first tried passing `file_path` thinking it would read the file, but the tool expects the actual code content to be passed directly. This is a common pattern mismatch - many validation tools accept file paths.

**Potential solution (if known):**
Update the MCP tool schema or documentation to clarify that `code` should contain the actual XanoScript content, not a file path. Alternatively, support both `code` and `file_path` parameters for convenience.

---

## [2025-02-13 20:18 PST] - Documentation Topic Errors

**What I was trying to do:**
Get specific documentation topics like "quickstart" and "integrations" using xanoscript_docs.

**What the issue was:**
Both topics returned: "Error reading XanoScript documentation: p.split is not a function"

**Why it was an issue:**
This appears to be a JavaScript/runtime error in the MCP server itself. The general documentation (with no topic parameter) worked fine, but specific topics failed with an internal error.

**Potential solution (if known):**
Check the MCP server's topic routing/handling code. The error suggests a string split operation is being called on something that's not a string (possibly undefined or an object).

---

## [2025-02-13 20:15 PST] - Limited API Request Examples

**What I was trying to do:**
Find examples of GET requests with query parameters (not POST with body).

**What the issue was:**
The documentation primarily shows POST examples with `params` as the request body. It wasn't immediately clear how to construct a GET request with URL query parameters.

**Why it was an issue:**
For OpenWeatherMap, I needed to build a URL with query string parameters (?q=city&appid=key&units=metric). I had to infer the pattern from the concatenation examples.

**Potential solution (if known):**
Add explicit examples for GET requests with query parameters. Show both approaches:
1. Building URL manually with string concatenation
2. Using a params object that gets serialized (if this feature exists)

---

## [2025-02-13 20:16 PST] - Variable Shadowing Clarification

**What I was trying to do:**
Understand if I can redeclare variables in different conditional blocks.

**What the issue was:**
The documentation shows `var $success` being declared multiple times in different conditional branches. I wasn't sure if XanoScript allows variable redeclaration or if this creates a new scope.

**Why it was an issue:**
In many languages, declaring a variable twice in the same scope causes an error. I had to assume XanoScript handles this either through block scoping or by allowing shadowing.

**Potential solution (if known):**
Clarify the scoping rules in the syntax documentation. Specifically document whether:
- Conditional blocks create new scopes
- Variables can be redeclared
- The `var.update` operation is required vs just `var`

---

## [2025-02-13 20:14 PST] - URL Encoding Filter

**What I was trying to do:**
Properly encode a city name for use in a URL query parameter.

**What the issue was:**
I found `url_encode` filter in the documentation, but wasn't sure if it handles spaces as `%20` or `+`, and whether it handles special characters properly.

**Why it was an issue:**
City names can have spaces (e.g., "New York", "San Francisco") and special characters. Proper encoding is critical for API calls.

**Potential solution (if known):**
Document the exact behavior of `url_encode` - what encoding standard it follows (RFC 3986, etc.) and how it handles various edge cases.

---
