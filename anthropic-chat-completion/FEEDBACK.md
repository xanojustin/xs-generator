# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 14:20 PST] - Filter Expression Validation Issue

**What I was trying to do:**
Create an error message string that combines text with filtered values using the `~` concatenation operator.

**What the issue was:**
I wrote this code:
```xanoscript
error = "Anthropic API request failed with status: " ~ $api_result.response.status|to_text ~ ", Error: " ~ $api_result.response.result|json_encode
```

The MCP validator returned this error:
```
[Line 63, Column 7] An expression should be wrapped in parentheses when combining filters and tests
```

**Why it was an issue:**
The error message was not specific about WHICH expression needed parentheses. I had to guess whether it was:
1. The entire concatenation expression
2. Each individual filter expression
3. Something else

It turned out I needed to wrap each filter in parentheses:
```xenoscript
error = "Anthropic API request failed with status: " ~ ($api_result.response.status|to_text) ~ ", Error: " ~ ($api_result.response.result|json_encode)
```

**Potential solution (if known):**
The error message could be more specific, like: "When using filters with the concatenation operator (~), wrap each filtered expression in parentheses."

Or the documentation could have an example of string concatenation with filters.

---

## [2025-02-13 14:18 PST] - MCP Command Line Quoting Issues

**What I was trying to do:**
Validate XanoScript code by passing it directly to the mcporter call command.

**What the issue was:**
When trying to pass multi-line XanoScript code directly in the shell command, I got parsing errors:
```
zsh:74: parse error near `}'
```

**Why it was an issue:**
The shell couldn't handle the complex quoting with curly braces and special characters. I had to work around this by using `$(cat filename)` instead of inline code.

**Potential solution (if known):**
The MCP could support a `--file` parameter to read code from a file path, or accept base64-encoded content to avoid shell quoting issues.

Example:
```bash
mcporter call xano.validate_xanoscript --file=./mycode.xs
# or
mcporter call xano.validate_xanoscript --base64="ZW5jb2RlZCBjb250ZW50..."
```

---

## [2025-02-13 14:15 PST] - Missing api.request Documentation

**What I was trying to do:**
Find documentation on how to make external HTTP requests using `api.request`.

**What the issue was:**
I searched through multiple documentation topics (syntax, functions, integrations, apis) but couldn't find specific documentation for the `api.request` operation. I eventually had to look at existing examples in the ~/xs folder to understand the syntax.

**Why it was an issue:**
The `api.request` operation is critical for integrating with external APIs, but there's no clear documentation for:
- What parameters it accepts (url, method, headers, params, timeout)
- What the response structure looks like ($api_result.response.status, $api_result.response.result)
- How to handle different content types (JSON vs form-urlencoded)
- Error handling patterns

**Potential solution (if known):**
Add a dedicated topic for external API operations, or include `api.request` in the integrations documentation. Document the full response structure including:
- `$response.status` (HTTP status code)
- `$response.result` (parsed response body)
- `$response.headers` (if available)

---

## [2025-02-13 14:10 PST] - Finding Existing Examples Required Manual Exploration

**What I was trying to do:**
Understand the project structure and patterns by looking at existing implementations.

**What the issue was:**
The existing implementations were scattered in ~/xs/ but I had to manually explore to find them. There was no index or catalog of available examples.

**Why it was an issue:**
Without knowing what examples exist, it's hard to:
1. Avoid duplicating implementations
2. Find reference implementations for similar APIs
3. Learn best practices from existing code

**Potential solution (if known):**
Consider adding a catalog file or README in the ~/xs folder listing all available implementations with brief descriptions. Or include example patterns in the XanoScript documentation.

---

## Summary

Overall the Xano MCP worked well for validation, and the documentation provided good coverage of language features. The main gaps were:

1. **Validation error messages** could be more specific about how to fix issues
2. **Shell quoting** makes inline code validation difficult
3. **External API operations** need dedicated documentation
4. **Example discovery** could be improved

The validation tool was accurate and helpful once I worked around the shell quoting issues. The language server correctly identified the syntax error even if the error message could have been clearer.
