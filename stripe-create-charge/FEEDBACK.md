# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 11:47 PST] - Documentation Discovery Challenge

**What I was trying to do:**
Create a XanoScript run job for Stripe integration. I needed to understand the correct syntax for run.job, function definitions, and external API calls.

**What the issue was:**
I had to make multiple separate calls to xanoscript_docs to get complete information:
1. First call for run job structure (topic=run)
2. Second call for function syntax (topic=functions)
3. Third call for API request syntax (found in topic=integrations)

Each call returned a large document, and I had to piece together how these concepts work together.

**Why it was an issue:**
It was inefficient and required multiple round-trips to get the full picture. I wasn't sure which topic would contain the api.request documentation (it was in integrations, not functions or apis).

**Potential solution (if known):**
Consider adding a "quickstart" or "run-job-example" topic that includes a complete, working example with:
- A run.job definition
- A function that uses api.request
- Comments explaining each part

Or add cross-references at the end of each doc: "Related topics: functions, integrations, apis"

---

## [2025-02-16 11:48 PST] - MCP Tool Not in PATH

**What I was trying to do:**
Call xanoscript_docs directly from the command line.

**What the issue was:**
The xanoscript_docs command wasn't available in my PATH. I had to use mcporter to access it, which wasn't immediately obvious.

```
$ which xanoscript_docs
Not in PATH
```

**Why it was an issue:**
The task instructions said to "call `xanoscript_docs` on the xano MCP" which I interpreted as a standalone command. It took extra time to discover I needed to use mcporter as a wrapper.

**Potential solution (if known):**
Consider creating a shell alias or wrapper script that makes xanoscript_docs available directly, or update documentation to explicitly say "use mcporter call xano.xanoscript_docs" rather than just "call xanoscript_docs".

---

## [2025-02-16 11:50 PST] - API Request Content-Type Confusion

**What I was trying to do:**
Create a Stripe API request with proper headers. Stripe's API accepts both JSON and form-encoded data.

**What the issue was:**
The api.request documentation shows `params` for the request body, but it's unclear:
1. Whether params are automatically encoded based on Content-Type
2. How to send form-encoded data (Stripe's preferred method)
3. Whether I need to manually serialize the payload

The example shows:
```xs
api.request {
  params = $payload
  headers = ["Content-Type: application/json"]
}
```

But Stripe typically uses `application/x-www-form-urlencoded`.

**Why it was an issue:**
I wasn't confident whether XanoScript would automatically encode the params object as form data or JSON. I had to guess that it would handle it appropriately based on the Content-Type header.

**Potential solution (if known):**
Add explicit documentation about:
- How params are serialized (auto-JSON vs auto-form-encoded based on Content-Type)
- An example using form-encoded data for APIs like Stripe
- Whether manual serialization is ever needed

---

## [2025-02-16 11:52 PST] - Validation Success But No Deep Checking

**What I was trying to do:**
Validate my XanoScript files to ensure they would actually work when deployed.

**What the issue was:**
The validate_xanoscript tool passed my files, but I'm uncertain whether it checks for:
- Invalid environment variable references
- Undefined function calls
- Type mismatches in inputs
- Runtime errors that would occur

**Why it was an issue:**
The validation gives a false sense of security. My code passed validation, but if I had misspelled `$env.stripe_secret_key` or used a non-existent function, would it have caught that?

**Potential solution (if known):**
Consider adding a "strict" validation mode that checks:
- All referenced environment variables are documented in the run.job
- All function.run calls reference existing functions
- Type compatibility between function inputs and call sites
- Warning for potentially undefined variables

---

## [2025-02-16 11:55 PST] - Missing Testing/Local Execution Info

**What I was trying to do:**
Test my run job locally before committing.

**What the issue was:**
The documentation doesn't explain how to test a run job locally without deploying to Xano. There's no clear path for:
- Running the job against a test Xano instance
- Mocking the Stripe API for testing
- Unit testing the function in isolation

**Why it was an issue:**
I'm committing code to GitHub without actually executing it. The validation only checks syntax, not correctness.

**Potential solution (if known):**
Add documentation about:
- How to test run jobs locally using Xano CLI
- How to set up a test workspace
- Best practices for testing external API integrations (mocking, test tokens)

---

## [2025-02-16 11:57 PST] - Error Handling Pattern Uncertainty

**What I was trying to do:**
Implement proper error handling for the Stripe API call.

**What the issue was:**
The documentation shows multiple error handling approaches:
1. `precondition` blocks
2. `conditional` with `throw`
3. `try-catch` (mentioned but not shown in detail)

I wasn't sure which is the "right" way to handle HTTP API errors in XanoScript.

**Why it was an issue:**
I chose to use `conditional` with `throw`, but I'm not sure if that's the idiomatic approach. Should I use `precondition` instead? Is there a built-in way to handle HTTP errors specifically?

**Potential solution (if known):**
Add a section specifically about HTTP API error handling patterns with recommended approaches for:
- Checking status codes
- Handling different error types
- Logging vs throwing errors
- Retrying failed requests

---

## Summary

**Overall Experience:**
The MCP worked well for getting documentation, but required multiple calls to piece together a complete solution. The validation tool is helpful for syntax checking but doesn't catch semantic errors.

**Biggest Friction Points:**
1. Documentation is fragmented across multiple topics
2. No clear "complete example" for the most common use case (run job + external API)
3. No local testing capability documented
4. Uncertainty about best practices for error handling

**What Worked Well:**
- The documentation is comprehensive and well-structured once you find it
- Validation is fast and gives clear file-by-file results
- The quick_reference mode is useful for reducing token usage
- Having separate topics for different concepts keeps docs focused
