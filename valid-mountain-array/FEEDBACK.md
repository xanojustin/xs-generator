# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 08:35 PST] - File Path Format for Batch Validation

**What I was trying to do:** Validate multiple .xs files using the `file_paths` parameter with comma-separated paths

**What the issue was:** The MCP tool interpreted the comma-separated string as individual characters, resulting in errors like "File not found: U", "File not found: s", "File not found: e", etc. (each character of the path was treated as a separate file path)

**Why it was an issue:** Could not batch validate files using the documented comma-separated format

**Workaround used:** Used the `directory` parameter instead, which worked perfectly for validating all .xs files in the folder

**Potential solution:** The MCP should properly parse comma-separated file paths, or the documentation should clarify the expected format (perhaps it expects a JSON array rather than a comma-separated string)

---

## [2025-02-24 08:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Use array count filter in a comparison expression: `$input.arr|count < 3`

**What the issue was:** Got validation error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** Unclear from documentation that filters in expressions require parentheses around the entire filter expression

**Solution:** Changed to `($input.arr|count) < 3` which passed validation

**Potential solution:** The error message was helpful, but the quickstart/cheatsheet documentation could include a note about this requirement with an example

---
