# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 02:17 PST] - MCP Tool Parameter Passing Issue

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` tool from the Xano MCP.

**What the issue was:**
The `mcporter call` command doesn't accept the `--code` parameter in the expected way. Multiple attempts failed:
- `mcporter call xano.validate_xanoscript --code "..."` - Error: 'code' parameter is required
- `mcporter call xano.validate_xanoscript --code @file.xs` - Parser error
- Piping JSON via stdin didn't work

**Why it was an issue:**
This blocked validation for a significant amount of time until I discovered the `--args` flag with JSON payload.

**Potential solution (if known):**
Better documentation on how to pass complex parameters to MCP tools via mcporter. The `--args` approach works but isn't immediately obvious.

---

## [2026-02-14 02:22 PST] - Reserved Variable Name '$response'

**What I was trying to do:**
Create a variable named `$response` to hold the API response data before assigning it to the function's `response` output.

**What the issue was:**
The validator reported: `'$response' is a reserved variable name and should not be used as a variable.`

**Why it was an issue:**
This wasn't documented in the syntax reference I retrieved. I had to rename my variable to `$result_response`.

**Potential solution (if known):**
Document reserved variable names in the syntax/quickstart documentation. Common reserved names like `$response`, `$input`, `$auth`, `$env` should be listed.

---

## [2026-02-14 02:25 PST] - Conditional Block Variable Scope Issue

**What I was trying to do:**
Set a variable inside a `conditional` block and use it in the final `response` expression.

**What the issue was:**
My first approach used `var.update` inside conditional branches, but this caused syntax errors. The validator reported issues with newlines and expected tokens.

**Why it was an issue:**
The documentation doesn't clearly explain how to handle variables that need to be set conditionally and then used outside the conditional block.

**Potential solution (if known):**
Document the pattern for conditional response building. The solution I found was to:
1. Do all error handling in conditionals (throwing if needed)
2. Set variables in the main stack flow
3. Reference those variables directly in the final `response` expression

---

## [2026-02-14 02:30 PST] - api.request params Parameter Naming

**What I was trying to do:**
Make an HTTP POST request with a request body.

**What the issue was:**
The documentation notes: `The params parameter is used for the request body (POST/PUT/PATCH), not query parameters. This naming is counterintuitive...`

**Why it was an issue:**
This is confusing naming. Most developers expect `params` to mean query parameters, not request body.

**Potential solution (if known):**
Consider adding an alias like `body` for the same functionality, or improve the documentation to make this more prominent.

---

## [2026-02-14 02:35 PST] - String Concatenation with Filters Documentation Gap

**What I was trying to do:**
Concatenate strings that use filters, like: `"Bearer " ~ $env.DROPBOX_ACCESS_TOKEN`

**What the issue was:**
The syntax documentation mentions wrapping filtered expressions in parentheses, but this wasn't immediately clear when building HTTP headers array.

**Why it was an issue:**
Had to experiment to find the correct syntax for header string construction.

**Potential solution (if known):**
Add more examples showing string concatenation in real-world contexts like building API headers.

---

## [2026-02-14 02:40 PST] - Missing Tool for File Reading

**What I was trying to do:**
Read the content of .xs files to pass to the validation tool.

**What the issue was:**
There was no straightforward way to read file content and pass it to the MCP tool within the OpenClaw context. Had to use Python as a workaround.

**Why it was an issue:**
Added extra steps to the validation process.

**Potential solution (if known):**
Consider adding a `--file` parameter to the validate_xanoscript tool, or support `@filename` syntax to read code from files directly.

---

## Summary

The XanoScript language itself is well-designed and the documentation is comprehensive. The main friction points were:

1. **MCP tooling UX**: Parameter passing to mcporter could be more intuitive
2. **Reserved keywords**: Need a documented list of reserved variable names
3. **Conditional patterns**: Need clearer examples of conditional variable assignment

Overall validation is very helpful and caught real issues that would have caused runtime errors.
