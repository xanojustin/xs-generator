# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-15 07:20 PST - xanoscript_docs Tool Error

**What I was trying to do:**
Get XanoScript documentation for run jobs by calling the xanoscript_docs tool with the 'run' topic.

**What the issue was:**
The xanoscript_docs tool threw an error: "Error reading XanoScript documentation: p.split is not a function"

**Why it was an issue:**
This prevented me from getting specific documentation about run job structure and syntax. I had to rely on existing examples in the ~/xs folder instead of proper documentation.

**Potential solution (if known):**
There appears to be a bug in the MCP server's documentation retrieval function. The error suggests a string splitting operation is being called on something that's not a string.

---

## 2026-02-15 07:25 PST - xanoscript_docs Returns Wrong Topic

**What I was trying to do:**
Call xanoscript_docs with specific topics like 'run', 'functions', 'quickstart' to get targeted documentation.

**What the issue was:**
No matter what topic I specified (e.g., 'run', 'functions', 'quickstart'), the tool always returned the same 'syntax' documentation with the message "Matched topics: syntax".

**Why it was an issue:**
I couldn't get documentation specific to run jobs, functions, or other XanoScript constructs. The tool seemed to ignore the topic parameter entirely and always return the syntax reference.

**Potential solution (if known):**
The topic matching logic in the MCP server may not be working correctly, or the documentation files for other topics may not be properly configured.

---

## 2026-02-15 07:30 PST - validate_xanoscript JSON Parsing Issues

**What I was trying to do:**
Validate my XanoScript code using the validate_xanoscript tool. I tried multiple approaches:
1. `mcporter call xano validate_xanoscript -- "$(cat file.xs)"`
2. `cat file.xs | jq -Rs '{code: .}' | mcporter call xano validate_xanoscript`
3. Writing to a temp file and using `--input /tmp/file.json`
4. Using `@/tmp/file.json` syntax

**What the issue was:**
All approaches failed with different errors:
- "Found 1 error(s): [Line 1, Column 1] Expecting --> function <-- but found --> '-' <--" (the file clearly starts with 'function', not '-')
- "Too many positional arguments (2) supplied"
- "'code' parameter is required"
- "Error: 'code' parameter is required" (when using stdin)

The validation tool seems unable to properly receive the code content via mcporter's various input methods.

**Why it was an issue:**
I couldn't validate my XanoScript code before committing. This defeats the purpose of having a validation tool in the MCP. I had to rely on comparing my code to existing examples instead of getting proper validation feedback.

**Potential solution (if known):**
The MCP tool may need better handling of:
1. Large/multi-line string parameters
2. JSON stdin parsing
3. File-based input (@ syntax)
4. The --input flag behavior

Alternatively, the mcporter CLI wrapper may need fixes for how it passes arguments to the MCP server.

---

## 2026-02-15 07:35 PST - xanoscript_docs File Path Parameter Not Working

**What I was trying to do:**
Get context-aware documentation by using the file_path parameter: `mcporter call xano xanoscript_docs '' 'run.job' 'full'`

**What the issue was:**
The tool returned the same generic syntax documentation regardless of the file_path parameter. The "Matched topics: syntax" message indicated it didn't match the 'run.job' file pattern.

**Why it was an issue:**
The file_path parameter should provide context-aware documentation based on the file type, but it wasn't working.

**Potential solution (if known):**
The applyTo pattern matching in the MCP server may not be correctly configured for run.job files, or the file_path parameter isn't being properly parsed.

---

## Summary

The Xano MCP server has several issues that make it difficult to use for XanoScript development:

1. **Documentation retrieval is broken** - xanoscript_docs returns syntax docs regardless of requested topic
2. **Validation is broken** - validate_xanoscript cannot receive code via any input method
3. **No working file-based validation** - Can't validate files directly by path

I had to resort to:
- Reading existing examples in ~/xs/ folder to understand syntax
- Guessing the correct structure based on patterns from stripe-charge-customer and others
- Committing code without validation

These issues significantly reduce the value of the MCP server for AI-assisted XanoScript development.
