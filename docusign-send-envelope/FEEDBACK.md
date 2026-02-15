# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 07:50 PST] - MCP validate_xanoscript Tool Parameter Confusion

**What I was trying to do:**
Validate XanoScript files using the MCP server's validate_xanoscript tool after creating run.job and function files for DocuSign integration.

**What the issue was:**
The `mcporter call xano validate_xanoscript` command kept returning "Error: 'code' parameter is required" despite passing the file_path parameter. The tool expects a `code` parameter containing the actual XanoScript code as a string, but this wasn't clear from the initial error message.

**Why it was an issue:**
The error message suggests a missing parameter but doesn't clarify that `code` (the actual script content) is required rather than `file_path`. This led to confusion about how to properly invoke the validation tool.

**Potential solution:**
- Improve the error message to suggest using `code` parameter with the actual script content
- Consider adding a `file_path` parameter option that reads and validates files directly
- Update documentation to show examples of both inline code validation and file validation

---

## [2025-02-15 07:52 PST] - Documentation Topics Return Generic Content

**What I was trying to do:**
Get specific documentation about run jobs by calling `xanoscript_docs({ topic: "run" })`.

**What the issue was:**
Both calls to `xanoscript_docs` with topics "run" and "quickstart" returned the same generic README-style documentation instead of topic-specific content about run jobs.

**Why it was an issue:**
Without specific run job documentation, I had to examine existing implementations (like stripe-charge-customer) to understand the proper structure for run.xs files. This makes it harder for developers to learn the correct syntax without reverse-engineering existing code.

**Potential solution:**
- Ensure topic-specific queries return relevant, filtered content rather than the full README
- Add more comprehensive examples for each construct type (run.job, function, query, etc.)
- Consider adding a "examples" mode that returns focused code examples for each topic

---

## [2025-02-15 07:55 PST] - No Direct File Validation Option

**What I was trying to do:**
Validate .xs files directly by file path without having to read and pass the content manually.

**What the issue was:**
The validate_xanoscript tool only accepts a `code` string parameter. There's no built-in file reading capability, requiring developers to write custom scripts to read files and pass them to the validator.

**Why it was an issue:**
For a workflow that involves validating multiple files, this adds friction. Every validation requires:
1. Reading the file content
2. Escaping special characters properly
3. Constructing a JSON payload
4. Sending it to the MCP

**Potential solution:**
- Add a `file_path` parameter to validate_xanoscript that reads and validates files directly
- Or add a separate `validate_xanoscript_file` tool specifically for file-based validation
- This would streamline CI/CD integrations and local development workflows

---

## [2025-02-15 07:58 PST] - mcporter CLI Validation Challenges

**What I was trying to do:**
Use the mcporter CLI to validate XanoScript files.

**What the issue was:**
The mcporter call syntax for passing multi-line code strings is problematic due to shell escaping requirements. JSON strings with newlines, quotes, and special characters require complex escaping that varies by shell.

**Why it was an issue:**
Attempted several approaches:
- Direct parameter passing failed due to escaping
- JSON file input with mcporter didn't work as expected
- Had to resort to writing a Node.js script to properly communicate with the MCP server via stdio

**Potential solution:**
- Add a `mcporter validate` subcommand specifically for XanoScript validation
- Support reading from stdin: `cat file.xs | mcporter validate -`
- Support file paths directly: `mcporter validate file.xs`
- This would abstract away the JSON-RPC complexity from end users

---

## Summary

Overall, the Xano MCP server provides useful validation capabilities, but the developer experience could be significantly improved by:

1. **Better documentation discovery** - Topic-specific queries should return focused content
2. **Simplified validation workflow** - Direct file validation without manual code passing
3. **Improved CLI tooling** - Native commands for common operations like validation
4. **Clearer error messages** - More helpful guidance when parameters are missing

The XanoScript language itself was intuitive once I reviewed existing examples, and the validation tool correctly identified valid syntax. The main friction points are in the tooling and documentation access layers rather than the language design.
