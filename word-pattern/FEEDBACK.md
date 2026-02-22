# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 10:32 PST] - Early Return Pattern Not Supported

**What I was trying to do:** Implement an efficient word pattern matching algorithm that could exit early when a mismatch was detected (to avoid unnecessary processing).

**What the issue was:** I attempted to use `response { value = false }` followed by `return` inside a `conditional` block to implement early returns. This resulted in a parse error: "Expecting --> } <-- but found --> 'response' <--"

**Why it was an issue:** This blocked me from writing idiomatic, efficient code. In most programming languages, early returns are a standard pattern for:
1. Input validation (fail fast)
2. Algorithm optimization (stop processing when answer is known)

Instead, I had to restructure the code to:
1. Use a `$result` variable
2. Wrap subsequent logic in `if ($result == true)` conditionals
3. This makes the code harder to read and maintain

**Potential solution (if known):** 
- Document clearly that `response` is a top-level construct only
- Consider adding support for early return via `return { value = ... }` or similar
- Or provide a `break` statement for loops with a way to exit the function

---

## [2026-02-22 10:35 PST] - File Path Expansion Issue with MCP

**What I was trying to do:** Validate the XanoScript files using the MCP's `validate_xanoscript` tool.

**What the issue was:** When using `~` (tilde) for home directory in file paths, the MCP returned "File not found" errors. The paths `~/xs/word-pattern/run.xs` were not being expanded to absolute paths.

**Why it was an issue:** This required using absolute paths (`/Users/justinalbrecht/xs/word-pattern/run.xs`) instead of the more convenient `~` notation. This is a minor friction point but could confuse users.

**Potential solution (if known):**
- The MCP should expand `~` to the user's home directory before attempting to read files
- Or document that absolute paths are required

---

## [2026-02-22 10:36 PST] - Filter Parentheses Confusion

**What I was trying to do:** Use array filters like `count` and `strlen` in expressions.

**What the issue was:** Initially I wasn't sure when to wrap filters in parentheses. The documentation clarified this but it took time to find.

**Why it was an issue:** The syntax `$arr|count > 3` fails because filters bind greedily. You need `($arr|count) > 3`. This is a common source of errors for new users.

**Potential solution (if known):**
- The error messages could be more helpful when this specific pattern is detected
- Or a linter could warn about unwrapped filter expressions in comparisons

---
