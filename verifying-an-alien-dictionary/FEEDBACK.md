# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 20:35 PST] - Nested if statements not supported

**What I was trying to do:** Implement a check for whether words are sorted according to an alien dictionary order. I needed to check if order wasn't determined AND if the first word was longer than the second word.

**What the issue was:** I initially wrote nested `if` statements inside a `conditional` block:
```xs
conditional {
  if (!$order_determined) {
    if ($len1 > $len2) {
      var.update $is_sorted { value = false }
    }
  }
}
```

This caused a parse error: `Expecting --> } <-- but found --> 'if' <--`

**Why it was an issue:** The documentation mentions "Nested `if` inside `else` blocks is not supported" but I assumed nested `if` inside `if` blocks would work. It appears that nested `if` statements in general are not supported within conditional blocks.

**Potential solution:** 
1. The error message could be more descriptive - something like "Nested conditional statements are not supported. Combine conditions using && or || operators."
2. The documentation could clarify that ALL nested conditionals are disallowed, not just in `else` blocks.

---

## [2025-02-27 20:30 PST] - Documentation was helpful

**What I was trying to do:** Learn XanoScript syntax to implement the exercise.

**What went well:** The `xanoscript_docs` tool was very useful. The essentials documentation provided clear examples of common patterns and mistakes to avoid.

**Potential improvement:** 
1. Include a complete grammar reference or more formal syntax specification
2. Add more examples of complex nested logic patterns (or explicit guidance to avoid them)

---

## [2025-02-27 20:40 PST] - Validate tool worked well

**What I was trying to do:** Validate my XanoScript code.

**What went well:** The `validate_xanoscript` tool provided clear error messages with line and column numbers, making it easy to identify and fix issues.

**Potential improvement:** 
1. Would be helpful if the tool suggested fixes for common errors (like "Did you mean to use && instead of nested if?")
2. A `--fix` auto-correction option could be useful for simple syntax issues
