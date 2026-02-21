# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 14:35 PST] - Bitwise operators not documented in quick reference

**What I was trying to do:** Calculate the Hamming distance between two integers using XOR and AND bitwise operations

**What the issue was:** I initially used standard C-style bitwise operators (`^` for XOR, `&` for AND) like this:
```xs
var $xor_result {
  value = $input.x ^ $input.y
}
```

This caused a confusing parse error: `Expecting --> } <-- but found --> '$input' <--`

The error suggested a syntax issue with the closing brace, but the real problem was that `^` is not a valid operator in XanoScript.

**Why it was an issue:** 
1. The syntax error message was misleading - it pointed to the brace instead of the operator
2. The `syntax` quick reference documentation doesn't mention that bitwise operations use filters (`|bitwise_xor:`, `|bitwise_and:`) instead of operators
3. I had to discover this by looking at existing working code (`sum_of_two_integers.xs`)

**Potential solution (if known):** 
1. Add a section to the `syntax` quick reference documenting common filter-based operations including bitwise operations
2. Improve the parser error message for invalid operators to say something like "Unknown operator ^. Did you mean |bitwise_xor:?"
3. Consider adding a `operators` topic to xanoscript_docs that lists all available operators and their filter equivalents

---

## [2025-02-21 14:35 PST] - file_paths argument parsing issues

**What I was trying to do:** Validate multiple files using the `file_paths` parameter

**What the issue was:** When passing comma-separated file paths to `file_paths`, the MCP appears to split on commas in a way that breaks the path:
```
mcporter call xano.validate_xanoscript file_paths=/Users/justinalbrecht/xs/hamming-distance/run.xs,/Users/justinalbrecht/xs/hamming-distance/function/hamming_distance.xs
```

This resulted in errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

**Why it was an issue:** The comma separator appears to be parsed incorrectly, splitting on characters within the paths themselves rather than treating it as an array separator.

**Potential solution (if known):**
1. The MCP should properly handle comma-separated paths in the `file_paths` parameter
2. Alternative: Accept a JSON array format for complex parameters
3. Workaround was to use `directory` parameter instead, which worked fine

---

## [2025-02-21 14:35 PST] - No quick reference for bitwise filters

**What I was trying to do:** Find documentation on bitwise operations (XOR, AND, OR, NOT)

**What the issue was:** Neither the `syntax` nor the `cheatsheet` topics documented bitwise filters like `|bitwise_xor:`, `|bitwise_and:`, `|bitwise_or:`, `|bitwise_not:`

**Why it was an issue:** Had to find examples in existing code to discover these filters exist

**Potential solution (if known):** Add bitwise filters to the cheatsheet or create a dedicated topic for filter operations
