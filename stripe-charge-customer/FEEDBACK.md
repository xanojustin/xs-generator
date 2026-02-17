# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 13:18 PST] - Index Type Values Not Documented in Quick Reference

**What I was trying to do:**
Create a table with indexes for the charge_log table to track Stripe charges by customer_id, charge_id, and created_at.

**What the issue was:**
I used `type: "index"` for non-primary indexes, which is intuitive coming from SQL backgrounds. The validation failed with:
```
Expected value of `type` to be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`
```

**Why it was an issue:**
The quickstart and table documentation I retrieved didn't mention the valid index types. I had to discover them through trial-and-error validation failures.

**Potential solution (if known):**
The `xanoscript_docs(topic: "tables")` should include a section on valid index types with brief descriptions of when to use each (btree for standard indexes, gin for full-text, etc.).

---

## [2025-02-17 13:18 PST] - Decimal Type Multiplication Result Type Ambiguity

**What I was trying to do:**
Convert a dollar amount to cents for Stripe API by multiplying `decimal amount` by 100.

**What the issue was:**
Stripe requires the `amount` parameter as an integer (cents). I wrote `($input.amount * 100)|to_int` but wasn't sure if the multiplication would preserve precision or if I needed explicit conversion first.

**Why it was an issue:**
The documentation doesn't clarify how arithmetic operations work across types, or what the resulting type of `decimal * int` would be. I guessed it would work but had low confidence.

**Potential solution (if known):**
Add a section to the syntax documentation about type coercion in arithmetic operations, or provide examples of common currency/money handling patterns (converting dollars to cents is a very common need).

---

## [2025-02-17 13:15 PST] - Xano MCP Server Discovery

**What I was trying to do:**
Call the `xanoscript_docs` tool as instructed in the task requirements.

**What the issue was:**
The task says "You MUST call `xanoscript_docs` on the xano MCP" but doesn't specify how to access it. I had to discover through `mcporter list` that the server was named "xano" and then explore its tools.

**Why it was an issue:**
Without prior knowledge of mcporter or the Xano MCP setup, there's no obvious way to know the server name or available tools. I had to guess and explore.

**Potential solution (if known):**
The task template could include a standard preamble like: "Use `mcporter call xano.xanoscript_docs topic=<topic>` to access documentation" - or the SKILL.md for XanoScript could document MCP interaction patterns.

---

## [2025-02-17 13:20 PST] - Form URL Encoding for Stripe API

**What I was trying to do:**
Send a POST request to Stripe's API with the proper content type.

**What the issue was:**
Stripe's API accepts either `application/x-www-form-urlencoded` or `application/json`. I initially wasn't sure which to use or how to properly encode the params. The `params` parameter in XanoScript sends data as the request body, but it's unclear if it auto-encodes based on Content-Type.

**Why it was an issue:**
The external-api documentation shows JSON examples but doesn't explain how form encoding works, or if XanoScript handles the encoding automatically.

**Potential solution (if known):**
Add examples for common API patterns including form-encoded POST requests (very common with OAuth and payment APIs like Stripe).

---

## [2025-02-17 13:16 PST] - Missing Documentation on Filter Chaining Precedence

**What I was trying to do:**
Access nested properties in the Stripe API response like `$stripe_result.response.result.error.message`.

**What the issue was:**
I wasn't sure if the `??` null coalescing operator or `|get:` filter would be needed for safe property access, or if XanoScript would throw an error on missing nested properties.

**Why it was an issue:**
The quickstart mentions `get` filter with defaults but doesn't show nested property access patterns or explain behavior when intermediate properties are null.

**Potential solution (if known):**
Add examples of safe nested property access, especially for API responses where fields may or may not be present based on success/error conditions.

---

## Overall Assessment

The Xano MCP validation tool is **excellent** - it caught my index type error immediately with a clear error message suggesting the valid values. This is much better than deploying and finding errors at runtime.

The main gap is documentation discoverability. The `xanoscript_docs` tool works well, but:
1. Need to know it exists and how to call it
2. The topics aren't always intuitive (had to guess "integrations/external-apis" vs "apis")
3. Some practical details (like index types) aren't in the quick reference

The validation-first workflow is great - validate early, fix issues, then deploy with confidence.
