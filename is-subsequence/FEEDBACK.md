# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 09:35 PST] - Early Return Syntax Confusion

**What I was trying to do:** Implement early return from a function when a base case is met (checking if an empty string is a subsequence)

**What the issue was:** I initially wrote `response = true` followed by `return` inside the stack block, which caused a syntax error: "Expecting --> } <-- but found --> 'response'"

**Why it was an issue:** The error message was confusing because it suggested using "text" instead of "string", which was unrelated to the actual problem. The real issue is that `response = value` is only valid at the top level of the function (in the response block), not inside the stack block for early returns.

**Potential solution (if known):** The correct syntax for early return is `return { value = true }`. It would be helpful if:
1. The error message explicitly mentioned that `response` can't be used inside stack blocks
2. The documentation for functions had a clear example of early return syntax in the "Quick Reference" section
3. The error message suggested using `return { value = ... }` instead

---

## [2025-02-24 09:36 PST] - String Filter vs Array Filter Confusion

**What I was trying to do:** Get the length of input strings to iterate through them

**What the issue was:** I initially used `$input.s|count` thinking it would give me the string length, but `count` is an array filter, not a string filter.

**Why it was an issue:** The validation didn't fail on this directly, but it would have caused runtime issues. The correct filter for string length is `strlen`.

**Potential solution (if known):** The documentation does have a "CRITICAL: Filters Are Type-Specific" section that explains this, but it's easy to miss. The validation could potentially catch type mismatches like using array filters on strings.

---

## [2025-02-24 09:37 PST] - Substring Filter Name

**What I was trying to do:** Extract a single character from a string using substring

**What the issue was:** I used `substring` but the correct filter name is `substr`

**Why it was an issue:** This is just a naming convention difference - many languages use `substring` but XanoScript uses `substr`. The validation caught this as part of the overall syntax error.

**Potential solution (if known):** An autocomplete or linter in the MCP that suggests available filters as you type would help catch these naming issues early.

---
