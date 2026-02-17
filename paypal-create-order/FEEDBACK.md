# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 04:18 PST] - Issue 1: util.timestamp Not Available

**What I was trying to do:**
Create an AWS S3 upload function that requires AWS Signature Version 4 authentication. This authentication scheme requires generating timestamps in specific formats.

**What the issue was:**
I attempted to use `util.timestamp` to generate formatted timestamps, but the MCP validation returned an error:
```
[Line 12, Column 10] Expecting: one of these possible Token sequences:
  1. [ip_lookup]
  2. [get_env]
  3. [sleep]
  ...
but found: 'timestamp'
```

The validator suggested these valid utility functions: `ip_lookup`, `get_env`, `sleep`, `get_all_input`, `get_raw_input`, `get_vars`, `geo_distance`, `post_process`, `set_header`, `template_engine`, `send_email`.

**Why it was an issue:**
AWS Signature V4 requires generating timestamps in specific formats (`YYYYMMDD'T'HHmmss'Z'`). Without a timestamp utility, implementing AWS SigV4 authentication becomes extremely difficult or impossible in XanoScript.

**Potential solution (if known):**
1. Add `util.timestamp` or similar function to XanoScript
2. Document how to get current date/time in XanoScript using existing functions
3. Provide examples of AWS authentication in Xano documentation

---

## [2025-02-17 04:22 PST] - Issue 2: Type Declaration Confusion

**What I was trying to do:**
Declare an input parameter for an array of objects (`purchase_units`) in the PayPal function.

**What the issue was:**
I initially tried `object[] purchase_units` which is a common pattern in many languages, but the validator rejected it with:
```
Suggestion: Use "json" instead of "object"
```

I had to change it to `json purchase_units` to pass validation.

**Why it was an issue:**
The documentation shows that XanoScript uses `json` type for arbitrary JSON data, but the distinction between when to use `json` vs `object` (or if `object` even exists) wasn't clear. The error message was helpful but required trial and error.

**Potential solution (if known):**
1. Clarify in documentation that `json` is the preferred type for object/array data
2. Consider adding `object` and `object[]` as aliases to `json` for developer familiarity
3. Provide a comprehensive type compatibility table in docs

---

## [2025-02-17 04:25 PST] - Issue 3: Input Parameter Description Syntax Inconsistency

**What I was trying to do:**
Add descriptions to input parameters using the same syntax I saw in the Stripe example.

**What the issue was:**
When I tried:
```
text intent { description = "Order intent" }
object[] purchase_units { description = "Array of purchase units" }
```

The validator gave cryptic errors like:
```
[Line 5, Column 31] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: 'description'
```

However, looking at the existing `stripe-create-charge` implementation, the same syntax appears to work fine there.

**Why it was an issue:**
The error message was confusing and didn't clearly indicate that the problem was actually with the `object[]` type rather than the description syntax itself. The description syntax is actually valid, but the combination with an invalid type caused a misleading error.

**Potential solution (if known):**
1. Improve parser error messages to be more specific about which part of a declaration failed
2. Consider validating type declarations before other syntax to give clearer errors

---

## [2025-02-17 04:27 PST] - Issue 4: Limited MCP Documentation Depth

**What I was trying to do:**
Get specific documentation about available functions and utilities in XanoScript.

**What the issue was:**
Calling `xanoscript_docs({ topic: "integrations/external-apis" })` returned the same generic overview documentation instead of specific external API integration patterns.

**Why it was an issue:**
The MCP documentation tool appears to return the same general documentation regardless of the specific topic requested. This makes it difficult to find specific information about:
- Available utility functions
- How to work with dates/times
- Available filters and their usage
- Best practices for specific integrations

**Potential solution (if known):**
1. Ensure the MCP server returns topic-specific documentation
2. Add a function to list available built-in functions/utilities
3. Provide a searchable function reference

---

## Summary of Key Learnings

1. **Type System**: Use `json` for object/array data, not `object` or `object[]`
2. **Available Utils**: Only specific utilities exist (`ip_lookup`, `get_env`, `sleep`, etc.)
3. **No Timestamp**: There's no built-in timestamp function for date formatting
4. **Validation**: The MCP validator is very helpful with specific error messages and suggestions
