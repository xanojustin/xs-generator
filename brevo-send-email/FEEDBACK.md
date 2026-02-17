# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 08:47 PST] - Reserved Variable Name Error

**What I was trying to do:**
Create a XanoScript function that sends an email and returns a response object containing the success status, message ID, and other details.

**What the issue was:**
I used `var $response` as a variable name to hold the function's return data, but validation failed with:
```
[Line 54, Column 13] '$response' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
This blocked validation and I had to rename the variable to `$email_response`. I wasn't aware that `$response` was reserved since it's commonly used in other languages to build the return value before assigning to the actual response.

**Potential solution (if known):**
The documentation mentions reserved variable names in the quickstart guide, but it would be helpful if:
1. The validation error appeared immediately during file write/IDE integration
2. There was a comment at the top of function templates reminding about reserved names
3. The docs had a more prominent warning about `$response` specifically since it's intuitive to use

---

## [2026-02-17 08:46 PST] - Lack of Inline XanoScript Syntax Knowledge

**What I was trying to do:**
Write XanoScript code for a run job that calls the Brevo API.

**What the issue was:**
I don't have XanoScript syntax in my training data. I had to call the MCP's `xanoscript_docs` tool multiple times to get documentation for:
- run.job structure
- api.request syntax
- function definition patterns
- Input/output handling
- Error handling patterns

**Why it was an issue:**
Each documentation call took time and I had to piece together information from multiple topic queries (run, functions, integrations/external-apis, quickstart). Without the MCP docs, I would have written invalid code.

**Potential solution (if known):**
1. A single "template" or "boilerplate" topic that shows a complete working example
2. A "run-job-template" that includes common patterns (API call, error handling, response building)
3. Consider caching common patterns in a way that's easier to access

---

## [2026-02-17 08:45 PST] - MCP Documentation Mode Confusion

**What I was trying to do:**
Get XanoScript documentation efficiently without consuming too many tokens.

**What the issue was:**
The docs have a `mode` parameter with options `full` and `quick_reference`. I wasn't sure which to use initially. I started with `full` which may have been more verbose than needed.

**Why it was an issue:**
The docs say `quick_reference` is for "context efficiency" but it's unclear what information gets omitted. I was worried I'd miss important details needed for correct syntax.

**Potential solution (if known):**
Add a comparison table showing what's included/excluded in each mode so developers can make an informed choice.

---

## Summary

Overall the Xano MCP worked well:
- ✅ The `validate_xanoscript` tool caught my reserved variable name error
- ✅ The `xanoscript_docs` tool provided comprehensive documentation
- ✅ Clear error messages with line/column numbers

Main friction points:
1. Needing multiple doc lookups to piece together a complete solution
2. Reserved variable names aren't obvious until validation fails
3. Unclear trade-offs between full/quick_reference documentation modes

The MCP successfully helped me create a working XanoScript run job despite having no prior knowledge of the syntax.
