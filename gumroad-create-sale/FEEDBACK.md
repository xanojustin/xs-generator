# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 06:17 PST] - Throw Statement Syntax Confusion

**What I was trying to do:**
Create error handling in the Gumroad run job function using `throw` statements for different HTTP error codes (401, 404, etc.)

**What the issue was:**
I wrote the throw statement with commas between properties:
```xs
throw {
  name = "Unauthorized",
  value = "Invalid Gumroad access token"
}
```

This caused a validation error: "Expecting --> } <-- but found --> ',' <--"

**Why it was an issue:**
The error message was clear about WHERE the problem was (line 48, column 32), but I had to search through the full syntax documentation to find the correct format. Most programming languages use commas between object properties, so this was counterintuitive.

**Potential solution (if known):**
The documentation shows the correct format without commas, but it might help to:
1. Have a specific "Common Syntax Mistakes" section in the quickstart that highlights this
2. Include a throw statement example in the external APIs documentation since that's where API error handling happens

---

## [2026-02-17 06:15 PST] - Documentation Discovery Time

**What I was trying to do:**
Find the correct syntax for XanoScript before writing any code, as instructed in the task.

**What the issue was:**
The `xanoscript_docs` tool has many topic options and it took time to figure out which ones I needed. I had to call it 4 times (run, integrations/external-apis, functions, syntax) to get all the information needed.

**Why it was an issue:**
For a simple run job that calls an external API, I needed to consult 4 different documentation topics. This is fine for comprehensive understanding, but for quick tasks it feels like a lot of back-and-forth.

**Potential solution (if known):**
Consider adding a "quickstart-run-job" or "quickstart-api-call" topic that combines:
- Basic run.job structure
- Function definition basics  
- api.request syntax
- Common error handling patterns

This would be a single call for the most common use case.

---

## [2026-02-17 06:16 PST] - String Concatenation with Filters

**What I was trying to do:**
Build an error message that combines text with a filtered value: `$api_result.response.status|to_text`

**What the issue was:**
I initially wrote: `"status " ~ $api_result.response.status|to_text`

The documentation mentions this pattern requires parentheses around filtered expressions, but it's easy to miss in the large syntax document.

**Why it was an issue:**
The error message for this specific mistake might not be as clear as other validation errors. I caught it because I remembered seeing it in the docs, but it could trip up others.

**Potential solution (if known):**
The syntax doc does cover this well with the "String Concatenation with Filters" section. Maybe elevate this to the quick reference at the top of the syntax doc, or include it in a "Common Mistakes" section.

---

## General Feedback

**What worked well:**
1. The MCP validation tool is excellent - caught my syntax error immediately with clear line/column info
2. The documentation is comprehensive and well-organized by topic
3. The run job structure is intuitive once you see an example

**What could be improved:**
1. A single "run job with API call" complete example in one place would be super helpful
2. The no-commas-between-properties rule should be more prominent since it's different from JSON/JS
3. Consider a "validate_xanoscript --fix" mode that auto-corrects common mistakes like trailing commas

---

## MCP Server Version

Version from `mcp_version`: (tool not called, but server responded successfully to all requests)

---

*This feedback was generated during the creation of the gumroad-create-sale run job on 2026-02-17.*
