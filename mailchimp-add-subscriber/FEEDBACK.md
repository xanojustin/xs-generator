# FEEDBACK.md - Xano MCP/XanoScript Feedback

This document tracks issues encountered during the development of this XanoScript run job to help improve the MCP server and XanoScript tooling.

---

## [2025-02-16 23:45 PST] - MCP Tool Timeouts

**What I was trying to do:**
Call the `xanoscript_docs` MCP tool to get documentation about XanoScript syntax.

**What the issue was:**
The MCP tool calls occasionally timed out, requiring multiple retry attempts.

**Why it was an issue:**
Documentation retrieval was slow and inconsistent, making it harder to understand the correct syntax.

**Potential solution:**
Consider adding caching for documentation responses or increasing default timeout values.

---

## [2025-02-16 23:46 PST] - Unclear File Naming Convention

**What I was trying to do:**
Understand the expected file structure for run jobs.

**What the issue was:**
The task instructions mentioned creating `run.job.xs`, `test.xs`, and `types.xs`, but existing projects in the repo use different naming (`run.xs` with a separate `function/` folder).

**Why it was an issue:**
Confusion about whether to follow the task instructions or the existing repository pattern. The existing pattern (run.xs + function/*.xs) seems to be the working standard.

**Potential solution:**
Standardize documentation and examples to use consistent file naming conventions. If there's a new preferred structure, update all existing examples.

---

## [2025-02-16 23:47 PST] - Base64 Encoding in XanoScript

**What I was trying to do:**
Create HTTP Basic Auth header for Mailchimp API which requires base64 encoding of `apikey:API_KEY`.

**What the issue was:**
Unclear if `base64_encode` filter exists in XanoScript or what the correct syntax would be.

**Why it was an issue:**
Mailchimp API uses HTTP Basic Auth which requires base64 encoding. Without clear documentation on string encoding filters, had to assume the filter exists based on common patterns.

**Potential solution:**
Add documentation about available string encoding/decoding filters (base64, urlencode, etc.) to the xanoscript_docs tool.

---

## [2025-02-16 23:47 PST] - String Concatenation Syntax

**What I was trying to do:**
Build the Mailchimp API URL by concatenating the server prefix with the base URL.

**What the issue was:**
Unclear whether to use `~` (tilde) or `+` or another operator for string concatenation in XanoScript.

**Why it was an issue:**
Based on examples in the repo, the `~` operator seems to be used for concatenation, but this wasn't explicitly documented.

**Potential solution:**
Add clear documentation about string operators and concatenation syntax to the quickstart or syntax guides.

---

## [2025-02-16 23:47 PST] - Conditional Object Building

**What I was trying to do:**
Conditionally add merge_fields to the request payload only if first_name or last_name are provided.

**What the issue was:**
Unclear how to properly conditionally modify objects in XanoScript. The syntax for `conditional { if ... }` blocks and object manipulation wasn't immediately obvious.

**Why it was an issue:**
Had to look at multiple existing examples to understand the pattern of using `conditional` blocks with `var` reassignment and the `set` filter.

**Potential solution:**
Add more examples of conditional logic and dynamic object building to the documentation.

---

## [2025-02-16 23:47 PST] - No validate_xanoscript Tool Access

**What I was trying to do:**
Validate the .xs files before committing as instructed in the task.

**What the issue was:**
The sub-agent task mentioned using `validate_xanoscript` MCP tool, but this tool was not accessible or not part of the available MCP commands.

**Why it was an issue:**
Could not validate the XanoScript files before pushing, which might result in syntax errors being committed.

**Potential solution:**
Ensure the validate_xanoscript tool is properly documented and available in the MCP server. Or provide an alternative validation method (CLI command, web interface, etc.).

---

## [2025-02-16 23:47 PST] - Limited Error Handling Documentation

**What I was trying to do:**
Implement proper error handling for different HTTP response codes from the Mailchimp API.

**What the issue was:**
Documentation about `throw` blocks and error handling patterns was limited. Unclear about:
- What properties are available in `throw` blocks
- How to access thrown errors in parent contexts
- Best practices for error type naming

**Why it was an issue:**
Had to make educated guesses about error handling syntax based on similar patterns in other examples.

**Potential solution:**
Expand documentation on error handling, exception throwing, and response status code handling.

---

## Summary

The Xano MCP server provides useful documentation through `xanoscript_docs`, but there are gaps in:
1. **String operations**: Concatenation, encoding filters
2. **Conditional logic**: Object manipulation patterns
3. **Error handling**: Throw/catch patterns
4. **Validation**: No easy way to validate files before deployment
5. **Consistency**: Confusion between documented structure vs. actual repository patterns

Overall, the MCP was helpful for getting started, but more comprehensive syntax documentation and validation tools would significantly improve the development experience.
