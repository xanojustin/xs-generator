# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 10:03 PST] - Blank line before function declaration causes parse error

**What I was trying to do:** Create a function with a comment block before the function declaration

**What the issue was:** The validator reported: `[Line 11, Column 1] Expecting --> function <-- but found --> '\n' <--`. There was a blank line between the comment block and the `function` keyword.

**Why it was an issue:** I naturally put a blank line between the comment header and the function definition for readability, but this caused a parse error. The parser expected the `function` keyword immediately after the comment.

**Potential solution (if known):** Either the parser should tolerate blank lines between comments and declarations, or the documentation should clearly state that no blank lines are allowed between comments and the code they precede.

---

## [2025-02-25 10:03 PST] - Cannot use conditional as expression inside var value

**What I was trying to do:** Calculate an absolute value using a conditional expression directly inside a variable declaration:
```xs
var $abs_dx { 
  value = conditional {
    if ($dx < 0) {
      return { value = 0 - $dx }
    }
    else {
      return { value = $dx }
    }
  }
}
```

**What the issue was:** The validator reported: `[Line 44, Column 19] Expecting: Expected an expression but found: 'conditional'`. The `conditional` block cannot be used as an expression within a `var` value assignment.

**Why it was an issue:** This is a common pattern in many languages (ternary operators, if-expressions), but XanoScript doesn't support it. I had to restructure the code to use a default value first, then use a separate `conditional` block to conditionally reassign the variable.

**Potential solution (if known):** 
1. Support conditional expressions in value assignments (ideal)
2. Document this limitation clearly with examples of the workaround pattern
3. Provide an `abs` filter for numeric values to avoid this common need

The workaround pattern is:
```xs
var $abs_dx { value = $dx }
conditional {
  if ($dx < 0) {
    var $abs_dx { value = 0 - $dx }
  }
}
```

---
