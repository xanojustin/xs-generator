# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 15:18 PST] - Initial Setup Smooth

**What I was trying to do:**
Set up the Xano MCP and get documentation for creating a run job.

**What the issue was:**
No issues - the MCP was already configured and available via mcporter.

**Why it was an issue:**
N/A - worked as expected

**Potential solution (if known):**
N/A

---

## [2026-02-13 15:20 PST] - Documentation Retrieval Was Good

**What I was trying to do:**
Get xanoscript_docs for run jobs, quickstart, and integrations topics.

**What the issue was:**
The documentation was comprehensive and well-structured. No issues.

**Why it was an issue:**
N/A - documentation worked well

**Potential solution (if known):**
The docs were helpful. One suggestion: would be nice to have a "validate_file" tool that accepts a file path instead of just code string, to avoid shell escaping issues.

---

## [2026-02-13 15:22 PST] - Validation Tool Works Well

**What I was trying to do:**
Validate the .xs files I created using the validate_xanoscript tool.

**What the issue was:**
Had to use `cat` and command substitution to pass file contents to the code parameter. This could potentially cause issues with special characters or quotes in the code.

**Why it was an issue:**
While it worked for my simple files, passing code through shell command substitution is fragile. A file_path parameter would be more robust.

**Potential solution (if known):**
Add a `file_path` parameter to `validate_xanoscript` so users can validate files directly without reading them into shell variables first.

---

## [2026-02-13 15:25 PST] - Missing Twilio-Specific Examples

**What I was trying to do:**
Find examples of form-encoded API requests in the documentation.

**What the issue was:**
The integrations docs show many examples (AWS S3, Algolia, Elasticsearch) but didn't have a clear example of form-encoded POST requests (like Twilio uses).

**Why it was an issue:**
Had to infer from the general api.request pattern that form-encoded data would work with `params`. Wasn't 100% sure if Twilio's Basic auth format needed special handling.

**Potential solution (if known):**
Add a "Common API Patterns" section showing:
1. JSON API requests (OpenAI, etc.)
2. Form-encoded requests (Twilio, etc.)  
3. Bearer token auth
4. Basic auth with base64 encoding

---

## [2026-02-13 15:28 PST] - Unclear Basic Auth Handling

**What I was trying to do:**
Implement Basic authentication for the Twilio API.

**What the issue was:**
The docs don't explicitly state how Basic auth should be formatted. I assumed XanoScript would handle base64 encoding when it sees "Authorization: Basic ..." but wasn't sure.

**Why it was an issue:**
Twilio requires `Authorization: Basic base64(AccountSid:AuthToken)`. I wrote the code assuming XanoScript handles this, but there's no confirmation in the docs.

**Potential solution (if known):**
Add explicit documentation about:
1. Does XanoScript auto-base64 encode Basic auth headers?
2. Is there a filter for base64 encoding (`|base64_encode`)?
3. Example of proper Basic auth format

---

## [2026-02-13 15:30 PST] - Overall Positive Experience

**Summary:**
The MCP worked well overall. Documentation was comprehensive, validation was quick and accurate, and I was able to create a working run job without major blockers. The main areas for improvement are:

1. Add file_path parameter to validate_xanoscript
2. Add form-encoded API examples
3. Clarify Basic auth handling
4. Consider adding more external API examples (Twilio, SendGrid webhooks, etc.)

The tool is solid and the documentation is thorough. These are polish items, not critical issues.
