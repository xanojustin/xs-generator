# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-13 13:48 PST - Documentation Topic Not Returning Specific Content

**What I was trying to do:**
Retrieve specific documentation topics like "integrations", "syntax", "run" to understand XanoScript syntax for API requests.

**What the issue was:**
The `xanoscript_docs` tool consistently returned the same overview documentation regardless of which topic was requested. Topics like "integrations", "syntax", "run", "functions" all returned identical high-level overview content instead of specific syntax details.

**Why it was an issue:**
I couldn't find the specific syntax for `api.request` - specifically whether to use `params` or `body` for JSON payloads. This led to validation errors when using `body` which isn't valid in XanoScript.

**Potential solution:**
- Ensure topic-specific documentation actually returns different content
- Add a quick reference section for common patterns like HTTP requests
- Include a searchable/syntax-focused output mode

---

## 2026-02-13 13:52 PST - api.request Body vs Params Confusion

**What I was trying to do:**
Make a POST request with a JSON body to the Notion API.

**What the issue was:**
I initially used `body = $page_payload` in the `api.request` block, but this caused a validation error: "The argument 'body' is not valid in this context". The correct syntax is `params = $page_payload` even for JSON POST requests.

**Why it was an issue:**
This is counterintuitive - most HTTP libraries use `body` for POST data. The naming `params` suggests query parameters, not request body. Without proper documentation, this required trial and error.

**Potential solution:**
- Add explicit documentation about `api.request` parameters
- Clarify that `params` is used for both query strings AND JSON bodies
- Consider adding `body` as an alias for `params` for clarity

---

## 2026-02-13 13:55 PST - Conditional Else-If Syntax Unclear

**What I was trying to do:**
Chain multiple validation checks with if-else-if logic.

**What the issue was:**
I tried using nested `else { if (...) }` blocks for multiple conditions, but the validator rejected this with "Expecting --> } <-- but found --> 'if'". XanoScript appears to not support else-if or nested if inside else blocks.

**Why it was an issue:**
This is a common pattern in most languages. Having to use separate `conditional { if (...) }` blocks for each check makes the code more verbose and less readable.

**Potential solution:**
- Document the proper pattern for multiple conditions clearly
- Consider supporting `elseif` or `else if` syntax
- Allow nested conditionals within else blocks

---

## 2026-02-13 13:58 PST - No File-Based Validation

**What I was trying to do:**
Validate .xs files from disk using the MCP.

**What the issue was:**
The `validate_xanoscript` tool only accepts code as a string parameter. I had to use shell command substitution (`$(cat file.xs)`) to validate files, which is error-prone and doesn't work well with complex quoting.

**Why it was an issue:**
Reading files and passing them as command-line arguments is cumbersome. The escaping can cause issues with special characters in the XanoScript code.

**Potential solution:**
- Add a `file_path` parameter to validate_xanoscript to read directly from disk
- Or add support for reading from stdin
- Add a batch validation mode for validating entire directories

---

## 2026-02-13 14:00 PST - Inconsistent Variable Declaration Pattern

**What I was trying to do:**
Understand when to use `var $name { value = ... }` vs direct assignment.

**What the issue was:**
The pattern for declaring variables is verbose and repetitive. Every variable requires:
```
var $name {
  value = ...
}
```

**Why it was an issue:**
This is more verbose than necessary. Simple variable assignments require 3 lines of code.

**Potential solution:**
- Consider supporting shorthand: `var $name = value`
- Or: `let $name = value`
- Document the rationale for the current verbose syntax

---

## 2026-02-13 14:02 PST - Error Message Lacks Context

**What I was trying to do:**
Debug the conditional syntax error.

**What the issue was:**
The error "Expecting --> } <-- but found --> 'if'" didn't explain *why* the if was unexpected or what the correct alternative would be.

**Why it was an issue:**
Error messages should ideally suggest the fix or explain the language limitation. A newcomer wouldn't know that else-if isn't supported.

**Potential solution:**
- Improve error messages with suggestions: "else-if is not supported, use separate conditional blocks instead"
- Include line numbers and column numbers consistently
- Add a "did you mean" suggestion feature

---

## Summary

The Xano MCP validation tool works well for confirming valid syntax, but the development experience could be improved with:

1. **Better documentation**: Topic-specific docs should return detailed content, not just overviews
2. **Clearer API request syntax**: The `params` vs `body` distinction needs explicit documentation
3. **More intuitive conditionals**: Support for else-if or clearer error messages about workarounds
4. **File-based validation**: Direct file path support would be more ergonomic
5. **Richer error messages**: Include suggestions and context in validation errors

Overall, the validation tool successfully caught my errors, but I had to discover the correct patterns through trial and error rather than documentation.
