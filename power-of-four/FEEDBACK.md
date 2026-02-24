# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 09:05 PST] - Bitwise Operator Syntax Discovery

**What I was trying to do:** Implement a bit manipulation solution for the "power of four" problem using bitwise AND operations (`n & (n-1)` and `n & 0x55555555`).

**What the issue was:** I initially tried to use the standard C-style bitwise AND operator `&` directly in conditional expressions:
```xs
elseif (($input.number & ($input.number - 1)) != 0) {
```

This caused a parse error: "Expecting --> ) <-- but found --> '('"

**Why it was an issue:** The validation error message was confusing - it suggested using "decimal" instead of "number" or "int" instead of "integer", which wasn't the actual problem. The real issue was that XanoScript doesn't support inline bitwise operators like `&`, `|`, `^`, `~`, `<<`, `>>` in expressions.

**Potential solution (if known):** 
1. Better error messaging for unsupported operators - the current error is misleading
2. Documentation could more prominently feature the `math.bitwise.*` function family
3. A note in the operators table about bitwise operations requiring functions instead of operators would help

**Resolution:** Found the `math.bitwise.and` function in the syntax docs. The correct pattern is:
```xs
var $temp { value = $input.number }
math.bitwise.and $temp {
  value = $other_number
}
// Result is now in $temp
```

This operates on the variable in-place rather than returning a new value, which is a different pattern than most languages use.

---

## [2025-02-24 09:08 PST] - Multiple Variable Declarations in Conditional Branches

**What I was trying to do:** Declare `$result` variable in different branches of conditional blocks.

**What the issue was:** I had to declare `var $result` separately in each branch of nested conditionals.

**Why it was an issue:** Initially I tried declaring `$result` once at the top, but XanoScript's block-scoped nature and the requirement to handle all code paths properly meant I needed to ensure `$result` was always defined before the `response = $result` line.

**Potential solution (if known):** This is likely correct behavior - just noting that variable scope works differently than some languages. Each branch that could be the exit path needs to set the response variable.

---
