# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 12:20 PST] - XanoScript Validator Bug with Blank Lines After Comments

**What I was trying to do:**
Validate XanoScript run.job and function files using the `validate_xanoscript` MCP tool.

**What the issue was:**
The XanoScript validator fails when there are blank lines between comment blocks and the actual code. For example, this fails:

```xs
// ShipStation Create Shipping Label Run Job
// Creates a shipping label via the ShipStation API

run.job "ShipStation Create Shipping Label" {
  ...
}
```

With error: `[Line 3, Column 1] Expecting --> run <-- but found --> '' <--`

But this passes:

```xs
// ShipStation Create Shipping Label Run Job
// Creates a shipping label via the ShipStation API
run.job "ShipStation Create Shipping Label" {
  ...
}
```

**Why it was an issue:**
This forced me to remove all blank lines between header comments and the code definition, which makes the code less readable. Standard coding conventions typically include a blank line between the header comments and the code.

**Potential solution (if known):**
The parser should be updated to handle blank lines between comments and code definitions. This is standard behavior in most programming languages.

---

## [2025-02-15 12:22 PST] - $response is a Reserved Variable Name

**What I was trying to do:**
Create a function that returns a response object. I named my variable `$response` to hold the data before returning it.

**What the issue was:**
The validator reported: `'$response' is a reserved variable name and should not be used as a variable.`

I was using it like this:
```xs
var $response {
  value = { success: true, data: ... }
}
response = $response
```

**Why it was an issue:**
The documentation mentions `$response` is reserved, but it's not obvious that you can't use it as a local variable name within the stack. I had to rename it to `$result`.

**Potential solution (if known):**
The error message is clear, but the documentation could be more explicit about reserved words. Perhaps list all reserved variable names in the quickstart guide.

---

## [2025-02-15 12:18 PST] - JSON Escaping Issues with validate_xanoscript

**What I was trying to do:**
Call the `validate_xanoscript` tool with multi-line XanoScript code.

**What the issue was:**
The MCP tool requires the `code` parameter as a JSON string. Passing multi-line code through shell commands is extremely difficult due to:
1. Newline handling issues
2. Quote escaping problems
3. Shell interpretation of special characters

I tried multiple approaches:
- Direct string passing: Failed due to newline interpretation
- Using `jq` to create JSON: Newlines were escaped as `\n` which the validator didn't like
- Using `JSON.stringify()` in Node.js: Shell still interpreted the newlines

The only working solution was to write a Node.js script that outputs the JSON and then use `$(cat file.json)` with the `--args` flag.

**Why it was an issue:**
This made validation much harder than it should be. It took many attempts to find a working method.

**Potential solution (if known):**
1. Allow the `validate_xanoscript` tool to accept a file path instead of just code
2. Or provide a CLI tool that can validate files directly
3. Or support stdin input for the code

---

## [2025-02-15 12:15 PST] - Throw Syntax Requires No Commas

**What I was trying to do:**
Throw an error with a name and value using the `throw` statement.

**What the issue was:**
I initially wrote:
```xs
throw {
  name = "ValidationError",
  value = "Invalid request"
}
```

But this caused a syntax error. The correct syntax is without commas:
```xs
throw {
  name = "ValidationError"
  value = "Invalid request"
}
```

**Why it was an issue:**
This is different from most languages where object properties are comma-separated. The documentation examples showed this, but it's easy to miss.

**Potential solution (if known):**
The quickstart guide has a "Common Mistakes" section that mentions this, but it could be more prominent. Perhaps include a note in the syntax documentation about the lack of commas in block definitions.

---

## Summary

Overall, the Xano MCP server works well once you understand these quirks. The biggest issues were:

1. **The blank line after comments bug** - This is the most serious as it affects code readability
2. **Validation tool difficulty** - Passing multi-line code is unnecessarily complex
3. **Syntax differences** - Some XanoScript conventions differ from standard programming languages

The documentation is comprehensive but could benefit from:
- A more prominent "Common Pitfalls" section at the top
- A complete list of reserved words
- Clearer examples of correct comment placement
