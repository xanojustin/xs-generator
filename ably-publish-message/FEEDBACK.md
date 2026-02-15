# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-15 11:20 PST - Shell Escaping Issues with validate_xanoscript

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` MCP tool by passing the code content as a parameter.

**What the issue was:**
The `validate_xanoscript` tool only accepts a `code` string parameter, which requires passing multi-line XanoScript code through the shell. This caused multiple escaping issues:
1. Double quotes in the code conflicted with shell double quotes
2. The `&&` operator was interpreted by the shell as a command separator
3. Newlines and special characters needed careful escaping

**Why it was an issue:**
Simple `mcporter call xano.validate_xanoscript code="..."` commands failed because:
- The shell would interpret `$variables` before passing to the tool
- Quotes would break the command structure
- Special characters like `&&` would be interpreted as shell operators

**Potential solution:**
- Add a `file_path` parameter alternative to `validate_xanoscript` so we can pass a file path instead of raw code content
- Or provide a helper that reads the file and validates it internally
- Document the recommended way to validate files (e.g., using jq + temp files as I eventually did)

**Workaround used:**
```bash
CODE=$(cat /path/to/file.xs)
echo '{"code": ""}' | jq --arg code "$CODE" '.code = $code' > /tmp/validate.json
mcporter call xano.validate_xanoscript --args "$(cat /tmp/validate.json)"
```

---

## 2026-02-15 11:25 PST - Confusion Between `object` and `json` Types

**What I was trying to do:**
Define an input parameter that accepts arbitrary JSON data for the message payload.

**What the issue was:**
I initially used `object data` as the input type, but got a cryptic parser error: "Expecting { but found ' " at a line that looked correct.

**Why it was an issue:**
The distinction between `object` (nested schema) and `json` (arbitrary JSON) types wasn't immediately clear from the error message. The error pointed to the wrong location, making debugging difficult.

**Potential solution:**
- Improve error messages for type-related issues to suggest the correct type
- Add validation in the language server to catch `object` types without schema definitions
- Document the common pattern: use `json` for API payloads, `object` for structured nested data

---

## 2026-02-15 11:28 PST - `$response` is a Reserved Variable Name

**What I was trying to do:**
Create a variable named `$response` to store the API response data before returning it.

**What the issue was:**
Got error: "'$response' is a reserved variable name and should not be used as a variable."

**Why it was an issue:**
While the documentation mentions `$response` is reserved, it's easy to forget when writing code. The error was clear, but it would be helpful to have a comprehensive list of reserved variable names.

**Potential solution:**
- Include a definitive list of all reserved variable names in the syntax documentation
- Consider prefixing reserved names with something like `$__` or `$_` to make them more obviously special

---

## 2026-02-15 11:30 PST - String Concatenation in throw Statements

**What I was trying to do:**
Create a descriptive error message using string concatenation with the `~` operator inside a `throw` block.

**What the issue was:**
Code like this caused parse errors:
```xs
throw {
  name = "APIError",
  value = "Status: " ~ ($status|to_text) ~ ", Result: " ~ ($result|json_encode)
}
```

**Why it was an issue:**
The parser seemed to struggle with complex concatenation expressions in throw statements. The error message was unclear about what exactly was wrong.

**Potential solution:**
- Clarify the exact syntax allowed for throw statement values
- Provide better error messages for throw statement syntax errors
- Consider supporting simpler string interpolation syntax

**Workaround used:**
Simplified throw statements without concatenation, or pre-computed the error message in a variable before throwing.

---

## 2026-02-15 11:32 PST - MCP Tool Discovery

**What I was trying to do:**
Understand what tools were available and their parameters.

**What the issue was:**
Had to run `mcporter list xano --schema` to discover the full tool list and parameters, but this wasn't immediately obvious.

**Why it was an issue:**
The initial task instructions didn't specify how to discover available MCP tools or that I needed to check the schema for parameter details.

**Potential solution:**
- Include a brief "Getting Started with Xano MCP" guide in the xanoscript_docs
- Add an `xano.help` or `xano.tools` command that lists available tools

---

## General Observations

1. **Documentation Quality**: The `xanoscript_docs` tool is excellent and provides comprehensive documentation. The quickstart guide was particularly helpful.

2. **Validation is Critical**: The validation tool caught several issues that would have been hard to debug at runtime. Making it easier to validate files would improve the developer experience significantly.

3. **Error Messages**: Some error messages were cryptic or pointed to wrong locations. Improving parser error messages would help developers fix issues faster.

4. **Type System**: The distinction between `json` and `object` types, while technically correct, could be clearer in the documentation with more examples of when to use each.

---

*Feedback compiled during the development of the ably-publish-message run job.*
