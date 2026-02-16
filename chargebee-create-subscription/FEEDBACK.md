# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 20:45 PST] - MCP Validation Tool Connectivity Issues

**What I was trying to do:**
Validate the XanoScript files (run.xs and function/create_subscription.xs) using the Xano MCP validate_xanoscript tool.

**What the issue was:**
The validate_xanoscript tool has significant issues when passing multi-line code via the `code` parameter:

1. When passing code directly with newlines via shell arguments, the MCP server connection fails with "Unknown MCP server 'xano'"
2. When trying to use JSON-formatted arguments with `--args`, escaping becomes extremely difficult
3. The validation works for simple one-line examples but fails for real-world multi-line XanoScript files

Example of what fails:
```bash
mcporter call xano validate_xanoscript --args '{"code":"run.job ... multi-line code ..."}'
# Results in: [mcporter] Unknown MCP server 'xano'.
```

**Why it was an issue:**
This blocked proper validation of the XanoScript files. I had to manually verify the syntax by comparing against working examples (like stripe-charge-customer) instead of using the automated validation tool.

**Potential solution (if known):**
- Accept a `file_path` parameter in addition to `code` to read directly from disk
- Support base64-encoded code parameter to avoid escaping issues
- Fix the MCP server to handle multi-line string parameters without disconnecting
- Provide a direct CLI command like `xano validate <file.xs>` that doesn't require MCP

---

## [2026-02-15 20:50 PST] - Documentation Formatting Inconsistencies

**What I was trying to do:**
Understand the exact syntax for run.job files by reading existing examples.

**What the issue was:**
The Stripe example's run.xs file has inconsistent indentation - mixing 2-space and what appears to be mixed tabs/spaces. This made it harder to understand the exact required formatting:

```xs
run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {
      amount: "2000"
```

vs my implementation which I tried to make consistent.

**Why it was an issue:**
XanoScript seems sensitive to proper brace placement and structure. Without clear formatting guidelines, it's easy to introduce subtle syntax errors.

**Potential solution (if known):**
- Provide a formatter/linter tool for XanoScript
- Add formatting guidelines to the documentation
- Include a `.editorconfig` or similar in example repositories

---

## [2026-02-15 20:55 PST] - Input Parameter Optional Syntax Confusion

**What I was trying to do:**
Create optional input parameters with default values (e.g., `text currency?="usd")` and optional nullable types (e.g., `text? customer_id`).

**What the issue was:**
The documentation mentions optional parameters but the exact syntax for different patterns is scattered:
- Optional with default: `text currency?="usd"`
- Optional nullable: `text? customer_id`
- Optional integer: `integer? trial_days`

I had to search through multiple examples to understand which pattern to use when.

**Why it was an issue:**
Without a clear reference, I initially wasn't sure if I should use `text?` or `text` with a conditional check in the stack, or if `integer?` was even valid syntax.

**Potential solution (if known):**
- Add a comprehensive input parameter syntax reference table showing all modifiers:
  - Required vs optional (`?`)
  - Default values (`="value"`)
  - Filters (`filters=trim`)
  - Type-specific options

---

## [2026-02-15 21:00 PST] - api.request Response Structure Unclear

**What I was trying to do:**
Parse the response from the Chargebee API call to extract subscription and customer data.

**What the issue was:**
While the documentation shows basic `api.request` usage, the exact structure of the response object isn't clearly documented. I had to infer from examples that:
- `$api_result.response.status` contains the HTTP status code
- `$api_result.response.result` contains the parsed JSON body
- Error responses also come through `response.result` with an `errors` array

**Why it was an issue:**
I wasn't sure if:
1. The response body would be automatically parsed from JSON
2. Whether to access `$api_result.body` or `$api_result.response.result`
3. How to handle different content types (JSON vs form-encoded responses)

**Potential solution (if known):**
- Document the exact response structure for `api.request`
- Clarify automatic parsing behavior for different content types
- Provide a complete example showing request + response handling with error cases

---

## Summary

Overall, the XanoScript language is intuitive and the documentation provides good examples, but the tooling (specifically MCP validation) has significant friction points:

1. **MCP validation tool** - Cannot handle multi-line code input reliably
2. **Documentation organization** - Input parameter syntax and response structures could be more clearly documented
3. **Formatting standards** - No clear guidelines on code formatting/style

The language itself is clean and the patterns are consistent once learned. The main blockers are tooling and documentation completeness.
