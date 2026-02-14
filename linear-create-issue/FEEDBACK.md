# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 22:52 PST] - Nested Conditional Parsing Error

**What I was trying to do:**
Create a function with nested conditional blocks to handle different API response scenarios (success, error, GraphQL errors, etc.).

**What the issue was:**
The XanoScript validator rejected code with deeply nested conditionals. Specifically, at line 64, the parser expected `}` but found `,` when using throw inside a nested conditional block:

```xs
conditional {
  if ($api_result.response.status == 200) {
    var $response_data { value = $api_result.response.result }
    conditional {
      if ($response_data.errors != null) {
        throw {
          name = "LinearAPIError",   // Line 64 - parser error here
          value = "GraphQL error: " ~ ($response_data.errors|json_encode)
        }
      }
      else {
        // ... more nested conditionals
      }
    }
  }
}
```

Error: `[Line 64, Column 38] Expecting --> } <-- but found --> , <--`

**Why it was an issue:**
This blocked me from using idiomatic error handling patterns. I had to refactor to use `precondition` statements instead of nested `if/else` conditionals, which is less flexible for complex error handling scenarios.

**Potential solution (if known):**
- Clarify in documentation what the nesting limits are for conditionals
- Or fix the parser to properly handle throw blocks inside nested conditionals
- Document the recommended pattern for complex conditional logic

---

## [2025-02-13 22:45 PST] - MCP Connection Instability

**What I was trying to do:**
Call the Xano MCP validate_xanoscript tool to validate my code.

**What the issue was:**
The MCP server connection was flaky. Running the same command would sometimes fail with "Unknown MCP server 'xano'" and sometimes work. This seemed related to:
1. Current working directory (worked from config folder, failed from elsewhere)
2. Need to explicitly pass `--config` flag for reliable operation

**Why it was an issue:**
Made validation slow and unreliable. Had to debug MCP connection issues before I could focus on actual code validation.

**Potential solution (if known):**
- The MCP should be discoverable regardless of working directory
- Or document that `--config /path/to/mcporter.json` is required for reliable operation

---

## [2025-02-13 22:40 PST] - Shell Escaping Complexity for Code Validation

**What I was trying to do:**
Pass multi-line XanoScript code to the validate_xanoscript tool via mcporter CLI.

**What the issue was:**
Shell escaping of quotes and newlines made it extremely difficult to pass code directly:
- `code="$(cat file.xs)"` - fails with quote issues
- `code='...'` - fails with nested quotes
- Had to use `--args` with JSON and `jq` to properly escape: `--args "$(echo '{}' | jq --arg code "$CODE" '{code: $code}')"`

**Why it was an issue:**
The obvious/intuitive ways to pass code failed. Required arcane shell knowledge to work around.

**Potential solution (if known):**
- Support reading code from stdin: `mcporter call xano.validate_xanoscript code=- < file.xs`
- Or support file path parameter: `mcporter call xano.validate_xanoscript file_path=/path/to/file.xs`
- Document the recommended approach for multi-line code

---

## [2025-02-13 22:35 PST] - Lack of Clear Error Context

**What I was trying to do:**
Understand why my XanoScript was failing validation.

**What the issue was:**
The error message `[Line 64, Column 38] Expecting --> } <-- but found --> , <--` didn't provide enough context to understand:
- What block was being parsed
- Why the parser expected `}` at that position
- Whether it was a syntax error in my code or a parser limitation

**Why it was an issue:**
Had to binary-search my code to find the problematic section. Trial-and-error validation of smaller chunks.

**Potential solution (if known):**
- Include the line content in error messages
- Show parser state (e.g., "while parsing throw block")
- Provide suggestions based on common mistakes

---

## General Observations

**Documentation Quality:**
The xanoscript_docs tool is excellent! Having comprehensive documentation available via MCP is a game-changer. The quickstart and integrations docs were particularly helpful.

**Missing Topics:**
- No documentation on nesting limits for conditionals
- No guidance on error handling patterns (when to use throw vs precondition vs conditional)
- Could use more examples of complex real-world functions

**Workflow Suggestions:**
- A `validate_file` tool that takes a file path would be much easier than passing code strings
- An `init` or `scaffold` tool to create boilerplate run.job/function files
- Better IDE integration (LSP mode for the MCP?) would be amazing
