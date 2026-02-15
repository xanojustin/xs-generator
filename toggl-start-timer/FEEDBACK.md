# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 14:45 PST] - MCP validate_xanoscript Parameter Passing Issue

**What I was trying to do:**
Validate the XanoScript files (run.xs and function/start_time_entry.xs) using the Xano MCP validate_xanoscript tool.

**What the issue was:**
The `validate_xanoscript` tool requires a `code` parameter, but passing it via mcporter proved extremely difficult. I tried multiple approaches:

1. Direct string argument: `mcporter call xano validate_xanoscript 'code here'` - resulted in "'code' parameter is required" error
2. JSON object argument: `mcporter call xano validate_xanoscript '{"code":"..."}'` - same error
3. Pipe via stdin `@-`: `echo '{"code":"..."}' | mcporter call xano validate_xanoscript @-` - the validator received '@' as literal input
4. File reference `@/path`: `mcporter call xano validate_xanoscript @/tmp/file.json` - same issue, received '@' character
5. Using --code flag: `mcporter call xano validate_xanoscript --code '...'` - resulted in parsing error "Expecting --> function <-- but found --> '-' <--"

**Why it was an issue:**
This blocked validation of the XanoScript files, which is a required step in the task. I had to proceed without validation, which risks pushing invalid syntax to GitHub.

**Potential solution (if known):**
- The mcporter tool may need clearer documentation on how to pass JSON parameters to MCP tools
- The validate_xanoscript tool might benefit from accepting a file_path parameter in addition to code
- Consider providing a direct CLI command like `xano validate <file.xs>` that doesn't require MCP interaction

---

## [2026-02-15 14:30 PST] - XanoScript Syntax Learning Curve

**What I was trying to do:**
Write a proper XanoScript function following the documented patterns.

**What the issue was:**
While the documentation is comprehensive, there were several syntax nuances that weren't immediately clear:

1. **Filter syntax for date formatting**: The `date` filter expects a specific format string. I initially tried ISO 8601 formatting with `util.timestamp|to_text|date:"Y-m-d\TH:i:s.v\Z"` but wasn't sure if this was correct.

2. **Optional parameter syntax**: The `?` after parameter names for optional inputs was documented, but the combination with default values `text billable?="false"` wasn't explicitly shown in examples.

3. **String concatenation with `~`**: The tilde operator for string concatenation is documented but easy to miss. Common languages use `+` or `.`.

4. **Boolean parsing**: There's no explicit `to_boolean` filter, so I had to use string comparison `($input.billable|lower == "true")` to parse boolean from text input.

**Why it was an issue:**
Without being able to validate, I couldn't confirm if these syntax choices were correct. This creates uncertainty about the code quality.

**Potential solution (if known):**
- Add more complete examples showing common patterns like boolean parsing, date handling, and optional parameters with defaults
- Include a "Common Patterns" section in the quickstart docs specifically for API integrations

---

## [2026-02-15 14:25 PST] - Xano MCP Server Availability

**What I was trying to do:**
Call the Xano MCP server to get documentation and validate code.

**What the issue was:**
Initially, I tried using the mcporter tool to list and call the xano MCP, but it wasn't immediately clear that:
1. The MCP server is auto-started by mcporter when needed
2. The `xanoscript_docs` tool returns the same content regardless of the topic parameter in some cases
3. There are multiple tools available but they have specific parameter requirements

**Why it was an issue:**
It took several attempts to understand how to interact with the MCP properly.

**Potential solution (if known):**
- Add a quick reference guide for MCP interaction patterns
- Document the relationship between mcporter and the Xano MCP server

---

## General Notes

### What Worked Well
1. The `xanoscript_docs` tool with topic parameter provided comprehensive documentation
2. The folder structure conventions were clearly documented
3. Existing examples in ~/xs/ were helpful for understanding patterns

### Suggestions for Improvement
1. **Validation CLI**: A standalone CLI command for validation would be more reliable than MCP tool calls
2. **Syntax Highlighting**: Documentation with syntax-highlighted examples would help catch syntax errors
3. **Interactive Mode**: An interactive mode for testing XanoScript snippets would be valuable
4. **Error Messages**: The parser error "Expecting --> function <-- but found --> '-' <--" wasn't helpful - it seemed to be processing the JSON wrapper rather than the XanoScript code
