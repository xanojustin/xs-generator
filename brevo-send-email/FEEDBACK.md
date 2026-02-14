# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-14 11:15 PST] - Object Input Type Not Validating

**What I was trying to do:**
Create a function with an optional `object` type input parameter for custom tags that users could pass to the Brevo API.

**What the issue was:**
When I declared `object tags? { description = "Custom tags for tracking (optional, max 10)" }` in the input block, the validator returned this error:
```
[Line 11, Column 20] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: 'description'
```

I tried various syntaxes but none worked:
- `object tags?`
- `object? tags`
- `object tags? { description = "..." }`

**Why it was an issue:**
This blocked me from implementing the tags feature for the Brevo email API, which supports custom tags for email tracking and analytics. I had to remove the feature entirely.

**Potential solution:**
- Document which input types are supported in function input blocks
- Provide examples of complex input types (object, array) if supported
- If object/array types aren't supported in inputs, make that clear in the docs

---

## [2025-02-14 11:20 PST] - validate_xanoscript Parameter Documentation

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool.

**What the issue was:**
The tool expects a `code` parameter (the actual script content), not a `file_path`. I initially tried passing `file_path` which failed. I had to figure out how to properly pass multi-line code content via JSON.

The working approach required using jq to properly escape the file content:
```bash
CODE=$(jq -Rs . < file.xs) && mcporter call xano.validate_xanoscript --args "{\"code\": $CODE}"
```

**Why it was an issue:**
The documentation I received from xanoscript_docs didn't explain how to use the validation tool. I had to experiment to find the correct parameter name and JSON escaping approach.

**Potential solution:**
- Document the validate_xanoscript tool parameters clearly
- Add an example showing how to validate a file
- Consider adding a `file_path` alternative parameter for easier CLI usage

---

## [2025-02-14 11:25 PST] - MCP Tool Discovery

**What I was trying to do:**
List the available tools in the Xano MCP server.

**What the issue was:**
I tried `mcporter list xano` and other variations but couldn't immediately see what tools were available. I eventually found `mcporter list` shows all servers and their tool counts, but not the individual tool names.

**Why it was an issue:**
Minor friction - I had to guess the tool names (validate_xanoscript, xanoscript_docs) based on common patterns rather than seeing a definitive list.

**Potential solution:**
- `mcporter list --verbose` could show individual tool names per server
- Document the available Xano MCP tools in the skill or docs

---

## [2025-02-14 11:30 PST] - Working Directory Sensitivity

**What I was trying to do:**
Run the MCP commands from various directories.

**What the issue was:**
The mcporter configuration is in `~/.openclaw/workspace/config/mcporter.json`. When I ran commands from `~/xs/brevo-send-email/`, mcporter couldn't find the xano server. I had to `cd` to the workspace directory for the commands to work.

**Why it was an issue:**
This was confusing because I could see the xano server with `mcporter list` from some directories but got "Unknown MCP server 'xano'" errors when trying to call tools.

**Potential solution:**
- Document that mcporter should be run from the workspace directory
- Or have mcporter search for config in parent directories

---

## General Notes

**What worked well:**
- The xanoscript_docs tool provided comprehensive documentation
- Once I figured out the validation approach, it worked reliably
- The error messages from the validator were generally helpful

**Documentation gaps:**
- Input type reference (what types are valid: text, email, number, object, array?)
- Complete list of valid filters for input fields
- Examples of conditional blocks with elseif/else
- How to handle API response errors comprehensively

**Questions I still have:**
- What's the full list of input types supported in function input blocks?
- Are there built-in filters beyond `trim`, `lower`, `upper`, `strlen`?
- What's the best pattern for deeply nested error handling from API responses?
- Can functions call other functions, and if so, what's the syntax?
