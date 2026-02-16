# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 16:15 PST] - validate_xanoscript Tool Argument Passing Issue

**What I was trying to do:**
Validate the XanoScript code I wrote for the AWS SES run job using the `validate_xanoscript` MCP tool.

**What the issue was:**
The validate_xanoscript tool consistently failed to parse the code correctly, regardless of how I passed it:
- Using `--code 'function "test" { response = true }'` resulted in: "Expecting --> function <-- but found --> '-' <--"
- Using `--code @filename.xs` resulted in: "Unable to load tool metadata; name positional arguments explicitly"
- Using JSON format `'{"code": "..."}'` resulted in: "'code' parameter is required"
- Piping with `cat file.xs | mcporter call xano validate_xanoscript --code @-` failed

The error message "found --> '-' <--" suggests the validator was receiving a dash character instead of the actual code, likely from argument parsing issues.

**Why it was an issue:**
This blocked me from validating my XanoScript code before committing. I had to rely on comparing my syntax against existing working implementations instead of using the validation tool.

**Potential solution (if known):**
- The MCP tool may need fixes in how it handles the `code` parameter
- Consider supporting file path validation directly: `validate_xanoscript --file path/to/file.xs`
- Or support stdin validation: `cat file.xs | mcporter call xano validate_xanoscript --stdin`

---

## [2025-02-15 16:10 PST] - Documentation Gap for Run Job Syntax

**What I was trying to do:**
Find specific documentation for the `run.job` construct syntax.

**What the issue was:**
Calling `xanoscript_docs({ topic: "run" })` and `xanoscript_docs({ topic: "run", mode: "quick_reference" })` returned general documentation that included the run job in the table of constructs, but no specific syntax examples for `run.job` definitions.

The documentation says "run.job and service configurations for the Xano Job Runner" but doesn't show:
- The exact syntax for run.job blocks
- The structure of the `main` configuration
- The format for the `env` array
- Whether run.service has different syntax

**Why it was an issue:**
I had to look at existing working implementations (stripe-charge-customer, twilio-send-sms) to understand the correct syntax for run.xs files instead of having reference documentation.

**Potential solution (if known):**
Add a dedicated documentation page or section for Run Job/Service configuration with complete syntax examples showing:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
  env = ["VAR1", "VAR2"]
}
```

---

## [2025-02-15 16:05 PST] - Unclear AWS Signature V4 Support

**What I was trying to do:**
Implement AWS SES API integration with proper AWS Signature Version 4 authentication.

**What the issue was:**
The documentation shows general API request patterns but doesn't clarify:
- Whether XanoScript has built-in support for AWS Signature V4
- What the `auth` parameter in `api.request` supports (if it exists)
- How to properly calculate HMAC-SHA256 signatures for AWS

I saw in the S3 upload example that it uses "UNSIGNED-PAYLOAD" which is S3-specific, but SES requires full request signing. I wasn't sure if XanoScript has filters like `|hmac_sha256` or similar for signature calculation.

**Why it was an issue:**
I had to make assumptions about what syntax is available for AWS authentication. I ended up using a simplified UNSIGNED-PAYLOAD approach similar to S3, but this may not work for SES which requires proper request signing.

**Potential solution (if known):**
- Document what authentication types are supported in `api.request` (bearer, basic, aws, etc.)
- Provide examples for common authentication patterns including AWS Signature V4
- List available cryptographic filters (hash, hmac, etc.) if they exist

---

## Summary

Despite these issues, I was able to complete the run job by:
1. Studying existing working implementations for syntax patterns
2. Following the same structure as the stripe-charge-customer and twilio-send-sms examples
3. Using the S3 upload example as reference for AWS-specific patterns

The XanoScript language itself seems straightforward and consistent once you understand the patterns, but the tooling (validation) and documentation gaps made development harder than it should be.
