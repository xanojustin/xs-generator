# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 20:18 PST] - MCP Tool Parameter Documentation

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` tool from the Xano MCP.

**What the issue was:**
Initially tried to pass a `file_path` parameter expecting the tool to read the file, but the tool requires a `code` parameter with the actual file content. The error message was helpful but the parameter requirements weren't immediately clear from the tool listing.

**Why it was an issue:**
Had to read the file content first and then pass it as the `code` parameter. This is a common pattern but wasn't documented in the initial tool response.

**Potential solution:**
Add parameter documentation to the MCP tool description showing that `code` (string, required) is the XanoScript source code to validate, and `file_path` (string, optional) is for context in error messages.

---

## [2025-02-15 20:20 PST] - Positive: XanoScript Docs are Excellent

**What I was trying to do:**
Learn XanoScript syntax for creating a run job and function.

**What the experience was:**
The `xanoscript_docs` tool with different topics (run, quickstart, functions) provided comprehensive, well-structured documentation. The examples were clear and directly applicable.

**Why this was helpful:**
The documentation included:
- Complete syntax reference for run.job and run.service
- Common patterns with correct vs incorrect examples
- File structure conventions (snake_case naming)
- Input/output patterns and error handling

**Potential improvement:**
Consider adding a topic for "common_api_patterns" that shows Auth header construction, pagination handling, and rate limit patterns for external API integrations.

---

## [2025-02-15 20:22 PST] - String Concatenation Syntax Clarity

**What I was trying to do:**
Build a URL by concatenating a base URL with a user-provided ID.

**What could have been clearer:**
The `~` operator for string concatenation is documented, but it wasn't immediately obvious that it's the primary/only way to concatenate strings in XanoScript.

**Why it was slightly confusing:**
Most languages use `+` for string concatenation. The `~` operator is unique to XanoScript and easy to miss in the docs.

**Potential solution:**
Add a "String Operations" quick reference section that highlights:
- Concatenation with `~`
- Common filters like `to_text`, `json_encode`
- The need for parentheses when using filters in concatenation

---

## [2025-02-15 20:24 PST] - Environment Variable Access Pattern

**What I was trying to do:**
Access environment variables in the function stack.

**What was clear:**
The documentation clearly shows `$env.VARIABLE_NAME` syntax and warns against using `$env` in input blocks.

**Why this was good:**
The quickstart guide has a specific "Common Mistakes" section that calls out the `$env` in input blocks issue, which prevented me from making that error.

---

## [2025-02-15 20:25 PST] - No Issues with Validation

**What I was trying to do:**
Validate .xs files with complex syntax including:
- precondition blocks
- api.request with headers array
- String concatenation in variable declarations
- Object construction in response

**What the experience was:**
Both files passed validation on first attempt. The validator correctly parsed:
- Multi-line headers array
- Filter usage with `to_text`
- Nested object access like `$api_result.response.result.subscriber`

**No issues to report** - validation worked perfectly.

---

## Summary

Overall, the Xano MCP worked well for this task:

✅ **Strengths:**
- Comprehensive documentation via `xanoscript_docs`
- Fast validation with clear error messages
- Good examples in documentation

⚠️ **Minor friction:**
- Tool parameter documentation could be more explicit
- String concatenation operator could be more prominent in docs

📝 **Suggestions:**
1. Add inline parameter docs to MCP tool descriptions
2. Create a "Common API Integration Patterns" topic
3. Add a "String Operations" quick reference
