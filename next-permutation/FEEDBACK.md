# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 03:35 PST] - Early return pattern confusion

**What I was trying to do:** Implement an early return for edge cases (empty array or single element) in the next permutation function.

**What the issue was:** I initially wrote code like this:
```xs
conditional {
  if ($n <= 1) {
    response = $arr
    return
  }
}
```

This produced the error: `Expecting --> } <-- but found --> 'response'`

**Why it was an issue:** I assumed XanoScript would support early returns inside conditionals like many other languages. The error message was confusing because it suggested the parser expected a closing brace but found 'response', which made me think there was a syntax error with my braces. The actual issue is that `return` inside a conditional followed by a later `response` statement is not valid.

**Potential solution (if known):** 
- Better error message: "Early return inside conditional blocks is not supported. Consider restructuring your logic to set a result variable conditionally instead."
- Or document this limitation clearly in the syntax documentation under conditionals section.

---

## [2026-03-01 03:38 PST] - Ternary operator precedence

**What I was trying to do:** Use the ternary operator `? :` for conditional array slicing.

**What the issue was:** The ternary operator syntax in XanoScript works as expected (`condition ? true_value : false_value`), but I initially wasn't sure if it was supported since it's not prominently documented in the syntax quick reference.

**Why it was an issue:** I had to guess whether ternary was supported or if I needed to use conditional blocks for simple value selection.

**Potential solution (if known):** Add ternary operator to the quick reference or operators section of the syntax documentation.

---

## [2026-03-01 03:40 PST] - Array element access and slicing

**What I was trying to do:** Access array elements by index and create sub-arrays.

**What the issue was:** I needed to distinguish between:
- `|get:N` - gets a single element
- `|slice:offset:length` - gets a sub-array

**Why it was an issue:** Initially I tried using `|slice:$i:1` thinking it would give me a single element, but that returns an array with one element. I had to look up the array-filters documentation to understand the difference.

**Potential solution (if known):** The documentation is actually clear on this once you find it, but maybe a more prominent warning in the syntax docs would help: "Use `|get` for single element access, `|slice` for sub-arrays."
