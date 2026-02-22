# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 00:35 PST] - Missing ord filter for character code conversion

**What I was trying to do:** Convert characters to their ASCII/Unicode code points to check if they were digits (0-9)

**What the issue was:** The `ord` filter (common in many languages for getting character codes) doesn't exist in XanoScript. The validation error was: "Unknown filter function 'ord'"

**Why it was an issue:** I had to completely rethink my approach to digit validation. Instead of checking if a character's ASCII code was between 48-57, I had to create a lookup object mapping digit characters to their numeric values.

**Potential solution:** 
- Add an `ord` filter that returns the ASCII/Unicode code point of a character
- Or add a `is_digit` filter that checks if a string is a valid digit
- Or document the recommended pattern for character type checking

---

## [2026-02-22 00:36 PST] - Cannot use response = inside conditional blocks

**What I was trying to do:** Implement early returns for edge cases (empty string, all whitespace, etc.)

**What the issue was:** Using `response = 0` inside a `conditional { if (...) { ... } }` block caused a parse error: "Expecting --> } <-- but found --> 'response'"

**Why it was an issue:** I had to restructure the entire function to use a single `$final_result` variable that gets set throughout the logic, rather than early returns. This made the code more nested and harder to follow.

**Potential solution:**
- Document this limitation clearly
- Or support early return syntax like `return { value = ... }` (I later saw this pattern in `word_break` example but it didn't work when I tried it - needs clarification on when it's valid)

---

## [2026-02-22 00:37 PST] - Inline comments cause parsing errors

**What I was trying to do:** Add inline comments to explain constants like `var $zero_code { value = 48 }  // '0' ASCII`

**What the issue was:** The parser failed on inline comments, expecting a newline but found `/`

**Why it was an issue:** Comments are important for code readability, especially for magic numbers. I had to remove all inline comments and only use block comments on their own lines.

**Potential solution:**
- Support inline comments with `//` syntax
- Or document that comments must be on their own lines

---

## [2026-02-22 00:38 PST] - Documentation topics return same general content

**What I was trying to do:** Get specific syntax documentation for functions, run jobs, and quickstart patterns

**What the issue was:** Calling `xanoscript_docs` with different topics ("functions", "run", "quickstart", "syntax") all returned the same general documentation overview instead of topic-specific content.

**Why it was an issue:** I had to rely on reading existing example files in the `~/xs/` directory to understand the correct syntax patterns, which was time-consuming and inconsistent.

**Potential solution:**
- Ensure topic-specific content is returned for each topic parameter
- Or provide a cheatsheet with common patterns for functions, conditionals, loops, etc.

---

## [2026-02-22 00:39 PST] - Unclear variable update syntax

**What I was trying to do:** Update a variable's value inside a loop (e.g., incrementing an index)

**What the issue was:** It was unclear whether to use `var $x { value = $x + 1 }` or `var.update $x { value = $x + 1 }`

**Why it was an issue:** Both patterns appear in existing code. The `var.update` syntax seems to be for modifying existing variables while `var` creates a new variable in scope. This is confusing and can lead to subtle bugs.

**Potential solution:**
- Document the difference between `var` and `var.update`
- Provide clear examples of when to use each

---

## [2026-02-22 00:40 PST] - Loop control (break/continue) not available

**What I was trying to do:** Break out of a while loop when a condition was met

**What the issue was:** There's no `break` or `continue` statement. I had to use a workaround by setting the loop condition variable to false.

**Why it was an issue:** Made the code more verbose and harder to read. For example, instead of a simple `break`, I needed:
```xs
var $can_continue { value = false }
```

**Potential solution:**
- Add `break` and `continue` keywords for loop control
- Or document the recommended pattern for early loop exit

---

## Summary

The Xano MCP validation tool was very helpful in catching syntax errors. The main struggles were around:
1. Missing filters (`ord`)
2. Unclear scoping rules for `response` and early returns
3. Comment placement restrictions
4. Incomplete topic-specific documentation

The error messages with line/column numbers and suggestions were excellent and saved a lot of debugging time.
