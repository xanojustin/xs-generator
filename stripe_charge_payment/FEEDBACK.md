# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 02:30 PST] - MCP Tool Parameter Requirements

**What I was trying to do:**
Validate XanoScript files using the validate_xanoscript tool

**What the issue was:**
The MCP tool requires a `code` parameter with the actual code content as a string, not a file path. The error message was: `Error: 'code' parameter is required`

**Why it was an issue:**
Had to figure out how to pass the file content as a JSON-escaped string. The intuitive approach of passing a file path didn't work.

**Potential solution:**
Allow passing either a `file_path` or `code` parameter, or provide a CLI example in the tool description showing how to pipe file content.

---

## [2026-02-16 02:35 PST] - XanoScript Object Literal Syntax Confusion

**What I was trying to do:**
Create an object literal for the Stripe API payload

**What the issue was:**
Used `=` inside object literals like `{ customer = $input.customer_id }` but XanoScript expects `:` for object literal key-value pairs.

**Why it was an issue:**
The validator gave cryptic error: `Expecting --> : <-- but found --> '=' <--`. It wasn't immediately clear that object literals use different syntax than variable assignments.

**Potential solution:**
Documentation could emphasize this distinction more prominently in the quickstart guide. Variable assignments use `=` but object literals use `:`.

---

## [2026-02-16 02:40 PST] - Run Job vs Function Syntax Confusion

**What I was trying to do:**
Create a run job file using the simplified run syntax

**What the issue was:**
The validator only accepts standard XanoScript constructs (like `function`), not the simplified run job syntax (`job:` or direct statements). Got error: `Expecting --> function <-- but found --> 'job' <--`

**Why it was an issue:**
The CLI docs show a simplified run job format (`job: name ---`), but this doesn't validate with the MCP validator. Had to wrap the run job in a function to validate the syntax, then save it separately.

**Potential solution:**
Either update the validator to accept run job syntax, or clearly document that run jobs need separate validation (e.g., via `xano run:info` CLI command).

---

## [2026-02-16 02:42 PST] - Logging Function Name Unknown

**What I was trying to do:**
Add logging to the run job

**What the issue was:**
Tried to use `util.log` based on general Xano documentation, but the validator rejected it with a list of valid functions. Had to use `debug.log` instead.

**Why it was an issue:**
The syntax docs mention `debug.log` but it's not prominently featured. `util.log` seemed more intuitive for general logging.

**Potential solution:**
Include a "Common Functions" section in the quickstart docs with logging, email, and other utility functions.

---

## [2026-02-16 02:45 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Use string length filter in a comparison: `$input.customer_id|strlen > 0`

**What the issue was:**
The validator requires parentheses around expressions that combine filters and comparisons: `($input.customer_id|strlen) > 0`

**Why it was an issue:**
The error message was helpful (`An expression should be wrapped in parentheses when combining filters and tests`), but this requirement isn't obvious from reading the docs.

**Potential solution:**
Add this to the "Common Mistakes" section in the quickstart documentation.

---

## [2026-02-16 02:48 PST] - Comments at Beginning of Files

**What I was trying to do:**
Add `//` comments at the beginning of .xs files

**What the issue was:**
The validator doesn't accept comments before the main construct. Error: `Expecting --> function <-- but found --> '\n' <--`

**Why it was an issue:**
Comments work fine inside the construct, just not at the very beginning of the file before the construct declaration.

**Potential solution:**
Document this limitation, or allow comments at the beginning of files (which is standard in most programming languages).

---

## [2026-02-16 02:50 PST] - Documentation Topic Retrieval

**What I was trying to do:**
Get specific topic documentation (run, quickstart, functions)

**What the issue was:**
Calling `xanoscript_docs({ topic: "run" })` returned the same general documentation instead of run-specific docs.

**Why it was an issue:**
Had to infer the correct syntax from general examples rather than getting specific guidance on run jobs.

**Potential solution:**
Ensure topic-specific documentation is properly segmented and returned when requested.

---

## Summary

Overall, the MCP server works well for validating XanoScript syntax, but there are several friction points around:
1. **Syntax consistency** - Object literals vs variable assignments
2. **Validation coverage** - Run jobs use different syntax than standard constructs
3. **Error messages** - Could be more specific about the actual problem
4. **Documentation organization** - Some topics return generic content instead of specific guidance

The validation tool is very helpful once you understand these quirks, but the learning curve is steeper than necessary due to these inconsistencies.
