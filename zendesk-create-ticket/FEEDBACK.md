# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 09:47 PST] - Validate XanoScript Parameter Format Issue

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` MCP tool.

**What the issue was:**
The tool kept returning "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even when I was passing these parameters. I tried multiple JSON formats:
- `{"file_path": "/path/to/file.xs"}`
- `'{"file_path": "/path/to/file.xs"}'`
- Various quoting combinations

None of these worked. The error message was misleading because the parameter WAS being passed, but the tool couldn't parse it correctly.

**Why it was an issue:**
This blocked validation for a significant amount of time while I tried different formats. The error message didn't indicate the actual problem - that the JSON wasn't being parsed correctly.

**Potential solution (if known):**
After checking `mcporter call --help`, I discovered the `--args` flag which properly passes JSON to the tool:
```bash
mcporter call xano validate_xanoscript --args '{"file_path": "/path/to/file.xs"}'
```

The MCP documentation or tool description should mention that `--args` is required for JSON parameters, or the tool should accept JSON directly without requiring the special flag.

---

## [2025-02-17 09:50 PST] - File Path Resolution from MCP Server

**What I was trying to do:**
Validate a file using an absolute path `/Users/justinalbrecht/xs/zendesk-create-ticket/function/zendesk_create_ticket.xs`.

**What the issue was:**
The MCP server returned "File not found" even though the file definitely exists. This suggests the MCP server might be running in a sandboxed environment or different working directory that doesn't have access to the full filesystem.

**Why it was an issue:**
I had to switch to using the `code` parameter instead of `file_path`, which requires reading the file and passing its contents. This is less efficient and more complex.

**Potential solution (if known):**
- Document which directories the MCP server has access to
- Provide a way to validate files by path relative to the workspace
- Or suggest always using the `code` parameter with file content

---

## [2025-02-17 09:52 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Write a conditional check for array count: `if ($input.tags|count > 0)`

**What the issue was:**
The validator reported: "An expression should be wrapped in parentheses when combining filters and tests"

I had to change it to: `if (($input.tags|count) > 0)`

**Why it was an issue:**
This syntax requirement wasn't clear from the documentation I read. The error message was helpful but I had to run validation to discover this rule.

**Potential solution (if known):**
Add a note in the quickstart or syntax documentation about filter expressions needing parentheses when used in conditionals. Example:
```xs
// ❌ Wrong
if ($array|count > 0)

// ✓ Correct
if (($array|count) > 0)
```

---

## [2025-02-17 09:45 PST] - base64_encode Filter Not Available

**What I was trying to do:**
Create Basic Auth for Zendesk API by base64 encoding the credentials string.

**What the issue was:**
I initially wrote: `($credentials|base64_encode)` but wasn't sure if this filter exists in XanoScript. I couldn't find a definitive list of available filters in the documentation I retrieved.

**Why it was an issue:**
I had to guess at the filter name. If it's wrong, the code will fail at runtime.

**Potential solution (if known):**
- Provide a comprehensive list of all available filters in the syntax documentation
- Or suggest an alternative approach for Basic Auth that doesn't require manual base64 encoding

---

## General Feedback

**Documentation Structure:**
The `xanoscript_docs` tool provides good overview documentation, but finding specific syntax details (like the exact format for `run.job` constructs) required looking at examples from existing implementations.

**Validation is Excellent:**
Once I figured out the `--args` flag, the validation tool provided very helpful error messages with line numbers and specific guidance. This is a great feature.

**Missing Quick Reference for Run Jobs:**
The documentation mentions `run` topic but the specific structure for `run.job` wasn't immediately clear. I had to examine existing implementations to understand:
- The `main = { name: "...", input: {...} }` syntax
- The `env = [...]` array for environment variables
- That the function name in `run.xs` must match a defined function

**Suggested Improvements:**
1. Add a `run.job` and `run.service` example to the quickstart documentation
2. Document the `--args` requirement for mcporter when passing JSON
3. Provide a filter reference list
4. Clarify which directories/files the MCP server can access
