# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-14 09:45 PST - Issue: MCP validate_xanoscript tool requires JSON-RPC over stdio

**What I was trying to do:**
Validate XanoScript code using the MCP validate_xanoscript tool.

**What the issue was:**
The Xano MCP server communicates via stdio using JSON-RPC protocol. The mcporter CLI tool doesn't provide a straightforward way to call the validation tool directly. Using `mcporter call xano.validate_xanoscript --code "..."` failed with "Unknown MCP server 'xano'" error, even though `mcporter list` showed xano as available.

**Why it was an issue:**
Had to write a custom Node.js script to properly communicate with the MCP server over stdio using JSON-RPC messages. This added significant development overhead and debugging time (~15-20 minutes).

**Potential solution:**
The Xano MCP should either:
1. Provide a simpler CLI interface that accepts code directly via stdin or file path
2. Document the proper way to use mcporter with stdio-based MCP servers
3. Add an HTTP-based MCP transport option for easier integration

---

## 2026-02-14 09:50 PST - Issue: Unclear iteration syntax (while vs foreach/each)

**What I was trying to do:**
Iterate over an array of links from PayPal API response to find the approval URL.

**What the issue was:**
I tried using `while` loop syntax (similar to other languages), but this is not valid XanoScript syntax. The validator returned: "Expecting --> each <-- but found --> newline".

**Why it was an issue:**
The syntax documentation I retrieved showed `while` as a control structure, but the actual working syntax for array iteration uses `foreach ... { each as $var { ... } }` pattern which wasn't clearly documented in the quick reference I accessed.

**Potential solution:**
1. Add clearer examples of array iteration to the quickstart documentation
2. If `while` is not supported, remove it from syntax documentation or clarify its specific use cases
3. Provide more practical code examples for common patterns like iterating over API response arrays

---

## 2026-02-14 09:52 PST - Issue: api.request uses `params` not `body`

**What I was trying to do:**
Send a POST request with a JSON body to the PayPal API.

**What the issue was:**
I tried using `body = $order_payload` in the `api.request` block, but the validator returned: "The argument 'body' is not valid in this context". I needed to use `params = $order_payload` instead.

**Why it was an issue:**
Most HTTP libraries use `body` for POST request payloads. Using `params` for JSON payloads is unintuitive and inconsistent with common HTTP client conventions.

**Potential solution:**
1. Accept both `body` and `params` parameters for clarity
2. Document the api.request block parameters more clearly with examples for different content types
3. Add validation error messages that suggest the correct parameter name

---

## 2026-02-14 09:55 PST - Issue: Limited mcporter integration with stdio MCP servers

**What I was trying to do:**
Use mcporter CLI to call Xano MCP tools directly.

**What the issue was:**
The mcporter CLI couldn't properly communicate with the Xano MCP server which uses stdio transport. Commands like `mcporter list` worked, but `mcporter call` failed.

**Why it was an issue:**
Had to write custom Node.js scripts using raw JSON-RPC over stdio to access validation functionality.

**Potential solution:**
1. Ensure mcporter properly supports stdio-based MCP servers
2. Add a `mcporter validate` command specifically for XanoScript files
3. Provide a simple wrapper script in the skill documentation

---

## General Notes

**What worked well:**
- The Xano MCP validation tool is fast and provides helpful error messages with line/column positions
- The syntax is clean and readable once you understand the patterns
- The existing examples in ~/xs/ were very helpful for understanding structure

**Suggestions for improvement:**
1. Create a simple `xano validate <file.xs>` CLI command that handles all the JSON-RPC internally
2. Provide a comprehensive "common patterns" guide with working examples for:
   - HTTP API calls with authentication
   - Array iteration and filtering
   - Error handling patterns
   - JSON payload construction
3. Add VS Code extension support for real-time validation
