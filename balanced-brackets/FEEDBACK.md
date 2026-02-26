# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 09:02 PST] - Issue 1: Incorrect filter name `str_split`

**What I was trying to do:** Split a string into an array of characters to iterate over each bracket

**What the issue was:** Used `str_split` filter which doesn't exist. The correct filter is `split`.

**Why it was an issue:** The validation failed with "Unknown filter function 'str_split'"

**Potential solution:** 
- Add `str_split` as an alias for `split` since many developers coming from PHP or other languages expect this naming
- Or improve error message to suggest "Did you mean 'split'?"

---

## [2025-02-26 09:02 PST] - Issue 2: Complex boolean expressions with `&&` and `||`

**What I was trying to do:** Write a concise check for matching bracket pairs using a single boolean expression with `&&` and `||` operators

**What the issue was:** This expression caused a parse error:
```xs
var $is_match {
  value = ($char == ")" && $top == "(") || 
          ($char == "}" && $top == "{") || 
          ($char == "]" && $top == "[")
}
```

**Why it was an issue:** The parser couldn't handle the complex boolean expression, even with parentheses. Had to break it into multiple sequential `if/elseif` blocks which made the code more verbose.

**Potential solution:**
- Document this limitation clearly in the syntax documentation
- Or fix the parser to handle complex boolean expressions with proper operator precedence
- The workaround (using sequential conditionals) works but is less elegant

---

## [2025-02-26 09:02 PST] - Issue 3: Unclear error handling patterns

**What I was trying to do:** Return `false` when encountering unbalanced brackets during iteration

**What the issue was:** Initially tried using `precondition` to check for empty stack, but preconditions throw errors rather than allowing a graceful return value. Had to use `conditional` with `return { value = false }` instead.

**Why it was an issue:** Documentation wasn't clear on when to use `precondition` vs `conditional` with early `return`. Preconditions seem designed for input validation, not algorithmic control flow.

**Potential solution:**
- Clarify in documentation that `precondition` is for input validation and throws errors
- Document the early `return` pattern for algorithmic control flow (exiting early with a value)

---

## [2025-02-26 09:02 PST] - General Feedback: String Character Access

**What I was trying to do:** Iterate over each character in a string

**What the issue was:** Had to use `$input.brackets|split:""` to convert the string to an array first. There's no direct way to access string characters by index.

**Why it was an issue:** This creates an intermediate array which is less efficient and less intuitive than direct character access.

**Potential solution:**
- Consider adding a `chars` filter that returns an array of characters
- Or document the `split:""` pattern clearly as the recommended approach

---

## Overall Assessment

The Xano MCP validation tool was very helpful in catching syntax errors quickly. The error messages were generally clear and actionable. The main friction points were:

1. **Filter naming** - Some standard filter names from other languages don't exist
2. **Expression complexity** - Complex boolean expressions can fail silently or with unclear errors
3. **Documentation gaps** - Some patterns (like early return) require trial and error to discover

The iterative validation workflow (write → validate → fix → validate) worked well and helped me arrive at working code efficiently.
