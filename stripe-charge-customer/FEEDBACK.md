# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 15:08 PST] - MCP Tool Access Difficulty

**What I was trying to do:**
Access the xanoscript_docs and validate_xanoscript tools from the Xano MCP to understand XanoScript syntax and validate my code.

**What the issue was:**
The MCP tools weren't directly accessible via a simple command. The `xano-mcp` command wasn't found after installing the package globally. I had to dig into the npm cache directory (`~/.npm/_npx/...`) to find the actual JavaScript files and understand how to call them.

**Why it was an issue:**
This blocked me initially because I couldn't figure out how to access the documentation or validation tools. The installation didn't provide a clear CLI entry point that I could use immediately.

**Potential solution (if known):**
- Provide a clear CLI command like `xano-mcp docs` or `xano-mcp validate <file.xs>`
- Or document how to access the tools via npx with proper examples
- Consider exposing a server mode that can be called via HTTP or stdio for MCP protocol

---

## [2026-02-13 15:12 PST] - Documentation Scattered Across Files

**What I was trying to do:**
Understand XanoScript syntax to write a proper run job and function.

**What the issue was:**
The documentation is split across multiple markdown files (run.md, functions.md, syntax.md, integrations.md, etc.). I had to read several files to piece together how to write a complete solution. There's no single comprehensive reference or search functionality.

**Why it was an issue:**
It took extra time to find the right syntax for:
- How to structure a run.job vs run.service
- How to call external APIs with api.request
- How to properly use conditional blocks
- How to build and manipulate objects with set/update

**Potential solution (if known):**
- Add a comprehensive quick-reference guide that covers common patterns
- Provide a search/index across all documentation files
- Add more complete examples that show real-world use cases (API calls, data transformation)

---

## [2026-02-13 15:15 PST] - Confusion on Variable Declaration vs Update

**What I was trying to do:**
Update a variable inside a conditional block (adding optional fields to a payload object).

**What the issue was:**
I initially wasn't sure whether to use `var $payload` again or `var.update $payload`. The documentation mentions `var.update` but doesn't clearly explain when to use each form. I also wasn't sure about the exact syntax for `var.update` - whether it needs the full block with `value = ...` or not.

**Why it was an issue:**
This caused validation errors and I had to experiment to get it right. The syntax:
```xs
var.update $payload {
  value = $payload|set:"description":$input.description
}
```
wasn't immediately obvious from the examples.

**Potential solution (if known):**
- Add a clear section in the functions.md docs explaining the difference between `var` (declaration) and `var.update` (mutation)
- Show side-by-side examples of when to use each
- Clarify that `var.update` requires the same block structure as `var`

---

## [2026-02-13 15:18 PST] - Object/Array Manipulation Syntax Unclear

**What I was trying to do:**
Build a dynamic payload object by conditionally adding properties.

**What the issue was:**
The `set` filter syntax was confusing at first. I didn't understand that `$obj|set:"key":value` returns a new object rather than modifying in place. Also, the pipe/filter syntax for objects isn't as intuitive as it could be.

**Why it was an issue:**
I initially thought I could do something like:
```xs
$payload.description = $input.description
```
But XanoScript requires the functional approach with `set` filter, which took time to figure out.

**Potential solution (if known):**
- Add more examples of building dynamic objects/arrays incrementally
- Show the pattern: create base object → conditionally update with var.update → use in API call
- Consider adding syntactic sugar for object property assignment if possible

---

## [2026-02-13 15:20 PST] - Input Parameter Default Values Syntax

**What I was trying to do:**
Set a default value for an optional input parameter (currency defaulting to "usd").

**What the issue was:**
The syntax for default values in input parameters (`text currency?="usd"`) wasn't prominently documented. I had to search through the examples to find this pattern.

**Why it was an issue:**
Without knowing this syntax, I might have implemented default value logic in the stack block with conditionals, which would be more verbose.

**Potential solution (if known):**
- Document the `name?="default"` syntax clearly in the input parameter section
- Add a table showing all input modifiers: optional (`?`), default values (`="value"`), filters (`filters=trim`)

---

## [2026-02-13 15:22 PST] - Response Structure for api.request Unclear

**What I was trying to do:**
Parse the response from an external API call to Stripe.

**What the issue was:**
While integrations.md shows the basic `api.request` structure, I wasn't entirely sure about:
1. How to access the response body (is it `$result.response.result` or `$result.response.body`?)
2. How the response is parsed (automatic JSON parsing or manual?)
3. The exact structure of the error response

**Why it was an issue:**
I had to infer from the SendGrid example that `$api_result.response.result` contains the parsed response body. The Stripe API uses form-encoded POST but returns JSON, so I wasn't sure if XanoScript would auto-parse it.

**Potential solution (if known):**
- Add a clear example showing a complete API request + response handling
- Document the exact structure of the returned object
- Clarify content-type handling and automatic parsing behavior

---

## Summary

Overall, the Xano MCP tools work well once you understand how to access them. The validation tool was particularly helpful - it caught no errors in my final code, which gave me confidence. The main friction points were:

1. **Tool discoverability** - Hard to find how to run the MCP tools
2. **Documentation organization** - Information scattered across files
3. **Syntax clarity** - Some constructs (var.update, set filter) need better examples
4. **API integration patterns** - Could use more real-world examples

The language itself is intuitive once you get the patterns down. The validation tool is excellent and helped confirm my understanding.
