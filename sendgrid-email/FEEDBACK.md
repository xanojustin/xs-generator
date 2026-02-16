# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 08:47 PST] - Issue: api.request 'body' parameter naming

**What I was trying to do:**
Create an API request to SendGrid to send an email, passing the email payload as the request body.

**What the issue was:**
I initially used `body = $email_payload` in the `api.request` block, following common REST API conventions where "body" is the standard term for request payload.

**Why it was an issue:**
The validator failed with error: "The argument 'body' is not valid in this context" and suggested using "params" instead.

**Potential solution:**
The MCP documentation or error message was helpful in suggesting the correct parameter name. However, this is a bit unintuitive since "params" typically refers to URL query parameters in most HTTP contexts, while "body" is the standard term for POST/PUT request payloads. Consider allowing "body" as an alias for "params" for better developer experience, or document this more prominently.

---

## [2026-02-16 08:47 PST] - Issue: Filter/test expression parentheses requirement

**What I was trying to do:**
Validate email format by checking if an array has at least 2 elements using `$parts|count >= 2`.

**What the issue was:**
The validator failed with: "An expression should be wrapped in parentheses when combining filters and tests" for the line `if ($parts|count >= 2)`.

**Why it was an issue:**
This syntax is unintuitive. In most programming languages and templating systems, you can chain filters with comparisons without extra parentheses. The expression `$parts|count >= 2` reads naturally as "count of parts is greater than or equal to 2", but XanoScript requires `($parts|count) >= 2`.

Same issue occurred with `$local_part|strlen > 0 && $domain_part|strlen > 0` needing to become `($local_part|strlen) > 0 && ($domain_part|strlen) > 0`.

**Potential solution:**
The parser should be able to handle operator precedence with filters without requiring manual parentheses. If this is by design for clarity, the error message is helpful but the requirement adds friction to development.

---

## [2026-02-16 08:47 PST] - Issue: Limited MCP documentation

**What I was trying to do:**
Get comprehensive documentation about XanoScript syntax and best practices.

**What the issue was:**
The MCP's `xanoscript_docs` tool has different topics, but the documentation is quite sparse. For example, the `run` topic only returned basic information about run jobs without showing detailed syntax examples.

**Why it was an issue:**
Had to infer syntax from the existing stripe-payment example in the repository. Without that reference, it would have been much harder to understand the structure of run.xs files and function definitions.

**Potential solution:**
Add more comprehensive documentation topics or examples covering:
- Complete run.job syntax with all available options
- All available api.request parameters and their valid values
- Common patterns for API integrations
- Error handling best practices
- Database operation examples

---

## [2026-02-16 08:47 PST] - Positive Feedback: Validation Tool

**What worked well:**
The `validate_xanoscript` tool is excellent! It provides:
- Clear error messages with line and column numbers
- Helpful suggestions for fixing issues
- Clean output that's easy to understand

**Why it matters:**
Real-time validation with helpful error messages made it easy to identify and fix syntax issues quickly. The suggestions were accurate and led directly to working solutions.

**Suggestion:**
Consider adding a "strict mode" that could catch potential issues like unused variables or unreachable code.

---

## Summary

Overall, the MCP tools work well but the learning curve is steep due to:
1. Non-obvious parameter naming (params vs body)
2. Strict parentheses requirements for filter chains
3. Sparse documentation requiring trial and error

The validator is the standout feature that makes development manageable despite these challenges.
