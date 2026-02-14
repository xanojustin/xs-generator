# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 22:20 PST] - MCP Tool Parameter Confusion

**What I was trying to do:**
Validate the XanoScript files using the MCP server's validate_xanoscript tool.

**What the issue was:**
I initially called `validate_xanoscript` with a `file_path` parameter, but the MCP tool returned an error: "Error: 'code' parameter is required". 

The MCP tool schema or naming convention was unclear - the error message said 'code' was required, but it wasn't immediately obvious if this meant:
1. The file path (which points to code)
2. The actual code content as a string

**Why it was an issue:**
Had to experiment to discover that the tool expects the actual file content passed as the `code` parameter, not a file path. This is different from many other tools that accept file paths.

**Potential solution (if known):**
- The tool could accept either `file_path` OR `code` parameter for flexibility
- Better error message could say: "Error: 'code' parameter is required (pass the file content, not a path)"
- Or document that `code` means the literal code content

---

## [2025-02-13 22:18 PST] - String Concatenation in XanoScript

**What I was trying to do:**
Build the PagerDuty API payload which requires string concatenation for the timestamp in ISO 8601 format.

**What the issue was:**
I wanted to use string concatenation with `~` for the timestamp format string, but wasn't sure if parentheses were required around the filter expression. The documentation mentions using parentheses for filter concatenation but the exact rules weren't immediately clear.

**Why it was an issue:**
Had to look up the syntax rules for string concatenation with filters. The documentation says:
```
// ✅ Correct
var $msg { value = ($status|to_text) ~ " - " ~ ($data|json_encode) }
```
But I was building a nested object with optional fields and filters.

**Potential solution (if known):**
The documentation is actually pretty good here - the quickstart section covers this well. Just needed to find it.

---

## [2025-02-13 22:15 PST] - XanoScript Optional Field Handling

**What I was trying to do:**
Build a JSON payload with optional fields (`component`, `group`, `class`) that should only be included if they have values.

**What the issue was:**
The PagerDuty API doesn't accept null values for optional fields - they should be omitted entirely. I initially thought about using conditional blocks to build the object piece by piece, but that would be verbose.

**Why it was an issue:**
Had to find the correct pattern for conditionally including fields. The documentation mentions `set_ifnotnull` filter which is perfect, but it took some searching to find.

**Potential solution (if known):**
The quickstart docs cover this well with:
```xs
var $data {
  value = { required: $input.required }|set_ifnotnull:"optional":$input.optional
}
```
This is a great pattern - maybe highlight it more prominently or include it in a "Common API Patterns" section.

---

## [2025-02-13 22:10 PST] - MCP Server Documentation Discovery

**What I was trying to do:**
Understand how to call the Xano MCP tools and what parameters they accept.

**What the issue was:**
I needed to call `xanoscript_docs` to get the syntax documentation, but wasn't sure if I should call it as `xano.xanoscript_docs` or just `xanoscript_docs`. Also wasn't sure what parameters it accepts.

**Why it was an issue:**
Had to guess at the tool naming convention and parameter format. The mcporter skill helped, but there was some trial and error.

**Potential solution (if known):**
- A simple `xano.list_tools` or `xano.help` command would be useful
- The MCP server could expose its own documentation via a tool
- Or include tool usage examples in the npm package README

---

## [2025-02-13 22:05 PST] - Input Block Syntax for Functions

**What I was trying to do:**
Define a function with optional parameters that have default values.

**What the issue was:**
Wasn't 100% sure about the syntax for optional fields with defaults in the input block. The documentation shows:
```xs
input {
  text name filters=trim
  int age? filters=min:0
  email contact filters=lower { sensitive = true }
}
```
But I needed `text severity="critical"` syntax - is the default value after the type or after filters?

**Why it was an issue:**
Had to infer from examples that default values come after the type name, before filters: `text severity="critical"`

**Potential solution (if known):**
The functions documentation could include a clear example of default values in input blocks.

---

## Overall Feedback

### What Worked Well

1. **xanoscript_docs is excellent** - Having comprehensive, categorized documentation available via MCP is fantastic
2. **Validation tool is fast** - Once I figured out the parameter format, validation was quick and accurate
3. **Syntax errors are clear** - The validation output was helpful when there were issues

### Suggestions for Improvement

1. **Add a `list_tools` command** - Let users discover available tools and their parameters
2. **Support file_path in validate_xanoscript** - Most developers think in terms of files
3. **Add more API integration examples** - Patterns for common APIs (REST, GraphQL, webhooks)
4. **Clarify the relationship** between Xano Run Jobs and regular Xano functions - when to use each

### Documentation Gaps

1. More examples of building complex JSON payloads with optional fields
2. Clearer distinction between `api.request` response structure vs the actual API response
3. Best practices for error handling in external API calls

---

*Feedback collected while building the PagerDuty Trigger Incident run job*
