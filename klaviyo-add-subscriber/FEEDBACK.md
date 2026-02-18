# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 07:50 PST] - MCP Server Connection Issues via mcporter

**What I was trying to do:**
Call the `validate_xanoscript` tool using mcporter to validate my XanoScript files.

**What the issue was:**
The `mcporter call xano validate_xanoscript` command consistently returned:
```
[mcporter] Unknown MCP server 'xano'.
Error: Unknown MCP server 'xano'.
```

However, `mcporter list` showed the xano server as available and healthy.

**Why it was an issue:**
This blocked me from using the standard mcporter workflow for validation. I had to manually invoke the MCP server using stdio directly with:
```bash
echo '{"jsonrpc": "2.0", "id": 1, "method": "tools/call", "params": {"name": "validate_xanoscript", "arguments": {"file_path": "run.xs"}}}' | npx @xano/developer-mcp
```

**Potential solution (if known):**
The stdio-based MCP server configuration in mcporter.json may have connection stability issues. Consider:
1. Adding better error messages in mcporter when stdio servers fail to connect
2. Documenting the fallback method (direct npx invocation) for troubleshooting
3. Adding a retry mechanism for stdio-based MCP connections

---

## [2026-02-18 07:52 PST] - Xano MCP Documentation Generic Responses

**What I was trying to do:**
Get specific documentation for run jobs and external API integrations using `xanoscript_docs`.

**What the issue was:**
The `xanoscript_docs` tool returned the same generic README content regardless of the topic I requested. I tried:
- `xanoscript_docs({"topic": "run"})`
- `xanoscript_docs({"topic": "quickstart"})`
- `xanoscript_docs({"topic": "integrations"})`

All returned the same generic workspace structure documentation without specific syntax examples for run jobs or API request patterns.

**Why it was an issue:**
I had to infer the correct syntax by reading existing run job implementations in the ~/xs folder rather than getting authoritative documentation. This is inefficient and error-prone.

**Potential solution (if known):**
The MCP documentation tool should return topic-specific content. If topics aren't implemented, return an error or list of available topics rather than generic content.

---

## [2026-02-18 07:55 PST] - Validating Multiple Files is Cumbersome

**What I was trying to do:**
Validate all .xs files in my run job directory (run.xs, function/*.xs, table/*.xs).

**What the issue was:**
The `validate_xanoscript` tool accepts `directory` parameter, but when I tried to use it, the MCP connection failed. I had to validate each file individually with separate MCP calls:
```bash
echo '...' | npx @xano/developer-mcp  # for run.xs
echo '...' | npx @xano/developer-mcp  # for function/add_subscriber.xs
echo '...' | npx @xano/developer-mcp  # for table/subscriber_log.xs
```

**Why it was an issue:**
This is tedious and slow. A batch validation feature or working directory parameter would be much more efficient for multi-file run jobs.

**Potential solution (if known):**
Ensure the `directory` parameter works reliably for batch validation, or add a `file_paths` array parameter to validate multiple specific files in one call.

---

## [2026-02-18 07:48 PST] - Limited Quick Reference for Common Patterns

**What I was trying to do:**
Find the correct syntax for:
1. Optional input parameters with defaults
2. Object merging/extending (for building payload objects conditionally)
3. HTTP API request error handling patterns

**What the issue was:**
The documentation returned by `xanoscript_docs` didn't include these specific patterns. I had to:
1. Look at existing implementations in ~/xs/
2. Guess at the syntax (e.g., `~` for object merging)
3. Validate and iterate when I got it wrong

**Why it was an issue:**
The validation tool caught my errors, but having to guess-and-check is inefficient. The quickstart should include common patterns like:
- Conditional object building
- Safe nested property access
- Default parameter values
- Filter chaining

**Potential solution (if known):**
Add a "Common Patterns" section to the quickstart documentation covering:
```xs
// Optional parameters with defaults
text name?="default"

// Object merging
$obj1 ~ $obj2

// Safe nested access
$var|get:"path.to.property","default"

// Conditional building
conditional {
  if ($condition) {
    var $obj { value = $obj ~ {newField: "value"} }
  }
}
```

---

## Overall Assessment

The Xano MCP validation tool is **excellent** when it works - it provides clear, actionable error messages with line numbers. The validation caught no issues with my files, which gave me confidence they were syntactically correct.

However, the MCP connection stability issues via mcporter and the generic documentation responses made development harder than it should be. The main pain points were:

1. **Connection reliability**: stdio-based MCP servers don't always connect through mcporter
2. **Documentation specificity**: The docs tool returns generic content regardless of topic
3. **Batch validation**: No efficient way to validate multiple files at once
4. **Pattern examples**: Missing common patterns in the quick reference

The validation-first workflow is valuable, but the tooling friction reduces its effectiveness.