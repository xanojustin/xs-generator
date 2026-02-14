# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-13 17:20 PST - MCP Tool Parameter Documentation Gap

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` MCP tool.

**What the issue was:**
The `validate_xanoscript` tool expects a `code` parameter containing the actual script content, but the documentation only showed `file_path` examples. When I tried using `file_path`, the tool returned: `"Error: 'code' parameter is required"`.

**Why it was an issue:**
Had to guess the correct parameter name and format. The documentation showed file-based validation examples but the actual tool requires passing the code content directly.

**Potential solution (if known):**
Update the MCP tool schema or documentation to clarify that `code` (string) is required and `file_path` is not accepted. Alternatively, support both parameters so users can pass either the raw code or a file path.

---

## 2026-02-13 17:22 PST - Error Type Validation Was Unclear

**What I was trying to do:**
Create meaningful error types for different failure scenarios (configuration errors vs external API errors).

**What the issue was:**
Used `error_type = "configuration"` and `error_type = "external_api"` which are semantically meaningful, but the validator rejected them with: `Expected value of error_type to be one of standard, notfound, accessdenied, toomanyrequests, unauthorized, badrequest, inputerror`.

**Why it was an issue:**
The documentation mentions `error_type` but doesn't list the allowed values. Had to discover them through trial-and-error validation failures. Lost semantic meaning by being forced to use generic `"standard"` for configuration and external API errors.

**Potential solution (if known):**
1. Add allowed error_type values to the quickstart/syntax documentation
2. Consider adding more semantic error types like `configuration`, `external_api`, `timeout`, `network_error` that developers commonly need

---

## 2026-02-13 17:18 PST - JSON Escaping Challenges with MCP

**What I was trying to do:**
Pass multi-line XanoScript code to the validate_xanoscript tool through mcporter.

**What the issue was:**
Shell escaping of JSON with newlines and special characters was extremely difficult. Multiple attempts failed:
- Direct string passing caused "command line too long" errors
- Using `jq -Rs` for raw string encoding worked but required careful variable handling
- The `--args-file` flag appeared to pass the temp file path instead of content

**Why it was an issue:**
Wasted significant time debugging command line escaping. The `--args-file` behavior was unexpected - it seemed to pass the filename as the value rather than reading the file content.

**Potential solution (if known):**
1. Support a `file_path` parameter as an alternative to `code` in validate_xanoscript
2. Document a recommended pattern for passing multi-line code via mcporter
3. Fix `--args-file` if it's not working as expected, or document its actual behavior

---

## General Observations

**What's Working Well:**
- The `xanoscript_docs` tool is excellent - comprehensive documentation with clear examples
- Once syntax is correct, validation is fast and helpful
- The run.job/run.service constructs are intuitive

**What's Challenging:**
- Gap between documentation examples and actual MCP tool parameters
- Limited error_type granularity forces generic error handling
- No way to validate files by path, only by passing code content
- The relationship between `xanoscript_docs` topics isn't always clear (had to call multiple times to find relevant info)

**Suggestions:**
1. Add a `validate_file` command to the Xano MCP that accepts a file path
2. Include a "Common Validation Errors" section in quickstart documentation
3. Provide a complete list of all valid error_type values in the syntax docs
4. Consider a CLI tool for local validation that doesn't require MCP round-trips
