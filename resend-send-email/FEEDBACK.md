# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 10:18 PST] - validate_xanoscript Parameter Passing Issues

**What I was trying to do:**
Validate XanoScript files using the MCP's validate_xanoscript tool.

**What the issue was:**
The validate_xanoscript function expects a `code` parameter, but passing it via mcporter CLI was extremely difficult. Multiple approaches failed:
- Using JSON format with jq: `jq -n --arg code "$CODE" '{code: $code}' | mcporter call xano validate_xanoscript -`
- Using positional arguments: `mcporter call xano validate_xanoscript 'code content'`
- Using explicit JSON: `mcporter call xano validate_xanoscript '{"code": "..."}'`

All of these returned either:
- `Error: 'code' parameter is required`
- `Found 1 error(s): 1. [Line 1, Column 1] Expecting --> function <-- but found --> '-' <--`

**Why it was an issue:**
The parser was receiving garbled input (possibly stdin handling issues with newlines or special characters). This blocked validation and required extensive trial and error to find a working syntax.

**Potential solution (if known):**
The `code=...` syntax eventually worked: `mcporter call xano validate_xanoscript code='function "test" { ... }'`

However, this approach has limitations:
1. Multi-line code is difficult to pass correctly
2. Special characters like quotes need careful escaping
3. The CLI help doesn't clearly document this syntax

Suggested improvements:
- Accept file path as alternative to code content
- Better document the exact CLI syntax expected
- Support reading from stdin more reliably
- Provide file-based validation: `validate_xanoscript file="path/to/file.xs"`

---

## [2026-02-13 10:20 PST] - xanoscript_docs Topic Parameter Not Filtering

**What I was trying to do:**
Get specific documentation for "run" jobs and "integrations" using `xanoscript_docs({ topic: "run" })`.

**What the issue was:**
Calling `xanoscript_docs` with any topic parameter returned the same general overview documentation, not topic-specific content.

Examples that all returned identical output:
- `mcporter call xano xanoscript_docs '{"topic": "run"}'`
- `mcporter call xano xanoscript_docs '{"topic": "integrations"}'`
- `mcporter call xano xanoscript_docs '{"topic": "syntax"}'`
- `mcporter call xano xanoscript_docs '{"topic": "functions"}'`

**Why it was an issue:**
The documentation claims specific topics exist (run, functions, integrations, etc.), but the function returns the same general README content regardless of topic specified. This made it impossible to get detailed syntax information for:
- How to structure run.job blocks
- Available API integration functions
- Proper syntax for conditional blocks
- How to use api.request correctly

**Potential solution (if known):**
Either:
1. Fix the topic filtering to return specific content
2. Update the MCP documentation to indicate topics aren't implemented yet
3. Provide a single comprehensive document that includes all topics

I had to rely on existing example files in the repository to understand proper syntax instead of the documentation.

---

## [2026-02-13 10:25 PST] - Run Job vs Function Validation Construct Mismatch

**What I was trying to do:**
Validate a run.xs file containing a `run.job` construct.

**What the issue was:**
The validate_xanoscript tool appears to be optimized for `function` constructs. When validating the run.job file, there was uncertainty about whether run.job has different validation rules or if it's treated as a generic construct.

**Why it was an issue:**
The documentation (which returned general content) mentioned that run.job files go in the `run/` folder, but didn't provide specific syntax guidance for:
- Proper run.job structure
- Valid fields in the main block
- How env arrays should be formatted
- Whether input blocks within run.job follow function input syntax

**Potential solution (if known):**
Add specific documentation and validation support for all XanoScript constructs, not just functions. Include examples of run.job, task, query, and other constructs in the documentation.

---

## General Observations

### Positive Notes:
1. The validation tool works well once you figure out the syntax
2. Error messages are helpful (line/column numbers, expected vs found tokens)
3. The MCP server responds quickly

### Suggested Improvements:
1. **Better CLI documentation**: Show clear examples of how to pass multi-line code
2. **File-based validation**: Allow passing file paths instead of raw code
3. **Fix topic filtering**: Make xanoscript_docs return topic-specific content
4. **Add more examples**: Include working examples of run.job, task, query constructs
5. **Batch validation**: Support validating multiple files at once
