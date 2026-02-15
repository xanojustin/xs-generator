# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-15 08:17 PST - JSON Escaping Challenge with validate_xanoscript

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool via mcporter CLI.

**What the issue was:**
The validate_xanoscript tool requires a `code` parameter containing the XanoScript source code. When passing multi-line XanoScript code through the command line as JSON, proper escaping was challenging.

Initial attempts failed:
- Direct string passing caused JSON parsing errors
- Using --args with manually escaped newlines didn't work
- Single-line formatting caused syntax errors: "Expected a comma, a new line or closing bracket"

**Why it was an issue:**
The XanoScript parser expects specific newline/whitespace formatting. When code is passed as a single-line JSON string, the parser fails because it relies on newlines to separate properties (not commas like JavaScript).

**Solution found:**
Using `jq -Rs .` to properly escape the file content for JSON:
```bash
CODE=$(cat file.xs | jq -Rs .) && mcporter call xano.validate_xanoscript --args "{\"code\": $CODE}"
```

**Potential solution:**
Consider adding a `file_path` parameter to validate_xanoscript (similar to xanoscript_docs) so users can validate files directly without needing to handle JSON escaping themselves.

---

## 2026-02-15 08:18 PST - Missing File-Based Validation

**What I was trying to do:**
Validate XanoScript files directly by file path.

**What the issue was:**
The validate_xanoscript tool only accepts a `code` string parameter, not a file path. This contrasts with xanoscript_docs which has a convenient `file_path` parameter.

**Why it was an issue:**
Had to read file contents, escape them for JSON, then pass to the tool. Extra steps that could be simplified.

**Potential solution:**
Add optional `file_path` parameter to validate_xanoscript:
```
function validate_xanoscript(code?: string, file_path?: string);
```
When file_path is provided, the tool reads and validates that file directly.

---

## 2026-02-15 08:19 PST - Documentation Discovery

**What I was trying to do:**
Find the correct XanoScript syntax for HTTP requests and environment variables.

**What the issue was:**
The xanoscript_docs tool has many topics and it took several calls to find the relevant information. The docs are comprehensive but spread across multiple topics (syntax, integrations, functions, run).

**Why it was an issue:**
Had to make multiple calls to get complete picture:
1. `topic:run` - for run.job structure
2. `topic:syntax` - for expressions and filters
3. `topic:integrations` - for api.request
4. `topic:functions` - for function definition

**Potential solution:**
Consider adding a `topic:quickstart-run-job` that combines all the essential patterns needed for a typical run job in one place.

---

## Summary

Overall the MCP worked well once I figured out the proper way to pass multi-line code. The documentation is thorough and helpful. Main improvement suggestions:

1. Add `file_path` parameter to validate_xanoscript
2. Consider a consolidated quickstart topic for common patterns
3. Document the jq escaping pattern for CLI users

All validations passed successfully with the proper escaping technique.
