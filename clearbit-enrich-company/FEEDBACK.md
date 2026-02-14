# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 07:18 PST] - MCP Validation Tool Requires JSON-RPC

**What I was trying to do:**
Validate my XanoScript files using the `validate_xanoscript` tool from the Xano MCP.

**What the issue was:**
The `mcporter call xano validate_xanoscript --code "..."` command always failed with:
```
Found 1 error(s):
1. [Line 1, Column 1] Expecting --> function <-- but found --> '-' <--
```

This error was misleading - it suggested my code had a syntax error, but the actual issue was that mcporter wasn't properly passing the `--code` argument to the MCP server. The `-` character was likely from the argument parsing itself.

**Why it was an issue:**
I spent considerable time trying different approaches:
- Passing code directly as argument
- Using file references (@filename)
- Using stdin piping
- Escaping quotes differently

All of these failed with the same cryptic error, making me think my XanoScript syntax was wrong.

**Potential solution (if known):**
- Fix mcporter's argument passing to the MCP server
- Document the proper way to call validate_xanoscript
- Provide a simpler CLI interface like `xano-validate <file.xs>`

**Workaround:**
I had to manually construct a JSON-RPC request and pipe it to the MCP server:
```bash
node -e '
const code = require("fs").readFileSync("file.xs", "utf8");
console.log(JSON.stringify({
  jsonrpc: "2.0", id: 1, method: "tools/call",
  params: { name: "validate_xanoscript", arguments: { code } }
}));
' | npx -y @xano/developer-mcp@1.0.34
```

---

## [2026-02-14 07:20 PST] - Run.job vs Function Validation Same Tool

**What I was trying to do:**
Understand if there's a separate validation for run.job files vs function files.

**What the issue was:**
Initially I thought the validation was failing because run.job might need a different validator than function. The documentation mentions different constructs (run.job, function, task, etc.) but it's not clear if they all use the same validation tool.

**Why it was an issue:**
Minor confusion about whether I should be using different validation approaches for different file types.

**Potential solution (if known):**
- Clarify in documentation that validate_xanoscript handles all .xs file types
- Or provide separate validation tools for different constructs if they have different parsers

**Resolution:**
Both run.xs (run.job) and function/enrich_company.xs (function) validated successfully with the same tool.

---

## [2026-02-14 07:22 PST] - Documentation Format Inconsistency

**What I was trying to do:**
Follow the XanoScript syntax patterns from the documentation and examples.

**What the issue was:**
The xanoscript_docs tool returns the same generic documentation regardless of the topic requested. I called:
- `xanoscript_docs({ topic: "quickstart" })`
- `xanoscript_docs({ topic: "functions" })`
- `xanoscript_docs({ topic: "run" })`
- `xanoscript_docs({ topic: "integrations" })`

All returned the same general README content, not the specific topic documentation.

**Why it was an issue:**
I couldn't access the specific syntax details I needed for:
- Proper run.job structure
- Input parameter modifiers (optional, defaults, filters)
- var.update vs var syntax
- Object manipulation with set filter

I had to rely on existing working examples in the ~/xs folder instead.

**Potential solution (if known):**
- Fix the xanoscript_docs tool to return topic-specific content
- Ensure the topic parameter is properly handled
- Consider embedding the full documentation in the MCP or providing a local path to markdown files

---

## Summary

The XanoScript language itself is straightforward and well-designed. The validation tool works correctly once you can actually call it properly. The main issues were:

1. **MCP Tool Invocation** - mcporter doesn't properly pass arguments to the validate_xanoscript tool
2. **Documentation Access** - The xanoscript_docs tool returns generic content regardless of topic
3. **Example-Driven Development** - Had to rely heavily on existing examples rather than comprehensive docs

The validation tool is excellent and confirmed my code is correct. Just need better tooling around accessing it.
