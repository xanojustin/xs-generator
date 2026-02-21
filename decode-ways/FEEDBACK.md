# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 11:32 PST] - Inline comment syntax restriction

**What I was trying to do:** Add inline comments to explain variable purposes in the code

**What the issue was:** XanoScript parser doesn't allow inline comments after code on the same line. For example, this fails:
```xs
var $prev2 { value = 1 }  // dp[i-2]
```

Error message:
```
[Line 33, Column 31] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

**Why it was an issue:** This is a common pattern in many programming languages (C, Java, JavaScript, etc.) and it's natural to want to document a variable right where it's declared. The error message is also cryptic - it doesn't clearly indicate that inline comments aren't supported.

**Potential solution (if known):** 
1. Either support inline comments (preferable)
2. Or provide a clearer error message like: "Inline comments are not supported. Place comments on their own line."

---

## [2026-02-21 11:33 PST] - validate_xanoscript file_paths parameter parsing issue

**What I was trying to do:** Validate multiple files using the file_paths parameter with comma-separated paths

**What the issue was:** The MCP tool parsed the comma-separated string character by character instead of as an array of file paths. When I called:
```
file_paths=~/xs/decode-ways/run.xs,~/xs/decode-ways/function/decode_ways.xs
```

It treated each character as a separate file:
```
File not found: ~
File not found: /
File not found: x
File not found: s
...
```

**Why it was an issue:** The documented API suggests file_paths accepts an array of strings, but the mcporter CLI doesn't properly handle this. I had to use the `directory` parameter instead as a workaround.

**Potential solution (if known):**
1. Fix the CLI parsing for array parameters
2. Or document that file_paths should be passed via --args JSON format for CLI usage

---

## [2026-02-21 11:34 PST] - Substr filter with variable offset

**What I was trying to do:** Extract a substring using a variable offset: `$input.s|substr:($i - 1):1`

**What the issue was:** Initially I wasn't sure if the substr filter could accept expressions like `($i - 1)` as parameters. I had to test to confirm it works.

**Why it was an issue:** The documentation shows `substr:0:5` with literal values, but doesn't clearly indicate if expressions are allowed. I had to guess and test.

**Potential solution (if known):** Document that filter parameters can be expressions wrapped in parentheses, with examples like `substr:($index - 1):2`.

---

## [2026-02-21 11:35 PST] - String comparison with "0"

**What I was trying to do:** Compare a single character extracted via substr with "0"

**What the issue was:** The substr filter returns a string, and I needed to verify that the comparison `"0"` works correctly. Initially I worried about type coercion issues.

**Why it was an issue:** The type system isn't always clear about what operations work between different types (text vs int comparisons).

**Potential solution (if known):** Document common string operations and comparisons more clearly, especially around single-character extraction and comparison.

---

## General Positive Feedback

1. The validation tool is very helpful and gives precise line/column error locations
2. The documentation in `xanoscript_docs` is comprehensive
3. The error messages include helpful suggestions (like "Use 'text' instead of 'string'")
4. Once I understood the comment syntax, everything worked well
