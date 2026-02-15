# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 00:48 PST] - MCP Documentation Returns Generic Content for All Topics

**What I was trying to do:**
Get specific XanoScript syntax documentation for different topics (quickstart, run jobs, http_request, input_validation, syntax) to understand how to write proper XanoScript code.

**What the issue was:**
Every call to `xanoscript_docs` with different topics returned the exact same generic documentation - the "Quick Reference" table showing constructs like workspace, table, api_group, etc. None of the topic-specific content was returned (e.g., no quickstart patterns, no API request examples, no syntax details).

**Why it was an issue:**
Without specific syntax documentation, I had to guess the syntax or rely on reading existing examples. This made it harder to understand correct patterns and increased the chance of writing invalid code.

**Potential solution:**
The MCP should return topic-specific content as documented in the index. If certain topics aren't implemented yet, it should return an error or indicate that rather than returning generic fallback content.

---

## [2026-02-15 00:50 PST] - validate_xanoscript Parameter Name Unclear

**What I was trying to do:**
Validate my XanoScript files using the MCP validate_xanoscript tool.

**What the issue was:**
The initial attempts using `mcporter call xano validate_xanoscript '{"path": "/path/to/file"}'` failed with "'code' parameter is required". This error message was confusing because I was trying to pass a path, not code. It wasn't clear that the tool expects file content directly rather than a file path.

**Why it was an issue:**
Wasted time trying different approaches (path vs code content) before figuring out the correct parameter format. The error message could be more helpful by indicating what parameters are accepted.

**Potential solution:**
- Update the error message to say something like "Required parameter 'code' not provided. Pass XanoScript source code as a string."
- Optionally support a "path" parameter that reads the file automatically
- Document the expected parameter format in the MCP tool description

---

## [2026-02-15 00:52 PST] - mcporter Call Syntax for JSON Args Was Non-Obvious

**What I was trying to do:**
Call the validate_xanoscript tool with the code parameter using mcporter CLI.

**What the issue was:**
The correct syntax was `mcporter call xano.validate_xanoscript --args '{"code":"..."}'` with the tool name as `server.tool` format and the `--args` flag. Other attempts like `mcporter call xano validate_xanoscript code=...` or passing JSON without `--args` failed silently or with confusing errors.

**Why it was an issue:**
The mcporter CLI has multiple ways to pass arguments and the correct format isn't immediately obvious from standard MCP usage patterns. Tried several variations before finding the working syntax.

**Potential solution:**
- Provide clear examples in the mcporter/xano skill documentation showing the correct call format
- Consider supporting more intuitive syntax like `mcporter call xano validate_xanoscript code="..."`

---

## [2026-02-15 00:54 PST] - Single-Line vs Multi-Line Validation Behavior

**What I was trying to do:**
Validate XanoScript code that was minified to a single line for the JSON payload.

**What the issue was:**
When passing minified/single-line code like `run.job "Name" { main = { name: "func" input: { ip: "8.8.8.8" } } }`, the validator reported errors about expecting commas. However, when the same code was passed with proper newlines, it validated successfully.

**Why it was an issue:**
This suggests the XanoScript parser is sensitive to whitespace/newlines in ways that aren't obvious. The error message about "expected commas" was misleading since the actual issue was the lack of newlines.

**Potential solution:**
- The parser should either handle single-line input correctly or provide a more accurate error message
- Document whitespace/line-break requirements in the syntax documentation
- Consider adding automatic formatting/normalization to the validator

---

## [2026-02-15 00:55 PST] - Working Directory Affects mcporter MCP Server Resolution

**What I was trying to do:**
Run validation from within the ~/xs/ipapi-geolocation directory.

**What the issue was:**
When running `cd ~/xs/ipapi-geolocation && mcporter call xano...`, mcporter couldn't find the 'xano' MCP server. The server is only found when running from the home directory.

**Why it was an issue:**
This suggests mcporter uses a local config file that isn't available in other directories. Had to run all commands from the home directory with absolute paths.

**Potential solution:**
- mcporter should use a global config or find config up the directory tree
- Document that mcporter must be run from the directory containing the config
- Support a `--config` flag to specify the config location explicitly

---

## General Feedback

### What Worked Well:
- Once figured out, the validation tool was helpful and caught syntax issues
- The existing examples in ~/xs were invaluable for understanding correct patterns
- The mcporter list command correctly showed available tools

### Suggested Improvements:
1. Fix xanoscript_docs to return topic-specific content
2. Add more detailed parameter documentation for MCP tools
3. Consider adding a validate_xanoscript_path function that accepts file paths
4. Document common XanoScript patterns in an easily accessible format
