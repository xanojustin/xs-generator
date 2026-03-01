# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 10:35 PST] - Comment parsing issue with blank lines

**What I was trying to do:** Create a XanoScript function with multi-line comments at the top

**What the issue was:** The XanoScript parser rejected a blank line between the last comment line and the `function` declaration. The error was:
```
Expecting --> function <-- but found --> '\n' <--
```

**Why it was an issue:** I initially wrote:
```xs
// Line 1
// Line 2
// Line 3

function "name" { ... }
```

This caused a parse error. Removing the blank line fixed it:
```xs
// Line 1
// Line 2
// Line 3
function "name" { ... }
```

**Potential solution (if known):** The error message was misleading - it suggested using "text" instead of "string" which was unrelated to the actual issue. A better error message would indicate that comments cannot be followed by blank lines before code, or the parser could simply allow blank lines after comments.

---

## [2026-03-01 10:32 PST] - No documentation on comment syntax

**What I was trying to do:** Find documentation on how to write comments in XanoScript

**What the issue was:** I searched the xanoscript_docs (essentials, syntax topics) and couldn't find explicit documentation on comment syntax. I had to infer it from existing examples.

**Why it was an issue:** Without clear documentation, I didn't know:
- Whether `//` or `/* */` style comments are supported
- Whether blank lines between comments and code are allowed
- Whether comments can appear inside blocks

**Potential solution (if known):** Add a section on comment syntax to the essentials or syntax documentation topics. Examples showing valid and invalid comment placement would be helpful.

---

## [2026-03-01 10:30 PST] - Difficulty accessing MCP tools

**What I was trying to do:** Call the Xano MCP validation tool

**What the issue was:** The npm package was installed globally, but I had to use the full path to require it:
```javascript
const { validateXanoscript } = require('/opt/homebrew/lib/node_modules/@xano/developer-mcp');
```

**Why it was an issue:** The CLI commands like `xano-mcp` or `xanoscript_docs` weren't available in PATH after global npm install. I had to figure out the Node.js require path.

**Potential solution (if known):** Either add CLI binaries to PATH during global install, or document the Node.js API access pattern for programmatic use.

---
