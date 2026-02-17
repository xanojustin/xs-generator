# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-17 07:18 PST - MCP Tool Discovery and Documentation

**What I was trying to do:**
Discover available Xano MCP tools and get XanoScript documentation before writing code.

**What the issue was:**
Initially tried `mcporter tools xano` which didn't work. Had to use `mcporter list xano` instead. The error message was helpful ("Did you mean xano?") but it took a moment to understand the correct command structure.

**Why it was an issue:**
Minor friction in discovering tool names. The MCP has good introspection but the exact command syntax wasn't immediately obvious.

**Potential solution:**
Consider adding `mcporter tools <server>` as an alias for `mcporter list <server>` for consistency with other MCP conventions.

---

## 2026-02-17 07:19 PST - XanoScript Documentation Quality

**What I was trying to do:**
Get comprehensive XanoScript syntax documentation to write a run job correctly.

**What the issue was:**
The documentation is actually quite good! I appreciated the `mode=quick_reference` option which gave me just the essential syntax without overwhelming detail. The `file_path` parameter for context-aware docs is a nice touch.

**Why it was positive:**
The quick reference format was perfect for AI code generation - concise, focused on syntax patterns, and included common gotchas (like the string concatenation with filters requiring parentheses).

**Potential improvement:**
Would be helpful to have a "common patterns" or "cookbook" section in the docs showing complete, working examples for typical use cases like API calls with error handling.

---

## 2026-02-17 07:20 PST - String Concatenation Syntax Gotcha

**What I was trying to do:**
Build the Telegram API URL by concatenating the base URL, bot token, and endpoint.

**What the issue was:**
The documentation clearly warned about this (in the syntax quick reference), but I still almost missed it: when concatenating strings that use filters, you MUST wrap each filtered expression in parentheses.

**Why it was an issue:**
Without the docs warning, I would have written:
```xs
value = "https://api.telegram.org/bot" ~ $env.telegram_bot_token ~ "/sendMessage"
```

This would likely cause a parse error. The correct syntax requires careful attention.

**Potential solution:**
This is well-documented, but perhaps the error message from the validator could be more specific when this pattern is detected.

---

## 2026-02-17 07:21 PST - Variable Declaration Syntax

**What I was trying to do:**
Declare intermediate variables in the function stack.

**What the issue was:**
The syntax `var $name { value = ... }` was straightforward, but I initially wondered if there were alternatives like `let` or `const`, or if I could declare without the block syntax.

**Why it was an issue:**
Minor uncertainty about whether I was using the most idiomatic pattern. The examples showed the block syntax consistently.

**Potential solution:**
A brief note in the docs explaining that `var` is the only variable declaration form and the block syntax is required would eliminate this uncertainty.

---

## 2026-02-17 07:22 PST - JSON Object Construction

**What I was trying to do:**
Create a JSON payload for the API request body.

**What the issue was:**
The XanoScript object literal syntax `{ key: value }` is clean and intuitive. It maps well to JSON. However, I wasn't initially sure if keys needed quotes or if there were restrictions on key names.

**Why it was an issue:**
Had to infer from examples that unquoted keys are acceptable and that the syntax is similar to JavaScript object literals (but with colons instead of equals for assignment within objects).

**Potential solution:**
A small section in the types documentation explicitly showing the object literal syntax and key naming rules would be helpful.

---

## 2026-02-17 07:23 PST - Environment Variable Access

**What I was trying to do:**
Access environment variables in the function using `$env.VAR_NAME`.

**What the issue was:**
This worked exactly as expected based on the documentation. The pattern is intuitive for anyone familiar with similar systems.

**Why it was positive:**
Clear, consistent syntax. The documentation examples showed this pattern clearly.

---

## 2026-02-17 07:24 PST - Validation Experience

**What I was trying to do:**
Validate the .xs files before committing.

**What the issue was:**
The validation tool worked perfectly! I used `mcporter call xano.validate_xanoscript directory="..."` and it validated all files at once with clear output showing "2 valid, 0 invalid".

**Why it was positive:**
The validation was fast, accurate, and the output was easy to understand. Having directory-level validation saved time compared to validating files individually.

**Potential improvement:**
Would be nice to have a "watch" mode or integration with a language server for real-time validation during development, but that's beyond the scope of the MCP tool.

---

## 2026-02-17 07:25 PST - Overall Experience Summary

**What worked well:**
1. The `xanoscript_docs` tool with different modes (full vs quick_reference) was excellent
2. The validation tool was fast and accurate
3. The syntax is clean and readable
4. The documentation covered the key gotchas (like string concatenation with filters)
5. The run.job structure is simple and intuitive

**Friction points:**
1. Initial tool discovery had a minor hiccup (tools vs list)
2. Had to piece together some syntax details from multiple doc topics
3. No single "complete example" showing a full run job with API call, error handling, and response formatting

**Suggestions for improvement:**
1. Add a "cookbook" or "patterns" section to the docs
2. Consider adding `mcporter tools <server>` as an alias
3. More explicit documentation on JSON/object literal syntax
4. A complete working example in the run documentation showing HTTP API integration

**Overall:**
The Xano MCP is well-designed and the XanoScript language is pleasant to work with. The documentation is solid, especially with the quick reference mode. Most issues were minor and could be resolved with small documentation additions.

---
