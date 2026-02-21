# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 09:05 PST] - Response block placement confusion

**What I was trying to do:** Handle an edge case (empty input) by returning an empty array early from the function.

**What the issue was:** I initially wrote:
```xs
conditional {
  if (($input.digits|strlen) == 0) {
    response = []
    return
  }
}
```

This caused a validation error: `[Line 24, Column 9] Expecting --> } <-- but found --> 'response'`

**Why it was an issue:** The error message was not immediately clear about why `response` was unexpected. I had to infer that `response` can only be used in the function's `response` block at the end, not inside the stack logic. The `return` statement also appeared to be invalid syntax.

**Potential solution (if known):** 
- Better error message could say: "`response` cannot be used inside stack blocks. Use it only in the function's `response` block at the end."
- Documentation could clarify that early returns are not supported; use conditional logic with variables instead

---

## [2026-02-21 09:03 PST] - Variable scoping in conditionals

**What I was trying to do:** Set a result variable inside an if/else conditional block.

**What the issue was:** When I tried to set `$result` inside both the if and else branches, I wasn't sure if the variable would be accessible outside the conditional for the final `response` block.

**Why it was an issue:** Coming from JavaScript/TypeScript, I expected block scoping. I wasn't sure if declaring `var $result` inside a conditional would make it available at the function level.

**Potential solution (if known):**
- The documentation mentions variable scoping but could be clearer about how it works with conditionals
- An example showing variable declaration inside conditionals would be helpful

---

## [2026-02-21 09:00 PST] - Filter precedence with operators

**What I was trying to do:** Compare the result of a filter operation: `$arr|count == 0`

**What the issue was:** The quick reference clearly states this needs parentheses: `($arr|count) == 0`, but the error messages when forgetting this aren't always helpful.

**Why it was an issue:** The parser error can be cryptic when the filter binds incorrectly.

**Potential solution (if known):**
- The quick reference documentation is actually very clear about this - the `~` (concat) example with filters was particularly helpful
- The linter could potentially auto-suggest wrapping filter expressions in parentheses

---

## General Observations

**What's working well:**
- The `xanoscript_docs` tool with `mode: "quick_reference"` is excellent for getting concise syntax reminders
- The `validate_xanoscript` tool provides line/column error positions which is very helpful
- The suggestion hints (like "Use 'text' instead of 'string'") are useful

**What could be improved:**
1. **Early return pattern:** Many programmers expect to be able to return early from a function. The current pattern (set a variable in conditional branches, then respond at the end) works but feels verbose. If early return is truly not supported, explicit documentation about this pattern would help.

2. **Array building syntax:** Building arrays by using `|set` with the count as a string key feels unintuitive. A dedicated `array.push` or similar operation would be more discoverable.

3. **For loop indexing:** The pattern of using `for (count)` with `each as $i` works, but getting a character at an index requires `substr:$i:1` which is verbose for string iteration.
