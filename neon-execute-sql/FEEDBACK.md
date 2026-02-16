# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 01:18 PST] - Missing error_type values in documentation

**What I was trying to do:**
Create a precondition with an appropriate error type for a runtime error when no compute endpoint is found.

**What the issue was:**
I used `error_type = "runtime"` which is a logical error type name, but the validation failed with:
```
Expected value of `error_type` to be one of `standard`, `notfound`, `accessdenied`, `toomanyrequests`, `unauthorized`, `badrequest`, `inputerror`
```

**Why it was an issue:**
The quickstart documentation shows examples with `error_type = "standard"` and `error_type = "inputerror"`, but doesn't provide a comprehensive list of all valid error types. I had to discover the valid values through trial and error.

**Potential solution (if known):**
Add a section in the quickstart documentation that lists all valid error_type values with descriptions of when to use each one. For example:
- `standard` - General errors
- `notfound` - Resource not found
- `accessdenied` - Permission denied
- `toomanyrequests` - Rate limiting
- `unauthorized` - Authentication failed
- `badrequest` - Invalid request format
- `inputerror` - Input validation failed

---

## [2026-02-16 01:15 PST] - Documentation navigation could be clearer

**What I was trying to do:**
Understand the structure of XanoScript run jobs and functions to create a working implementation.

**What the issue was:**
The documentation is comprehensive but distributed across multiple topics (`run`, `quickstart`, `functions`, `integrations`). It took multiple calls to `xanoscript_docs` with different topics to piece together the complete picture. The `run` topic showed the run.job structure but the function examples were minimal.

**Why it was an issue:**
Had to make 5 separate documentation calls to gather all the needed information:
1. `readme` - Overview
2. `run` - Run job structure
3. `quickstart` - Common patterns
4. `functions` - Function syntax
5. `integrations` - External API patterns

**Potential solution (if known):**
Provide a "complete example" section in the `run` documentation that includes a full working example with:
- run.xs
- function/*.xs files with actual implementation
- table/*.xs if relevant

Or create a `run-complete-example` topic that shows a real-world integration.

---

## [2026-02-16 01:16 PST] - throw statement syntax unclear

**What I was trying to do:**
Throw custom errors when API requests fail.

**What the issue was:**
The documentation shows `throw { name = "...", value = "..." }` but I wasn't sure if both fields are required or what the `name` field is used for (error type identifier? error code?).

**Why it was an issue:**
Had to guess at the throw syntax. The quickstart shows it but doesn't explain the semantics of `name` vs `value` or whether additional fields can be included.

**Potential solution (if known):**
Add a dedicated section on error handling that explains:
- The `throw` statement and its fields
- How `name` and `value` are used in error responses
- Best practices for naming conventions
- How thrown errors interact with try_catch blocks

---

## [2026-02-16 01:17 PST] - api.request response structure not documented

**What I was trying to do:**
Access the response from an external API call (`api.request`).

**What the issue was:**
Had to infer the response structure from examples. It appears to be `$result.response.status` and `$result.response.result` but this isn't explicitly documented in the quickstart.

**Why it was an issue:**
Without knowing the exact structure, I had to guess that:
- HTTP status is at `.response.status`
- Response body is at `.response.result`
- Not sure if headers or other metadata are available

**Potential solution (if known):**
Document the full response structure of `api.request` in the quickstart or integrations section:
```
api.request returns:
{
  response: {
    status: <number>,      // HTTP status code
    result: <any>,         // Parsed JSON response body
    headers?: <object>,    // Response headers (if available)
    raw?: <string>         // Raw response body
  },
  request: { ... },        // Request details (if available)
  timing: { ... }         // Timing info (if available)
}
```

---

## [2026-02-16 01:19 PST] - filter precedence with string concatenation

**What I was trying to do:**
Concatenate strings with filtered values like: `"Error: " ~ $status|to_text`

**What the issue was:**
Initially wrote `"Error: " ~ $status|to_text` without parentheses and it may have caused issues. The quickstart has a note about this but it's easy to miss.

**Why it was an issue:**
The quickstart mentions this under "Common Mistakes" but it could be more prominent. The filter precedence rules aren't fully explained.

**Potential solution (if known):**
Add a "Filter Precedence" section to the syntax documentation that explains:
- Filters bind tighter than concatenation
- Always use parentheses when concatenating filtered values
- Show examples of correct vs incorrect usage

---

## General Observations

**What worked well:**
- The validation tool is excellent - caught my error_type issue immediately
- The `xanoscript_docs` tool provides comprehensive information
- The quickstart patterns are very helpful once found
- The block structure (input/stack/response) is intuitive

**Overall experience:**
The MCP server worked reliably. The main friction was navigating the documentation to find specific syntax details. Once I had the patterns, writing XanoScript was straightforward. The validation tool was the most valuable feature - immediate feedback on syntax errors saved a lot of time.
