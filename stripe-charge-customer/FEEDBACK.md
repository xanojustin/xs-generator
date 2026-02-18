# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 11:15 PST] - Initial Setup

**What I was trying to do:** Set up the initial file structure and write the first draft of the Stripe charge customer run job

**What the issue was:** None yet - initial setup

**Why it was an issue:** N/A

**Potential solution (if known):** N/A

---

## [2025-02-18 11:18 PST] - Throw syntax confusion

**What I was trying to do:** Write a throw statement for error handling when the Stripe API returns an error

**What the issue was:** I wrote the throw block with commas between properties (like JavaScript object syntax):
```xs
throw {
  name = "StripeError",
  value = $error_message
}
```

This caused a parse error: `Expecting --> } <-- but found --> ',' <--`

**Why it was an issue:** XanoScript uses newlines as separators, not commas. This is different from many other languages where commas are used to separate object properties. I had to look up the syntax documentation to realize this.

**Potential solution (if known):** 
1. The MCP could provide more helpful error messages that suggest removing the comma
2. The documentation could more prominently highlight that commas are NOT used between properties in XanoScript blocks
3. A linting hint or quick fix suggestion could help developers transitioning from JS-style syntax

---
