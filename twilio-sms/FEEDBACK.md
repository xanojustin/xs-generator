# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 09:15 PST] - Comments at Beginning of File Cause Parse Errors

**What I was trying to do:**
Create XanoScript files with comments at the top explaining what the file does (standard practice in most programming languages).

**What the issue was:**
When I added comments like `// Twilio SMS Send Function` at the top of .xs files, the validator returned errors like:
```
[Line 3, Column 1] Expecting --> function <-- but found --> '
```

The parser seemed to be confused by the comments preceding the actual definition.

**Why it was an issue:**
This was blocking because I couldn't validate files with comments. I had to remove all comments from the .xs files to get them to pass validation.

**Potential solution (if known):**
Either:
1. Allow comments at the beginning of files (preferred)
2. Document clearly that files must start with the definition keyword
3. Improve the error message to say "Comments must come after the definition" instead of the cryptic error about finding a quote

---

## [2026-02-16 09:20 PST] - Unclear Error Message for Invalid Syntax

**What I was trying to do:**
Debug why my files weren't validating.

**What the issue was:**
The error message `Expecting --> function <-- but found --> '<--` was confusing because there was no visible single quote character at the start of my files (verified with hex dump). The actual issue was that comments weren't allowed before the definition.

**Why it was an issue:**
The error message led me down the wrong path - I was looking for quote character encoding issues when the real issue was comment placement.

**Potential solution (if known):**
The validator should provide clearer error messages. Instead of showing the first character after comments, it should say something like "Comments must appear after the definition block" or "File must start with a definition (function, run.job, etc.)".

---

## [2026-02-16 09:22 PST] - Need to Call xanoscript_docs Before Writing Code (Documentation Discoverability)

**What I was trying to do:**
Write XanoScript code for a run job.

**What the issue was:**
The prompt correctly instructed me to call `xanoscript_docs` before writing any code because my training data doesn't include XanoScript syntax. However, it wasn't immediately obvious which topics I needed to call. I ended up calling multiple topics (run, quickstart, integrations) to get the full picture.

**Why it was an issue:**
It took multiple tool calls to gather all the necessary documentation. I had to discover which topics existed by reading the initial docs response.

**Potential solution (if known):**
Consider having a `xanoscript_docs topic=run-job-guide` or similar that bundles all relevant docs for common use cases, or provide a "getting started for AI assistants" topic that lists the minimum required topics to read for different tasks.

---

## [2026-02-16 09:25 PST] - No Base64 Encode Filter Documented

**What I was trying to do:**
Create a Basic Auth header for the Twilio API, which requires base64 encoding of `account_sid:auth_token`.

**What the issue was:**
Looking through the quickstart and syntax documentation, I saw `base64_encode` mentioned in the filter list, but I wasn't 100% sure of the exact syntax for using it.

**Why it was an issue:**
While I found it eventually, clearer documentation on auth patterns (Basic Auth, Bearer tokens) would be helpful since they're extremely common for API integrations.

**Potential solution (if known):**
Add an "Authentication Patterns" section to the integrations or quickstart docs showing:
- Basic Auth with base64_encode
- Bearer token patterns
- Common API key patterns

---

## [2026-02-16 09:27 PST] - While Loop with Each Syntax Confusion

**What I was trying to do:**
Understand how to use while loops properly.

**What the issue was:**
The quickstart shows:
```xs
while ($counter < 10) {
  each {
    var.update $counter { value = $counter + 1 }
  }
}
```

But it wasn't clear why `each` is needed inside the `while` block or what `each` means in this context (it seems different from `each ($items as $item)` for iteration).

**Why it was an issue:**
The `each` keyword being used in two different ways (iteration vs loop body) is confusing. The documentation doesn't explain why `each` is required inside `while`.

**Potential solution (if known):**
Document the requirement that `while` blocks must contain an `each` block for the loop body, and explain that this `each` is different from the iteration form.

---

## Summary

Overall the MCP worked well once I understood the constraints:
1. No comments at file start
2. Must validate frequently during development
3. Documentation is comprehensive but requires multiple queries

The validator is the most helpful tool - it caught my mistakes immediately. The error messages could be more user-friendly, especially around the comment placement issue.
