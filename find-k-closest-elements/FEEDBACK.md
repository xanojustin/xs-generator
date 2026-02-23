# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-23 08:35 PST - validate_xanoscript parameter passing confusion

**What I was trying to do:** Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** The parameter passing syntax was unclear. Attempting to pass JSON like `'{"directory":"..."}'` resulted in error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** Spent multiple attempts trying different JSON formats. The mcporter help showed flag-style arguments work, but it wasn't immediately obvious from the error message.

**Potential solution:** 
- Document that mcporter uses `key:value` syntax, not JSON
- Or make the error message suggest the correct format: "Try using key:value syntax like 'directory:/path/to/dir'"

---

## 2026-02-23 08:37 PST - Cannot use response = inside conditional blocks

**What I was trying to do:** Implement early return pattern for edge cases (empty input, k=0, etc.)

**What the issue was:** XanoScript doesn't allow `response = []` inside a `stack` block's conditional. The validator error was: "Expecting --> } <-- but found --> 'response' <--"

**Why it was an issue:** Most programming languages allow early returns. In XanoScript, I had to restructure using a flag variable (`$is_edge_case`) and wrap the main logic in another conditional, which is less intuitive.

**Potential solution:**
- Document this limitation clearly in the functions documentation
- Consider supporting early return pattern (e.g., `return` keyword or allowing `response =` anywhere in stack)
- Better error message: "response can only be set at the function level, not inside stack blocks. Consider using a flag variable."

---

## 2026-02-23 08:38 PST - Filter expressions need parentheses with operators

**What I was trying to do:** Compare array count to zero: `$input.arr|count == 0`

**What the issue was:** The validator rejected this with: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The fix (`($input.arr|count) == 0`) is simple but the rule isn't intuitive - it's unclear why `$input.k >= ($input.arr|count)` works on one side but not `$input.arr|count == 0` on the other.

**Potential solution:**
- Document the specific parenthesization rules for filter expressions
- Consider making the parser smarter to handle these cases automatically
- Provide examples of correct vs incorrect filter usage

---
