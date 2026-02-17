# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 17:47 PST] - Comment Syntax Not Supported

**What I was trying to do:**
Add a helpful comment in the run.xs file to document that the user should replace the placeholder service_id with their actual PagerDuty service ID.

**What the issue was:**
I used standard JavaScript-style comment syntax `// Replace with your PagerDuty service ID` which caused a validation error:
```
[Line 8, Column 30] Expecting --> } <-- but found --> '/' <--
```

**Why it was an issue:**
XanoScript doesn't appear to support `//` single-line comments or `/* */` block comments. This is unexpected since comments are standard in most programming languages and are essential for documentation.

**Potential solution (if known):**
- Document clearly that XanoScript doesn't support comments
- Or implement comment support in the language
- Or provide an alternative documentation mechanism

---

## [2026-02-16 17:46 PST] - Limited Documentation on String Concatenation in Headers

**What I was trying to do:**
Construct the Authorization header with Bearer token by concatenating the string "Bearer " with the environment variable.

**What the issue was:**
I wasn't 100% sure if the string concatenation syntax `~` would work within the headers array. The quick reference showed string concatenation examples but not specifically in headers context.

**Why it was an issue:**
While it worked, there was uncertainty about whether special characters or escaping would be needed within the header string construction.

**Potential solution (if known):**
- Add examples showing header construction with dynamic values in the integrations documentation
- Show more real-world API request examples

---

## [2026-02-16 17:45 PST] - PagerDuty API Requires "From" Header (Undocumented Limitation)

**What I was trying to do:**
Call the PagerDuty REST API to create an incident using the standard API key authentication pattern I saw in other examples.

**What the issue was:**
PagerDuty's REST API v2 requires a `From` header containing the email address of the user making the request when creating incidents. However, I only discovered this by reading PagerDuty's external documentation, not from any XanoScript guidance.

**Why it was an issue:**
The XanoScript docs don't mention common third-party API patterns like required headers. This could lead to mysterious 400 errors without clear guidance on what's missing.

**Potential solution (if known):**
- The MCP worked correctly - this is more about the API being called
- Consider adding a "common API patterns" section to docs covering popular services

---

## [2026-02-16 17:44 PST] - API Documentation Missing for Response Structure

**What I was trying to do:**
Understand the exact structure of the api.request response object to properly access status codes and response data.

**What the issue was:**
While the quickstart mentioned `$result.response.status`, `$result.response.result`, and `$result.response.headers`, it wasn't clear if there were other fields or what the exact structure was.

**Why it was an issue:**
Had to infer the structure from examples. Would be helpful to have a formal schema definition for the api.request response object.

**Potential solution (if known):**
- Add a dedicated section showing the complete response schema
- Include type definitions for the response object

---

## [2026-02-16 17:43 PST] - Good Experience Overall

**What went well:**
- The `xanoscript_docs` tool was easy to use and provided helpful information
- The `validate_xanoscript` tool gave clear error messages with line/column numbers
- The examples in the documentation were helpful for understanding patterns
- The quick reference format was efficient for getting syntax information

**Positive feedback:**
- Clear error messages made debugging fast
- Having access to topic-based docs was useful
- Validation catching the comment syntax issue early prevented runtime errors

---

## Summary

Overall the Xano MCP worked well for this task. The main friction points were:
1. **Comment syntax** - Unexpected that comments aren't supported
2. **Limited API integration examples** - More real-world patterns would help
3. **Response object documentation** - Could be more detailed

The validation tool was excellent and caught issues immediately. The documentation was sufficient to complete the task but could benefit from more depth in areas mentioned above.