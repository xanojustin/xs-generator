# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 10:05 PST] - Bitwise Shift Operators Not Supported

**What I was trying to do:** Implement a bit manipulation algorithm (Total Hamming Distance) that requires checking individual bits of integers.

**What the issue was:** I initially wrote the code using standard C-style bitwise operators:
```xs
if (($num >> $bit) & 1 == 1) {
```

This resulted in a parser error:
```
[Line 19, Column 26] Expecting: one of these possible Token sequences:
but found: '>'
```

XanoScript does not support the `>>` (right shift) or `&` (bitwise AND) operators directly in expressions.

**Why it was an issue:** This blocked compilation of the code. I had to discover that XanoScript uses filters for bitwise operations instead:
- `bitwise_and` filter instead of `&` operator
- `bitwise_or` filter instead of `|` operator  
- `bitwise_xor` filter instead of `^` operator
- `bitwise_not` filter instead of `~` operator

But there's no `bitwise_shift_right` or `bitwise_shift_left` filter. I had to work around this by using `pow` to create bit masks:
```xs
var $bit_mask { value = 2|pow:$bit }
if (($num|bitwise_and:$bit_mask) > 0) {
```

**Potential solution (if known):** 
1. Add `bitwise_shift_right` and `bitwise_shift_left` filters to XanoScript
2. Document the workaround (using `pow` to create masks) in the bitwise operations documentation
3. Consider adding support for `\>\>` and `\<\<` operators in expressions for users coming from other languages

---

## [2025-02-27 10:03 PST] - Path Expansion Issue with validate_xanoscript

**What I was trying to do:** Validate XanoScript files using the MCP tool with `directory=~/xs/total-hamming-distance`.

**What the issue was:** The tool reported "No .xs files found in directory" when using the `~` shorthand for home directory.

**Why it was an issue:** I had to use the absolute path `/Users/justinalbrecht/xs/total-hamming-distance` instead of `~/xs/total-hamming-distance`. This is a minor inconvenience but could confuse users who expect shell-style path expansion.

**Potential solution (if known):** 
1. Add shell-style tilde expansion (`~` → `$HOME`) to the `directory` parameter in `validate_xanoscript`
2. Or document that absolute paths are required

---

## [2025-02-27 10:02 PST] - Documentation Discovery for Bitwise Operations

**What I was trying to do:** Find documentation on bitwise operations in XanoScript.

**What the issue was:** The `syntax/functions` documentation mentions "bitwise operations" in the section title but finding the actual filter names (`bitwise_and`, `bitwise_or`, etc.) required scrolling through the full documentation. The quick reference section at the top only lists basic math filters.

**Why it was an issue:** It took extra time to find the correct syntax. The quick reference table should include bitwise filters since they're commonly used in algorithmic problems.

**Potential solution (if known):** 
1. Add `bitwise_and`, `bitwise_or`, `bitwise_xor`, `bitwise_not` to the Quick Reference table in `syntax/functions`
2. Add a dedicated "Bitwise Operations" section that documents all bitwise-related functionality including workarounds for missing shift operations

---

## [2025-02-27 10:00 PST] - MCP Tool Output Format

**What I was trying to do:** Parse the output of `xanoscript_docs` programmatically using `jq`.

**What the issue was:** When using `--output json`, the MCP returns a non-standard JSON format with `content: [` (using unquoted keys) instead of standard JSON `"content": [`.

Example of what was returned:
```javascript
{
  content: [
    {
      type: 'text',
      text: '# essentials\n...'
    }
  ]
}
```

This is JavaScript object literal syntax, not valid JSON.

**Why it was an issue:** Standard JSON parsers (like `jq`) fail to parse this output. I had to drop the `--output json` flag and parse text output instead.

**Potential solution (if known):** 
1. Fix the MCP server to return properly quoted JSON when `--output json` is specified
2. Or remove the `--output json` option if it's not intended to produce valid JSON

---
