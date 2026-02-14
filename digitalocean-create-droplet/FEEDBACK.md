# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-14 13:15 PST - No Critical Issues Encountered

**What I was trying to do:**
Create a DigitalOcean run job that creates a droplet (virtual machine) using the DigitalOcean API.

**What the issue was:**
No major issues encountered during this implementation. The MCP validation tools worked correctly on the first attempt.

**Why it was an issue:**
N/A - This was a successful implementation.

**Potential solution (if known):**
N/A

---

## 2026-02-14 13:10 PST - Minor Learning: run.job Syntax

**What I was trying to do:**
Understand the correct syntax for run.job input parameters (whether they need explicit type declarations).

**What the issue was:**
Initially wasn't sure if the run.job input block needed type declarations like `text name` or if just `name: "value"` was sufficient.

**Why it was an issue:**
The documentation showed different patterns in different places - some examples showed typed inputs, others showed simple key-value pairs in the `main.input` block.

**Potential solution (if known):**
The documentation could clarify that `run.job` doesn't need type declarations in the `main.input` block - those are passed as-is to the function. The types are declared in the `function` definition's `input` block instead. The quickstart documentation does show this pattern, but it's not explicitly called out.

---

## 2026-02-14 13:05 PST - Documentation Request: More External API Examples

**What I was trying to do:**
Find examples of external API integrations with Bearer token authentication patterns.

**What the issue was:**
While the general pattern for API requests was documented, there weren't many examples of common auth patterns like Bearer tokens vs API keys in query params.

**Why it was an issue:**
Had to infer the correct pattern from the generic examples. Would be helpful to have a dedicated section on common authentication patterns (Bearer tokens, Basic auth, API keys, OAuth).

**Potential solution (if known):**
Add a section to the integrations or quickstart documentation showing:
1. Bearer token auth: `"Authorization: Bearer " ~ $env.API_TOKEN`
2. Basic auth: `"Authorization: Basic " ~ $credentials|base64_encode`
3. API key in header: `"X-API-Key: " ~ $env.API_KEY`
4. API key in query param: `url = $env.BASE_URL ~ "/endpoint?api_key=" ~ $env.API_KEY`

---

## General Notes

### What Worked Well

1. **MCP validation was fast and accurate** - Both files validated on first try with no errors
2. **Documentation was comprehensive** - The run.xs and quickstart docs covered all patterns needed
3. **Error handling patterns were clear** - The precondition and try_catch patterns are well documented
4. **String concatenation with `~` operator** - Easy to understand and use for building auth headers

### Suggestions for Improvement

1. **Add a "Common API Integrations" cookbook section** with working examples for:
   - Stripe
   - SendGrid/Resend
   - AWS APIs (SigV4 signing)
   - DigitalOcean
   - GitHub
   - Slack/Discord webhooks

2. **Environment variable best practices** - Document the naming convention (snake_case vs UPPER_CASE) and where to set them in the Xano dashboard

3. **Debugging tips** - Add a section on how to debug run jobs (using debug.log, checking response objects)
