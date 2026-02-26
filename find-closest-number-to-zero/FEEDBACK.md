# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 03:00 PST] - Ternary Operator with Unary Minus

**What I was trying to do:** Calculate absolute value using a ternary operator with unary minus

**What the issue was:** The XanoScript parser doesn't support unary minus (`-$num`) inside ternary expressions. The code `value = $num < 0 ? -$num : $num` caused a parse error at the `-` character.

**Why it was an issue:** This is a common pattern in many languages (JavaScript, C, Java, etc.) but doesn't work in XanoScript. The error message was helpful but didn't explicitly state that unary minus isn't supported in ternary expressions.

**Potential solution (if known):** 
1. Better documentation about unary operator limitations in ternary expressions
2. Or support unary minus in ternary expressions (preferred)
3. Workaround: Use `0 - $num` instead of `-$num`, or use conditional blocks instead of ternary

**Workaround used:** Replaced ternary expressions with conditional blocks:
```xs
var $current_abs { value = $num }
conditional {
  if ($num < 0) {
    var.update $current_abs { value = 0 - $num }
  }
}
```

---
