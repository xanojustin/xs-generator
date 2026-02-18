# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 06:18 PST] - Run Job Input Block Syntax Confusion

**What I was trying to do:**
Create a run.job with optional input parameters using the `?` syntax (e.g., `mobile_phone?: ""`)

**What the issue was:**
The validation failed with: "Expecting --> : <-- but found --> '?' <--" on line 9 of run.xs

**Why it was an issue:**
I incorrectly assumed that run.job input blocks would support the same optional parameter syntax (`text mobile_phone?`) that's supported in function input blocks. The error message was clear but I had to discover through trial and error that run.job input values must be simple constants without type annotations or optional markers.

**Potential solution (if known):**
- Update documentation to clearly state that run.job input values are raw JSON/object values, not typed XanoScript input blocks
- Add an example in the run documentation showing the difference between function input blocks and run.job input blocks

---

## [2026-02-18 06:15 PST] - Documentation Discovery Issues

**What I was trying to do:**
Find documentation about run.job syntax and XanoScript syntax before writing code

**What the issue was:**
The `xanoscript_docs` tool returned an "Unknown topic" error for "quick_reference" and "runjob" topics. I had to discover the correct topic names by trial and error.

**Why it was an issue:**
The available topics weren't listed in the initial tool description, so I had to call the tool with invalid topics to get the list of valid topics. This added unnecessary round trips.

**Potential solution (if known):**
- Include the list of valid topics directly in the tool description or a "topics" command
- Support common aliases like "quick_reference" for "cheatsheet"

---

## [2026-02-18 06:16 PST] - String Concatenation with Filters Syntax

**What I was trying to do:**
Build the Okta API URL by concatenating the org URL with the endpoint path

**What the issue was:**
I initially wrote: `$env.OKTA_ORG_URL|trim ~ "/api/v1/users"` without parentheses around the filtered expression.

**Why it was an issue:**
According to the docs, filters in concatenations must be wrapped in parentheses: `($env.OKTA_ORG_URL|trim) ~ "/api/v1/users"`. While the docs clearly state this, it's an easy mistake to make and the parse error might be confusing for beginners.

**Potential solution (if known):**
- The documentation already covers this well in the "Common Mistakes" section
- Consider a more helpful error message suggesting parentheses when a filter is detected in a concatenation context

---

## [2026-02-18 06:17 PST] - Error Handling Pattern Discovery

**What I was trying to do:**
Implement proper error handling for different HTTP status codes from the Okta API

**What the issue was:**
I needed to look at multiple documentation topics (syntax, quickstart, run) to understand:
1. How to use `conditional` blocks with `if/elseif/else`
2. How to use `throw` blocks for custom errors
3. The structure of `api.request` response objects

**Why it was an issue:**
The information was scattered across topics. I needed to piece together the pattern from multiple sources.

**Potential solution (if known):**
- Add a comprehensive "API Integration" or "External API" topic that shows a complete example including:
  - Making the request
  - Handling different status codes
  - Throwing custom errors
  - Building response objects

---

## Positive Feedback

**What worked well:**

1. **Validation tool is excellent** - The validate_xanoscript tool provides clear, actionable error messages with line and column numbers. This was critical for fixing the run.xs issue quickly.

2. **Documentation is comprehensive** - Once I found the right topics, the documentation was thorough with good examples. The "Common Mistakes" section in quickstart was particularly helpful.

3. **Cheat sheet format** - The cheatsheet topic is well-organized with the 20 most common patterns. Easy to scan quickly.

4. **Response structure documentation** - The `api.request` response structure ($result.response.status, $result.response.result, etc.) was clearly documented.

---

## Summary

Overall, the Xano MCP worked well. The main friction points were:
1. Discovering the correct documentation topics
2. Understanding the difference between run.job input syntax vs function input syntax
3. Remembering to wrap filtered expressions in parentheses during string concatenation

The validation tool caught my syntax errors immediately and the error messages were clear enough to fix the issues.
