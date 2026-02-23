# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 05:05 PST] - Filter 'required' not supported on text type

**What I was trying to do:** Add input validation to ensure the binary_string parameter is provided

**What the issue was:** Used `filters=required` on a text input field, which caused validation error: `Filter 'required' cannot be applied to input of type 'text'`

**Why it was an issue:** I expected common validation filters like `required` to work on all input types, similar to other validation libraries

**Potential solution (if known):** 
- Document which filters work with which types
- Consider supporting `required` on text inputs (common use case)
- Or provide an alternative like `text binary_string { required = true }` syntax

---

## [2026-02-23 05:05 PST] - Unknown filter function 'to_integer'

**What I was trying to do:** Convert a single character string ("0" or "1") to an integer (0 or 1)

**What the issue was:** Assumed there would be a `to_integer` filter similar to the `to_text` filter I saw in other examples. Got error: `Unknown filter function 'to_integer'`

**Why it was an issue:** I needed to convert string to integer for arithmetic operations. The `to_text` filter exists for int→text, so I expected the inverse.

**Potential solution (if known):**
- Add a `to_int` or `to_integer` filter for string→int conversion
- Document available filters more prominently
- The workaround was using a conditional to check if string equals "1" or "0", which works but is verbose

---

## [2026-02-23 05:05 PST] - mcporter parameter passing issues

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter CLI

**What the issue was:** The mcporter CLI had trouble passing the `directory` parameter correctly. Various attempts failed:
- `mcporter call xano.validate_xanoscript directory:="/path"` - parameter not received
- Using JSON format didn't work either

**Why it was an issue:** Couldn't validate files through mcporter directly

**Solution found:** Used direct npx invocation instead:
```bash
echo '{"jsonrpc": "2.0", "id": 1, "method": "tools/call", "params": {"name": "validate_xanoscript", "arguments": {"directory": "/path"}}}' | npx -y @xano/developer-mcp
```

**Potential solution (if known):**
- Fix mcporter's parameter serialization for complex types like arrays and objects
- Or document the working npx approach as the recommended method

---

## General Notes

The validation error messages were very helpful! They included:
- Line and column numbers
- Clear description of the problem
- Suggestions for fixes (like using "int" instead of "integer")

This made debugging much faster than it would have been otherwise.
