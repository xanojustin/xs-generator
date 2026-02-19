# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 10:35 PST] - File path parsing issue with comma-separated paths

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated values

**What the issue was:** When passing `file_paths=/Users/justinalbrecht/xs/palindrome-check/run.xs,/Users/justinalbrecht/xs/palindrome-check/function/palindrome_check.xs`, the MCP parsed each character as a separate file path, resulting in 119 "files" being validated (each character became a file), all invalid.

**Why it was an issue:** This made batch validation unusable. Had to fall back to validating files one at a time with `file_path` parameter.

**Potential solution:** The MCP should properly parse comma-separated file paths, or the documentation should clarify the expected format (maybe JSON array instead of comma-separated string?).

---

## [2025-02-19 10:37 PST] - Filter expressions need parentheses when combined with operators

**What I was trying to do:** Check if a string is null or empty: `$input.str == null || $input.str|strlen == 0`

**What the issue was:** Got error: `An expression should be wrapped in parentheses when combining filters and tests`

**Why it was an issue:** This syntax restriction wasn't immediately obvious from the documentation. The filter `|strlen` needed to be wrapped in parentheses when combined with the `==` operator in a boolean expression.

**What worked:** `($input.str|strlen) == 0`

**Potential solution:** The cheatsheet or syntax docs could include an example of this pattern since checking for empty/null strings is very common.

---

## [2025-02-19 10:37 PST] - Cannot use `response` inside conditional blocks

**What I was trying to do:** Return early from a function when handling edge cases:
```xs
conditional {
  if ($input.str == null || ($input.str|strlen) == 0) {
    response = true
    return
  }
}
```

**What the issue was:** Got error: `Expecting --> } <-- but found --> 'response'` — the parser doesn't allow `response` inside conditional blocks.

**Why it was an issue:** This is different from many other languages where early return is a common pattern. I had to restructure to declare a variable inside the conditional and then use `response` at the end of the stack.

**What worked:** Declaring `$is_palindrome` variable inside both if/else branches, then using `response = $is_palindrome` after the conditional.

**Potential solution:** 
1. Document this constraint clearly in the functions documentation
2. Consider adding an `early return` or `exit` mechanism for guard clauses, as this is a very common pattern

---

## [2025-02-19 10:30 PST] - No syntax reference for early return pattern

**What I was trying to do:** Find the proper syntax for early return/guard clauses in functions

**What the issue was:** Neither the functions docs nor the syntax docs showed how to do an early return from a function. I assumed `return` would work based on other languages, but it seems XanoScript doesn't support this pattern.

**Why it was an issue:** Had to restructure my code from a guard clause pattern to a variable assignment pattern, which is slightly less readable.

**Potential solution:** Add a section to the functions documentation about "Early returns and guard clauses" explaining the recommended pattern (using conditionals to set variables, then responding at the end).

---
