# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 16:35 PST] - Initial validation failed with confusing error message

**What I was trying to do:** Validate the initial XanoScript files for the arithmetic-slices exercise

**What the issue was:** The validator reported:
```
1. [Line 4, Column 1] Expecting --> function <-- but found --> '\n' <--
```

This error was confusing because line 4 was actually the start of the `function` declaration, but the parser seemed to see a newline character instead.

**Why it was an issue:** The error message didn't clearly indicate what was wrong. I had two comment lines followed by a blank line before the `function` keyword. After comparing with working examples, I realized the issue was likely related to the file structure/formatting.

**Potential solution:** The error message could be improved to suggest "Remove extra blank lines at start of file" or "File should start with code, not blank lines".

---

## [2026-03-01 16:40 PST] - Filter expression parentheses requirement

**What I was trying to do:** Write a precondition to check array length: `$input.nums|count >= 3`

**What the issue was:** The validator reported:
```
1. [Line 8, Column 40] An expression should be wrapped in parentheses when combining filters and tests
```

**Why it was an issue:** While the error message was clear about what to fix, it wasn't immediately obvious that `$input.nums|count` needed to be wrapped in parentheses. The fix was `($input.nums|count) >= 3`.

**Potential solution:** This is documented in the essentials guide, but a more specific example in the error message like:
```
Try: (\$input.nums|count) >= 3
```
would have been helpful.

---

## [2026-03-01 16:42 PST] - Array element access syntax confusion

**What I was trying to do:** Access array elements by index using `$input.nums[i]`

**What the issue was:** XanoScript doesn't support bracket notation for array access. Instead, I needed to use the `get:` filter like `$input.nums|get:$i`.

**Why it was an issue:** Coming from JavaScript/TypeScript, the natural instinct is to use bracket notation. The documentation mentions filters but doesn't prominently feature array element access patterns.

**Potential solution:** Add a "Common patterns for developers coming from JavaScript/Python" section to the essentials documentation that explicitly shows:
- Array access: `$arr|get:$index` instead of `$arr[$index]`
- Array length: `$arr|count` instead of `$arr.length`

---

## General Observations

1. **The MCP validation tool works well** - Once I understood the patterns, the validator gave clear, actionable error messages.

2. **Documentation is comprehensive** - The `xanoscript_docs` tool with different topics provides good coverage.

3. **Type naming takes getting used to** - `int` not `integer`, `text` not `string`, `bool` not `boolean` - this is well documented but easy to forget.

4. **Filter chaining is powerful** - Once understood, the pipe syntax is clean and expressive.
