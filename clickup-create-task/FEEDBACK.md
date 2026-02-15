# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 09:18 PST] - MCP Tool Discovery and Documentation Access

**What I was trying to do:**
Find and use the Xano MCP to validate XanoScript code, as instructed in the task requirements.

**What the issue was:**
The task mentioned calling `xanoscript_docs` but I had to discover the MCP was available via `mcporter`. The task also mentioned `validate_xanoscript` tool which I found in the MCP listing.

**Why it was an issue:**
The task instructions say "You MUST call `xanoscript_docs` on the xano MCP" but didn't explain how to access the MCP or that it required mcporter. I had to explore to figure out the connection between @xano/developer-mcp package and mcporter CLI.

**Potential solution (if known):**
The task instructions should clarify the workflow: install @xano/developer-mcp, then use `mcporter call --stdio "npx @xano/developer-mcp" <tool_name>` pattern.

---

## [2025-02-15 09:20 PST] - JSON Escaping for Multi-line Code Validation

**What I was trying to do:**
Validate XanoScript code files using the `validate_xanoscript` MCP tool, which requires passing code as a JSON parameter.

**What the issue was:**
The XanoScript code contains newlines, quotes, and special characters that make it extremely difficult to pass through shell command line arguments. Multiple attempts failed:
1. Direct variable substitution - newlines caused parse errors
2. Echo with escaping - quotes and newlines broke JSON
3. Base64 encoding - not supported by the MCP
4. Heredocs - didn't work with mcporter's argument parsing

**Why it was an issue:**
Shell escaping of multi-line code for JSON is notoriously difficult. The error messages from mcporter were cryptic like "Unable to parse --args: Expected ',' or '}' after property value in JSON at position 19"

**Potential solution (if known):**
The MCP could support:
1. Reading code from stdin directly (not just --args)
2. A file path parameter option: `validate_xanoscript(file_path: "./run.xs")`
3. Base64 encoded code parameter with a flag

Workaround that worked: Using `jq -n --arg code "$xs_code" '{code: $code}' | jq -c .` to create compact JSON, then passing with `--args` flag.

---

## [2025-02-15 09:25 PST] - XanoScript Syntax Confusion - json Type Default Values

**What I was trying to do:**
Define input parameters for a function with default empty arrays for optional JSON fields.

**What the issue was:**
This syntax fails validation:
```xs
input {
  json assignee_ids? = []
  json tags? = []
}
```

Error: `[Line 6, Column 26] Expecting: one of these possible Token sequences` with the parser expecting identifiers/strings but finding `[`.

**Why it was an issue:**
The documentation doesn't clearly show what default values are allowed for each input type. I assumed `[]` would work as a default for `json` type since it represents an empty JSON array.

**Potential solution (if known):**
The `types` documentation topic should include a table showing which default values are valid for each input type (text, int, json, boolean, timestamp, etc.).

Workaround: Remove defaults and use `($input.field ?? [])` in the stack instead.

---

## [2025-02-15 09:27 PST] - XanoScript Syntax Confusion - api.request Parameter Names

**What I was trying to do:**
Make an HTTP POST request with a JSON body to the ClickUp API.

**What the issue was:**
I initially used `body` parameter:
```xs
api.request {
  url = $url
  method = "POST"
  body = ($payload|json_encode)
  headers = [...]
}
```

Error: `[Line 73, Column 7] The argument 'body' is not valid in this context`

**Why it was an issue:**
Coming from other HTTP libraries (JavaScript fetch, Python requests, curl), `body` is the intuitive parameter name for request body. XanoScript uses `params` instead, which is counterintuitive.

**Potential solution (if known):**
1. The `quickstart` or `integrations` docs should prominently mention this naming quirk
2. Consider aliasing `body` to work the same as `params` for developer familiarity
3. Better error message: "Did you mean 'params'?" instead of just "not valid"

---

## [2025-02-15 09:28 PST] - XanoScript Reserved Variable Names Not Documented

**What I was trying to do:**
Capture the result of `api.request` in a variable named `$response`.

**What the issue was:**
```xs
api.request { ... } as $response
```

Error: `'$response' is a reserved variable name and cannot be used`

**Why it was an issue:**
`$response` is a very common, intuitive name for API results. The reserved variable names are not listed in the main documentation topics I accessed (syntax, run, tasks).

**Potential solution (if known):**
1. Add a comprehensive list of reserved variable names to the `syntax` documentation
2. Include common reserved names like `$response`, `$request`, `$input`, `$env`, `$result` with explanations of when they're reserved

---

## [2025-02-15 09:29 PST] - XanoScript Filter Expression Parentheses Requirement

**What I was trying to do:**
Check if an array has items using a filter and comparison.

**What the issue was:**
This fails:
```xs
if ($task_tags|count > 0) {
```

Error: `An expression should be wrapped in parentheses when combining filters and tests`

**Why it was an issue:**
The syntax documentation mentions this for string concatenation but not for filter + comparison combinations. I had to discover the fix through trial and error.

**Potential solution (if known):**
Expand the "String Concatenation with Filters" section to cover all cases where parentheses are required:
1. String concatenation with filters
2. Filter results used in comparisons
3. Filter results used in arithmetic

Or make the parser smarter to handle these cases without explicit parentheses.

---

## [2025-02-15 09:30 PST] - Xano MCP Error Messages Lack Line Content

**What I was trying to do:**
Fix syntax errors reported by the validator.

**What the issue was:**
Error messages show line and column but not the actual content of that line:
```
[Line 6, Column 26] Expecting: one of these possible Token sequences...
```

**Why it was an issue:**
Without seeing the actual line content, it's harder to identify the problem quickly, especially when there are multiple similar lines.

**Potential solution (if known):**
Include the line content in error messages:
```
[Line 6, Column 26] near: "json assignee_ids? = []"
Expecting: ...
```

---

## Summary of Key Pain Points

1. **Documentation Discovery**: Finding the right topic names for `xanoscript_docs` required trial and error ("task" didn't work, "tasks" did)

2. **JSON Escaping Hell**: Passing multi-line code through shell to JSON is painful. File-based validation would be much easier.

3. **Inconsistent Naming**: `params` instead of `body` for HTTP request body violates developer expectations from other tools.

4. **Reserved Words**: Common variable names like `$response` being reserved without clear documentation.

5. **Default Value Restrictions**: Not clear what defaults work for which types (can't use `[]` for json default).

6. **Parentheses Rules**: Filter + comparison requires parentheses but this isn't prominently documented.

Overall, the validation tool is helpful, but the developer experience could be significantly improved with better error messages, file-based validation, and more comprehensive syntax documentation with examples for each input type.
