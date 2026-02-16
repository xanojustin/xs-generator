# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 23:45 PST] - Throw Block Syntax Confusion

**What I was trying to do:**
Create a function with error handling using the `throw` block to raise custom errors when the API request fails.

**What the issue was:**
The `throw` block syntax differs from regular object literals. I initially wrote:
```xs
throw {
  name = "GroqAPIError",
  value = "Groq API error: " ~ ($api_result.response.status|to_text)
}
```

This caused a validation error: `[Line 46, Column 32] Expecting --> } <-- but found --> ',' <--`

The correct syntax requires NO comma between properties:
```xs
throw {
  name = "GroqAPIError"
  value = "Groq API error: " ~ ($api_result.response.status|to_text)
}
```

**Why it was an issue:**
This was confusing because regular object literals in XanoScript use commas between properties (e.g., `params = { model: $input.model, temperature: 0.7 }`). The `throw` block is inconsistent with this pattern, making it hard to remember the correct syntax.

**Potential solution (if known):**
- Document the `throw` syntax more prominently in the quickstart or syntax docs
- Consider making `throw` accept commas for consistency with object literals
- Add a specific example of throw syntax in the error handling section

---

## [2026-02-15 23:40 PST] - Variable Scoping in Conditional Blocks

**What I was trying to do:**
Declare variables inside a `conditional` block and reference them in the `response` block.

**What the issue was:**
Initially I wrote:
```xs
conditional {
  if ($api_result.response.status == 200) {
    var $response_content { value = ... }
    var $usage { value = ... }
    var $model_used { value = ... }
  }
}
response = {
  model: $model_used,
  ...
}
```

This failed validation because variables declared inside `conditional` blocks are scoped to that block and not accessible outside.

**Why it was an issue:**
The documentation mentions that `group` blocks don't create a new scope, but it wasn't immediately clear that `conditional` blocks DO create a new scope. This is a subtle but important distinction.

**Potential solution (if known):**
- Add a clear note in the conditional documentation that it creates a new variable scope
- Suggest the workaround (declare variables outside with `var`, update inside with `var.update`)

---

## [2026-02-15 23:35 PST] - MCP Validation via Command Line

**What I was trying to do:**
Validate XanoScript code using the MCP `validate_xanoscript` tool via mcporter.

**What the issue was:**
Passing multi-line code via command line is tricky. The `code` parameter requires the actual code content, not a file path. When using shell commands, special characters like `$` need escaping, which is error-prone.

The best approach I found was:
```bash
CODE=$(cat file.xs | jq -Rs '.')
mcporter call xano.validate_xanoscript --args "{\"code\":$CODE}"
```

**Why it was an issue:**
It's cumbersome to validate files. Most of the time I want to validate a file, not inline code.

**Potential solution (if known):**
- Add a `file_path` parameter to `validate_xanoscript` so it can read directly from disk
- Or provide a CLI command like `xano validate <file.xs>`

---

## [2026-02-15 23:30 PST] - Null Coalescing Operator Uncertainty

**What I was trying to do:**
Use the `??` null coalescing operator to provide a fallback value for potentially missing API error messages.

**What the issue was:**
I wrote: `$api_result.response.result.error.message ?? "Unknown error"`

I wasn't sure if this syntax was correct, and the documentation shows both `??` and `|first_notnull:` as alternatives.

**Why it was an issue:**
The quickstart docs mention both options but don't clarify when to use each or if they're equivalent.

**Potential solution (if known):**
- Clarify in docs whether `??` and `|first_notnull:` are functionally equivalent
- Document any edge cases where one works but the other doesn't

---
