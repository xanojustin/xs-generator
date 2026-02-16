# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 12:47 PST] - $env Not Allowed in run.job Input Blocks

**What I was trying to do:**
Create a run.job that passes an API token from environment variables to a function input.

**What the issue was:**
I initially wrote the run.xs with `$env.SLACK_BOT_TOKEN` in the input block:
```xs
run.job "Slack Send Message" {
  main = {
    name: "send_slack_message"
    input: {
      slack_token: $env.SLACK_BOT_TOKEN  // This fails validation
    }
  }
}
```

**Why it was an issue:**
The validator returned an error: "Expecting: one of these possible Token sequences" and didn't accept `$env`. I had to re-read the quickstart docs to find the note: "Using $env in run.job input blocks" is listed as a common mistake.

**Potential solution (if known):**
The documentation could be clearer about this limitation. The run.job documentation shows examples with literal values but doesn't explicitly state that `$env` cannot be used in input blocks. Adding a note in the run.job section itself would help.

---

## [2025-02-16 12:48 PST] - Function Design Pattern for Environment Variables

**What I was trying to do:**
Figure out the correct pattern for accessing environment variables in a run job context.

**What the issue was:**
After realizing I couldn't use `$env` in the run.job input, I wasn't sure where to access environment variables. The function documentation shows `$env` usage but I wasn't sure if it would work in functions called by run jobs.

**Why it was an issue:**
There was uncertainty about whether functions have access to `$env` when called from a run job, or if only the run.job `env` array declaration was needed.

**Potential solution (if known):**
Add a complete working example in the run documentation showing:
1. The run.job with `env = ["VAR_NAME"]`
2. The function reading `$env.VAR_NAME` in its stack
3. This would clarify the relationship between the env declaration and actual access

---

## [2025-02-16 12:45 PST] - Finding the Right Documentation Topics

**What I was trying to do:**
Find syntax information for creating a run job with external API calls.

**What the issue was:**
The xanoscript_docs tool has many topics and I wasn't sure which ones to query. I ended up calling multiple topics (run, quickstart, functions, integrations) to piece together the information.

**Why it was an issue:**
It took 4 separate documentation calls to get the complete picture. Each call took 1-2 seconds, adding latency to the development process.

**Potential solution (if known):**
- A "run-job-complete" topic that combines run + functions + api.request patterns
- Or a search/keyword-based lookup instead of topic-based
- A "common patterns" topic that shows complete working examples of typical use cases

---

## [2025-02-16 12:49 PST] - Error Message Readability

**What I was trying to do:**
Understand the validation error when using `$env` incorrectly.

**What the issue was:**
The error message listed 26 possible token types but didn't clearly explain *why* `$env` wasn't allowed in that context or suggest the correct pattern.

**Why it was an issue:**
The error was technically accurate but not helpful for fixing the problem. It didn't say "$env cannot be used in run.job input blocks" or suggest moving the env access to the function.

**Potential solution (if known):**
Context-aware error messages that detect common patterns like `$env` in input blocks and provide helpful suggestions.

---

## Overall Assessment

**What worked well:**
- The validate_xanoscript tool is fast and accurate
- The documentation is comprehensive once you find the right topics
- The common mistakes section in quickstart was very helpful

**What could be improved:**
1. **Discoverability**: Better cross-linking between related topics
2. **Complete examples**: More end-to-end examples showing run.job + function + external API
3. **Error messages**: More contextual/helpful validation errors
4. **Environment variable pattern**: Clear documentation on the correct pattern for env vars in run jobs
