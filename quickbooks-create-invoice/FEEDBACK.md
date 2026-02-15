# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 16:47 PST] - Null Coalescing Operator Not Supported

**What I was trying to do:**
Create a function that sets a default value for the QuickBooks API base URL based on an environment variable. I wanted to use the `??` null coalescing operator as shown in the quickstart documentation which mentions:
```xs
var $value { value = $input.optional ?? "fallback" }
```

**What the issue was:**
When I wrote:
```xs
var $base_url {
  value = ($env.quickbooks_environment == "production") 
    ? "https://quickbooks.api.intuit.com" 
    : "https://sandbox-quickbooks.api.intuit.com"
}
```
The validator returned:
```
[Line 29, Column 9] Expecting --> } <-- but found --> '?' <---
```

I also tried using `??` directly:
```xs
var $base_url {
  value = $env.quickbooks_environment|first_notnull:"sandbox"
}
```
But this doesn't work for conditional logic based on the value.

**Why it was an issue:**
The documentation says `??` is supported in the "Common Mistakes" section:
```xs
// ✅ Correct
var $value { value = $input.optional ?? "fallback" }
```

But the validator rejects it. This is confusing because the docs show it as the correct approach.

**Potential solution (if known):**
I had to rewrite using a conditional block:
```xs
var $base_url { value = "https://sandbox-quickbooks.api.intuit.com" }
conditional {
  if ($env.quickbooks_environment == "production") {
    var.update $base_url {
      value = "https://quickbooks.api.intuit.com"
    }
  }
}
```

The documentation should either:
1. Remove the `??` example if it's not actually supported
2. Or clarify which contexts it works in
3. Or fix the validator to accept the syntax

---

## [2026-02-14 16:48 PST] - validate_xanoscript Tool Requires String Escaping

**What I was trying to do:**
Validate XanoScript code using the MCP `validate_xanoscript` tool. I wanted to pass the code content from a file.

**What the issue was:**
When calling the tool via mcporter, passing multi-line code with quotes is very fragile. The first attempt using `--args` with JSON didn't work as expected:
```bash
mcporter call xano.validate_xanoscript --args "$(cat file.xs | jq -R -s '{code: .}')"
```

**Why it was an issue:**
The tool expects a simple string `code` parameter, but shell escaping makes it difficult to pass complex multi-line XanoScript with nested quotes. I had to use a workaround:
```bash
CODE=$(cat ~/xs/.../file.xs) && mcporter call xano.validate_xanoscript code="$CODE"
```

**Potential solution (if known):**
The MCP could accept a `file_path` parameter to read directly from a file, avoiding shell escaping issues entirely. This would be much more developer-friendly:
```json
{
  "file_path": "~/xs/quickbooks-create-invoice/run.xs"
}
```

---

## [2026-02-14 16:50 PST] - Confusion About Ternary Operator vs Null Coalescing

**What I was trying to do:**
Use a ternary/conditional expression to set a variable based on a condition.

**What the issue was:**
The documentation shows `??` as working but it's not clear if a ternary operator (`? :`) is supported. I tried:
```xs
var $base_url {
  value = ($condition) ? "a" : "b"
}
```

And got the same error about `?` not being expected.

**Why it was an issue:**
It's unclear from the documentation what expression operators are actually supported. The quickstart doc mentions `??` works but doesn't clarify if it's specifically null coalescing or if ternary is also available.

**Potential solution (if known):**
Add a clear table or section in the syntax documentation listing ALL supported operators with examples:
- Arithmetic: `+`, `-`, `*`, `/`, `%`
- Comparison: `==`, `!=`, `<`, `>`, `<=`, `>=`
- Logical: `&&`, `||`, `!`
- Special: `??` (if actually supported), ternary `? :` (if supported)

---

## Summary

Overall the MCP `xanoscript_docs` tool is very helpful and returned comprehensive documentation. The main pain points were:

1. **Documentation vs Implementation Gap**: The docs show `??` as valid syntax but the validator rejects it
2. **File Validation Workflow**: Validating files requires fragile shell escaping - a `file_path` parameter would help
3. **Expression Operator Clarity**: Unclear which operators work in expression contexts vs require control flow statements

The documentation is well-structured and the examples are helpful. With these fixes, the DX would be significantly smoother.
