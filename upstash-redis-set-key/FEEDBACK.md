# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 06:47 PST] - MCP Tool Parameter Documentation

**What I was trying to do:**
Validate XanoScript files using the MCP's `validate_xanoscript` tool.

**What the issue was:**
The MCP returned an error: `Error: 'code' parameter is required`. I initially tried passing `file_path` as the parameter, thinking it would read the file, but the tool actually requires the `code` parameter containing the actual source code content.

**Why it was an issue:**
This was confusing because many MCP tools work with file paths. I had to read the file content and pass it as a JSON string, which required additional shell scripting with `jq` to properly escape the content.

**Potential solution (if known):**
- Update the MCP tool description to clearly state that `code` (the source code string) is required, not `file_path`
- Optionally support both `code` and `file_path` parameters for convenience
- Provide examples in the tool description showing how to use `jq` or similar tools to pass file contents

---

## [2025-02-15 06:52 PST] - Reserved Variable Names Error

**What I was trying to do:**
Create a function that returns a response object. I initially named my response variable `$response`, then tried `$output`.

**What the issue was:**
Both variable names were rejected with errors:
- `'$response' is a reserved variable name and should not be used as a variable.`
- `'$output' is a reserved variable name and cannot be used`

**Why it was an issue:**
The documentation mentions that `$response` is reserved, but it doesn't provide a comprehensive list of all reserved variable names. I had to guess and check to find a valid name (`$api_result` eventually worked). This is time-consuming and frustrating.

**Potential solution (if known):**
- Document ALL reserved variable names in the syntax documentation
- Provide suggestions for alternative naming conventions in the error messages
- Consider allowing `$response` in function blocks since it's scoped locally anyway

---

## [2025-02-15 06:45 PST] - MCP Server Startup Time

**What I was trying to do:**
Call the `xanoscript_docs` tool to get documentation before writing code.

**What the issue was:**
The initial command `npx -y @xano/developer-mcp@latest --help` took a long time and seemed to hang. I had to kill the process and try a different approach.

**Why it was an issue:**
The MCP server takes time to start up via npx, and there was no indication of whether it was working or frozen. This made it unclear if I should wait or try something else.

**Potential solution (if known):**
- Add a progress indicator or startup message when the MCP server initializes
- Consider documenting expected startup times
- Provide a way to keep the MCP server running as a daemon for repeated use

---

## [2025-02-15 06:48 PST] - Documentation Discovery

**What I was trying to do:**
Find the correct syntax for creating a run job.

**What the issue was:**
The main `xanoscript_docs` documentation is comprehensive but finding specific topics requires knowing the exact topic names. I had to call the tool multiple times with different topic parameters (`run`, `quickstart`, `integrations`) to get all the information I needed.

**Why it was an issue:**
There's no way to list available topics or search the documentation. I had to guess topic names based on the index shown in the initial response.

**Potential solution (if known):**
- Add a `list_topics` or `search_docs` tool to the MCP
- Include all available topics in the main documentation index
- Add keywords/tags to documentation topics for easier discovery

---

## General Notes

### What Worked Well
- The documentation is comprehensive and well-structured once accessed
- The validation tool provides specific line numbers and column positions for errors
- The `xanoscript_docs` tool covers a wide range of topics
- The syntax is intuitive for most common operations (conditionals, API requests, etc.)

### Suggestions for Improvement
1. **Reserved words list**: Provide a complete list of reserved variable names upfront
2. **Tool parameter clarity**: Make it clear which parameters are required and what format they expect
3. **Error message improvements**: Suggest valid alternatives in error messages (e.g., "Try using $result_data instead of $response")
4. **File-based validation**: Allow passing file paths directly to the validation tool
5. **Documentation search**: Add ability to search documentation by keywords

### Overall Experience
The development process was smooth after understanding the quirks. The MCP validation was crucial for catching syntax errors. With better documentation of reserved words and tool parameters, the experience would be excellent.
