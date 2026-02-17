# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 03:17 PST] - Run Job Input Syntax Confusion

**What I was trying to do:**
Create a run.job with optional input parameters that have default values.

**What the issue was:**
I initially wrote the run.job input using optional syntax from function definitions:
```xs
run.job "Jira Create Issue" {
  main = {
    name: "create_jira_issue"
    input: {
      project_key: "PROJ"
      description?: ""  // ERROR: ? not allowed here
    }
  }
}
```

The validation error was: `Expecting --> : <-- but found --> '?'`

**Why it was an issue:**
The documentation clearly states that run.job input values must be constants, but the distinction between:
1. Function `input { text description?="" }` (type definition with optional marker)
2. Run job `input: { description: "" }` (value assignment, no types allowed)

...was not immediately obvious from the examples. The run.job input is about passing values to the function, not defining the schema.

**Potential solution:**
Add a more explicit note in the `run` topic documentation that run.job `input:` values are plain key-value pairs (JSON-like), NOT type definitions. The `?` optional marker and type keywords (`text`, `int`, etc.) are NOT valid in run.job input blocks.

---

## [2026-02-17 03:15 PST] - MCP Tool Parameter Format Unclear

**What I was trying to do:**
Call the xanoscript_docs tool with parameters to get specific documentation topics.

**What the issue was:**
The documentation shows function call syntax like `xanoscript_docs({ topic: "quickstart" })` but mcporter expects `topic=quickstart` or `--args` JSON format. I had to experiment to find the correct format.

**Why it was an issue:**
The disconnect between the JavaScript-style function syntax in docs and the CLI key=value format wasn't immediately clear. The mcporter help could show an example of passing object parameters.

**Potential solution:**
Include a note in the xanoscript_docs documentation showing both:
- Docs syntax: `xanoscript_docs({ topic: "quickstart" })`
- CLI syntax: `mcporter call xano.xanoscript_docs topic=quickstart`

---

## [2026-02-17 03:16 PST] - Missing AWS Signature Utility

**What I was trying to do:**
Initially planned to create an AWS SES integration for sending emails.

**What the issue was:**
AWS services require AWS Signature Version 4 for authentication, which is complex to implement manually in XanoScript. There's no built-in utility like `util.aws_sign_v4` or similar.

**Why it was an issue:**
Had to abandon AWS SES and choose a different API (Jira) that uses simpler authentication (Basic auth with base64 encoding, which is available via the `base64_encode` filter).

**Potential solution:**
Consider adding AWS signing utilities to enable integrations with:
- AWS SES (email)
- AWS SNS (notifications)
- AWS SQS (queues)
- AWS EventBridge (events)
- Any AWS service requiring SigV4

This would open up many popular AWS integrations.

---

## General Feedback

**What worked well:**
1. The validation tool is very helpful with clear error messages showing line/column
2. Documentation is comprehensive once you find the right topic
3. The distinction between different constructs (task, function, run.job) is well documented

**What could be improved:**
1. A single "cheatsheet" page showing side-by-side comparisons of similar constructs would help prevent syntax confusion
2. More examples of complete, working run.job implementations with functions
3. Clarification on where `$env` variables can be used (not in input blocks, only in stack)
