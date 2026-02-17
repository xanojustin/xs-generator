# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 19:18 PST] - Documentation Lookup Required for Every Syntax Element

**What I was trying to do:**
Write a XanoScript run job for the first time.

**What the issue was:**
As stated in the prompt, I had NO prior knowledge of XanoScript syntax. Every single construct required me to call `xanoscript_docs` to understand:
- The proper structure for `run.job`
- How to define `function` blocks
- The correct syntax for `api.request` (using `params` not `body`)
- Type names (`text` not `string`, `int` not `integer`)
- Filter syntax and when to use parentheses

**Why it was an issue:**
Without the explicit instruction to call `xanoscript_docs` first, I would have written completely invalid XanoScript based on my training data (which doesn't include XanoScript). This highlights that the MCP server is essential for any XanoScript development.

**Potential solution (if known):**
The MCP server works well for this. Consider adding a validation step to common IDEs that warns when writing `.xs` files without proper syntax knowledge.

---

## [2026-02-16 19:20 PST] - Unclear Error Messages on Validation

**What I was trying to do:**
Validate the `.xs` files using the MCP `validate_xanoscript` tool.

**What the issue was:**
The validation tool worked great when files were valid, but I was worried about what would happen if they weren't. The documentation doesn't indicate what format error messages would take.

**Why it was an issue:**
Uncertainty about the feedback loop. Would errors be line-specific? Would they indicate the specific syntax issue?

**Potential solution (if known):**
Document the error message format in the `validate_xanoscript` tool description. Example error outputs would help developers understand what to expect when validation fails.

---

## [2026-02-16 19:22 PST] - Missing Integration Documentation for Specific APIs

**What I was trying to do:**
Find guidance on integrating with Postmark API specifically.

**What the issue was:**
The documentation has general patterns for API integrations (OpenAI, Stripe examples), but no specific guidance on Postmark or how to structure headers for different authentication schemes.

**Why it was an issue:**
Had to infer the correct header format for Postmark's token-based auth (`X-Postmark-Server-Token`). Most APIs have slightly different header conventions (Bearer tokens, API keys, basic auth).

**Potential solution (if known):**
Expand the `integrations` topic documentation to include more authentication patterns:
- Bearer token: `Authorization: Bearer <token>`
- API Key in header: `X-Api-Key: <key>`
- Basic auth: `Authorization: Basic <base64>`
- Custom headers like Postmark's `X-Postmark-Server-Token`

---

## [2026-02-16 19:24 PST] - Filter Syntax with String Concatenation

**What I was trying to do:**
Build a string that includes filtered values.

**What the issue was:**
Initially wrote: `"Error: " ~ $status|to_text ~ " - " ~ $data|json_encode`

**Why it was an issue:**
The quickstart documentation mentions this is wrong and requires parentheses around filtered expressions, but it's easy to miss. I had to refer back to the docs to catch this.

**Potential solution (if known):**
The quickstart docs do cover this well in the "Common Mistakes" section. Perhaps the validation tool could catch this specific pattern and suggest the fix.

---

## [2026-02-16 19:25 PST] - Environment Variable Access Pattern

**What I was trying to do:**
Understand how to access environment variables in different contexts.

**What the issue was:**
The quickstart docs have a note that `$env` is not allowed in `input` blocks, but it's not clear why or what the pattern should be.

**Why it was an issue:**
Had to read carefully to understand that env vars should be accessed in the `stack` block using `var $api_key { value = $env.API_KEY }` pattern.

**Potential solution (if known):**
Add a clear code example showing the proper pattern for accessing environment variables in functions vs run jobs.

---

## Summary

Overall, the Xano MCP server worked well for this task. The `xanoscript_docs` tool provided comprehensive documentation, and the `validate_xanoscript` tool confirmed my code was correct. The main struggles were:

1. **Dependency on docs** - Cannot write XanoScript without consulting the MCP docs (which is by design, but important to emphasize)
2. **Mental overhead** - Many syntax rules to keep in mind (type names, filter parentheses, object literal syntax with `:` not `=`)
3. **Limited examples** - More real-world API integration examples would help

The validation tool passing on first try (after consulting docs) suggests the documentation is comprehensive and accurate.
