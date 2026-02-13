# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 13:20 PST] - Nested Conditional Syntax Error

**What I was trying to do:**
Create a run job function with multiple nested conditional validations (checking if environment variables are set).

**What the issue was:**
The initial code had deeply nested conditionals like:
```xs
conditional {
  if ($token == null) {
    ...
  }
  else {
    if ($owner == null) {
      ...
    }
    else {
      if ($repo == null) {
```

This caused a syntax error: `[Line 34, Column 9] Expecting --> } <-- but found --> 'if' <--`

**Why it was an issue:**
The XanoScript parser doesn't allow `if` statements directly inside `else` blocks. This is different from many other languages where `else if` or nested `if` inside `else` is common.

**Potential solution (if known):**
The documentation could include a clear example showing that nested conditionals inside `else` blocks are not allowed, and suggest using:
1. Sequential conditional blocks with early exit pattern
2. Precondition statements for validation
3. A flatter conditional structure

---

## [2026-02-13 13:22 PST] - Missing api.request Documentation

**What I was trying to do:**
Make an HTTP POST request to the GitHub API with headers and JSON body.

**What the issue was:**
There is no specific documentation for `api.request` in the Xano MCP documentation topics. I had to infer the syntax from the Stripe example code.

**Why it was an issue:**
Without dedicated documentation, I wasn't sure about:
- The correct parameter names (url vs uri, params vs body)
- How headers should be formatted (array of strings with colon separator)
- What the response structure looks like
- Available options like timeout, async, etc.

**Potential solution (if known):**
Add an `api.request` topic to the `xanoscript_docs` tool that documents:
- All available parameters (url, method, params, headers, timeout, async)
- Request body formats for different content types
- Response object structure
- Error handling patterns

---

## [2026-02-13 13:25 PST] - No Documentation for $env Variable Access

**What I was trying to do:**
Access environment variables within the function stack.

**What the issue was:**
The documentation mentions `env = [...]` in run.job config, but doesn't clearly explain how to access these variables inside the function using `$env.variable_name`.

**Why it was an issue:**
Had to guess the syntax based on examples. Wasn't sure if:
- It should be `$env["VAR_NAME"]`
- `$env.VAR_NAME`
- `$env_var_name`
- Some other pattern

**Potential solution (if known):**
Add explicit documentation about:
- How to define env vars in run.job configuration
- How to access them in functions via `$env`
- Type handling (all env vars come in as text)
- Best practices for default values and null checking

---

## [2026-02-13 13:27 PST] - Limited Quick Reference for Common Patterns

**What I was trying to do:**
Quickly look up common patterns like string concatenation, conditional logic, and variable updates.

**What the issue was:**
The quick_reference mode is helpful but misses some commonly used patterns:
- String concatenation with `~` operator
- Variable updates with `var.update`
- The ternary operator syntax `? :`
- How to construct objects incrementally

**Why it was an issue:**
Had to read through full documentation to find these patterns, increasing development time.

**Potential solution (if known):**
Expand the quick_reference mode to include:
- Common operators (including `~` for concat)
- Variable operations (var, var.update)
- Conditional expressions (ternary)
- Object/array construction patterns

---

## [2026-02-13 13:30 PST] - String Escape Character Confusion

**What I was trying to do:**
Use the `&&` (logical AND) operator in an if condition.

**What the issue was:**
Initially wasn't sure if XanoScript uses `&&` or `and` or something else for logical AND. Had to check the syntax documentation.

**Why it was an issue:**
Different languages use different syntax (`&&` vs `and` vs `AND`). The quick reference shows operators but doesn't call out logical operators specifically.

**Potential solution (if known):**
The quick reference table could explicitly show logical operators (`&&`, `||`, `!`) in the Operators section.

---

## Overall Assessment

The Xano MCP and XanoScript documentation are good but could benefit from:
1. More examples of common patterns (API requests, validation, error handling)
2. A dedicated `api.request` documentation topic
3. Clearer documentation about `$env` access patterns
4. Troubleshooting section for common syntax errors
5. More complete quick reference covering all operators and common filters

The validation tool is very helpful and caught the nested conditional issue quickly. Having line/column numbers in errors is excellent for debugging.