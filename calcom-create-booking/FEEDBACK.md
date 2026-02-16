# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 22:52 PST] - Object Type Syntax Documentation Gap

**What I was trying to do:**
Define a nested object input parameter for the `attendee` field in a function input block.

**What the issue was:**
I initially wrote:
```xs
object attendee {
  text name
  text email
  text time_zone
}
```

This caused a parse error: `[Line 6, Column 7] Expecting --> } <-- but found --> 'text' <--`

**Why it was an issue:**
The Quick Reference in the types documentation didn't show the proper syntax for defining object schemas with nested fields. I had to read the full documentation to find that objects require a `schema` block:

```xs
object attendee {
  schema {
    text name
    text email
    text time_zone
  }
}
```

**Potential solution:**
Add an example of object schema syntax to the Quick Reference section in the types documentation. The Quick Reference currently only shows primitive types and modifiers but lacks the object/array schema examples.

---

## [2026-02-15 22:55 PST] - Invalid error_type Value

**What I was trying to do:**
Create a precondition for missing environment variables with a descriptive error type.

**What the issue was:**
I used `error_type = "configuration"` thinking it was a valid error type, but got this validation error:

```
Expected value of `error_type` to be one of `standard`, `notfound`, `accessdenied`, `toomanyrequests`, `unauthorized`, `badrequest`, `inputerror`
```

**Why it was an issue:**
The documentation mentions these error types exist but doesn't explain when to use each one. I guessed "configuration" would be appropriate for missing env vars, but it's not in the allowed list.

**Potential solution:**
1. Add "configuration" as a valid error type for environment/configuration errors
2. Or document the mapping of error scenarios to error types in the syntax/quickstart docs

---

## [2026-02-15 22:56 PST] - Reserved Variable Name Conflict

**What I was trying to do:**
Create a variable named `$response` to hold the response data before returning it.

**What the issue was:**
Got validation error: `'$response' is a reserved variable name and should not be used as a variable.`

**Why it was an issue:**
I wasn't aware `$response` was reserved. The quickstart documentation shows `response = $users` but doesn't explicitly list reserved variable names to avoid.

**Potential solution:**
Add a "Reserved Variables" section to the quickstart or syntax documentation listing all reserved names like `$response`, `$input`, `$env`, `$auth`, `$db`, etc.

---

## [2026-02-15 22:48 PST] - Initial MCP Connection Confusion

**What I was trying to do:**
Start the Xano MCP server to access the xanoscript_docs tool.

**What the issue was:**
Initially tried running `npx @xano/developer-mcp` directly, which completed immediately without staying running. It wasn't clear if the server needed to run continuously or if mcporter handles the lifecycle.

**Why it was an issue:**
I wasn't sure if the MCP server needed to be started as a background daemon or if mcporter manages it automatically. Turns out mcporter handles spawning the MCP server on demand via stdio transport.

**Potential solution:**
Clarify in the MCP documentation that mcporter manages the MCP server lifecycle automatically - users don't need to start it manually.

---

## Summary

Overall the MCP worked well once I understood the workflow:
1. Use `mcporter call xano.xanoscript_docs` to get documentation
2. Use `mcporter call xano.validate_xanoscript` to validate code

The main pain points were:
- Missing quick reference examples for complex types (object schemas)
- Undocumented reserved variable names
- Limited error_type options without clear guidance on usage

The validation tool was extremely helpful and caught errors that would have been hard to debug otherwise!
