# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 05:35 PST] - Issue: Spaceship operator not supported

**What I was trying to do:** Sort an array of objects by two criteria (frequency ascending, then value descending) using a comparison operator.

**What the issue was:** I initially tried using the PHP-style `<=>` spaceship operator: `$items|sort:$a.freq <=> $b.freq || $b.num <=> $a.num`. This resulted in a parse error: "Expecting: one of these possible Token sequences... but found: '>'".

**Why it was an issue:** The XanoScript documentation mentions `|sort:n:text:false` for single-field sorting, but doesn't show examples for multi-field sorting. I assumed the spaceship operator (common in PHP, Ruby, Perl) would work for custom comparison logic.

**Potential solution (if known):** 
- Add documentation showing how to implement custom multi-field sorting
- Consider adding support for comparison operators or a callback-style sort
- Or document that developers should implement bubble/selection sort for complex sorting needs

---

## [2025-03-02 05:42 PST] - Issue: Cannot nest conditionals inside elseif

**What I was trying to do:** Handle a complex condition inside an `elseif` block by nesting an `if` statement.

**What the issue was:** I wrote:
```xs
elseif ($item_a.freq == $item_b.freq) {
  if ($item_a.num < $item_b.num) {
    var $should_swap { value = true }
  }
}
```

This resulted in: "Expecting --> } <-- but found --> 'if' <--"

**Why it was an issue:** XanoScript doesn't allow nested `conditional` blocks inside `elseif`. I had to combine the conditions into a single expression: `elseif ($item_a.freq == $item_b.freq && $item_a.num < $item_b.num)`.

**Potential solution (if known):**
- Allow nested conditionals within `elseif`/`else` blocks for more complex logic
- Or document this limitation clearly in the conditionals section

---

## [2025-03-02 05:35 PST] - Documentation Discovery

**What I was trying to do:** Find the correct syntax for array element access.

**What the issue was:** I initially used `$arr|get:$i` syntax from the filter documentation, but found that existing exercises use `$arr[$i]` notation instead.

**Why it was an issue:** Both syntaxes might work, but consistency matters. Reading existing working code was more helpful than the documentation for this specific pattern.

**Potential solution (if known):**
- Clarify in docs when to use `$arr[$i]` vs `$arr|get:$i`
- Both seem to work but `$arr[$i]` is more commonly used in the codebase

---

## General Feedback

**What's working well:**
- The `validate_xanoscript` tool provides clear error messages with line numbers
- The `xanoscript_docs` tool is helpful for looking up syntax
- The existing exercises in `~/xs/` serve as excellent reference material

**What's challenging:**
- No support for multi-field sorting in the `|sort` filter
- Limited conditional nesting can make complex logic verbose
- Had to discover that `elseif` (one word) is required vs `else if`

