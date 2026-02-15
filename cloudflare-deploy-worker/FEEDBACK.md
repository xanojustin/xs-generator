# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 10:15 PST] - Initial MCP Connection Delay

**What I was trying to do:**
Start the Xano MCP server to get documentation for building a run job.

**What the issue was:**
Running `npx @xano/developer-mcp --help` hung and showed "Process still running" for a while. I had to use `mcporter` instead, which worked well once I discovered it was already configured.

**Why it was an issue:**
It wasn't clear initially how to access the MCP. The raw npx approach didn't work as expected.

**Potential solution (if known):**
Document the recommended way to interact with the MCP (via mcporter when available) more prominently. The mcporter skill worked great.

---

## [2025-02-15 10:17 PST] - Multiple Documentation Calls Required

**What I was trying to do:**
Understand XanoScript syntax to build a run job with a function that makes API calls.

**What the issue was:**
I had to make 5 separate `xanoscript_docs` calls to get the full picture:
1. `topic=run` - for run.job structure
2. `topic=quickstart` - for common patterns
3. `topic=functions` - for function syntax
4. `topic=syntax` - for expressions and filters
5. `topic=integrations` - for api.request patterns

**Why it was an issue:**
Each call consumed tokens and time. A single "build a run job" consolidated documentation or a "quickstart for run jobs with API calls" would be more efficient.

**Potential solution (if known):**
Consider adding a `topic=run_job_complete` that combines run, function, and api.request patterns into one document. Or add a `mode=compact` that includes more cross-references.

---

## [2025-02-15 10:20 PST] - No AWS SES Integration Available

**What I was trying to do:**
Initially planned to build an AWS SES email sender since it hasn't been done yet.

**What the issue was:**
AWS SES requires AWS Signature Version 4 authentication, which is complex to implement manually in XanoScript. There's no built-in `cloud.aws.ses.*` helper like there is for S3.

**Why it was an issue:**
Had to pivot to Cloudflare Workers instead, which has simpler Bearer token auth. The S3 integration exists but SES doesn't, making SES impractical for a quick run job.

**Potential solution (if known):**
Add `cloud.aws.ses.send_email` similar to `util.send_email` with other providers. AWS SES is very popular for transactional email.

---

## [2025-02-15 10:22 PST] - Unclear About api.request Body Parameter

**What I was trying to do:**
Make a PUT request with a raw JavaScript string as the body.

**What the issue was:**
The documentation says "params = $payload" for the request body, which is counterintuitive naming. I had to double-check the integrations docs to confirm `params` is indeed the request body for POST/PUT/PATCH.

**Why it was an issue:**
Naming it `params` when it's actually the body is confusing. Most developers expect `body` or `data`.

**Potential solution (if known):**
Consider aliasing `body` to `params` for clarity, or at least documenting more prominently that `params` = request body.

---

## [2025-02-15 10:25 PST] - Validation Worked Well

**What I was trying to do:**
Validate the XanoScript files before committing.

**What the issue was:**
None - validation worked perfectly on the first try for both files!

**Why it was a positive:**
The validate_xanoscript tool caught no errors, meaning the documentation was clear enough to write correct code.

---

## [2025-02-15 10:26 PST] - String Concatenation in Error Messages

**What I was trying to do:**
Build error messages that include status codes and JSON responses.

**What the issue was:**
Had to remember to wrap filtered expressions in parentheses: `($api_result.response.status|to_text)` instead of `$api_result.response.status|to_text`.

**Why it was an issue:**
Easy to forget this rule when concatenating strings with filters. The error wouldn't show until runtime.

**Potential solution (if known):**
The quickstart guide documents this well, but maybe the validator could warn about potentially ambiguous filter chains in string concatenation contexts.

---

## Summary

**What worked well:**
- `mcporter` integration was smooth once discovered
- Documentation is comprehensive and well-organized by topic
- `validate_xanoscript` tool is fast and accurate
- Error handling patterns (throw, precondition) are clear
- The `conditional` block syntax is straightforward

**Areas for improvement:**
1. Add more cloud service integrations (AWS SES, Lambda, etc.)
2. Consider consolidating documentation for common use cases (run job + API call)
3. The `params` naming for request body is confusing
4. Pre-flight validation for string concatenation with filters could be helpful

**Overall:**
Building this run job was straightforward. The documentation quality is high, and having a validator made the development loop fast. Only had to make minor adjustments for string concatenation syntax.
