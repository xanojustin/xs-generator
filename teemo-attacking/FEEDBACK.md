# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 20:05 PST] - Conditional Block Requirement Not Obvious

**What I was trying to do:** Write an `if` statement inside a function stack to handle conditional logic.

**What the issue was:** I wrote `if (condition) { ... }` directly inside the stack block, but XanoScript requires `if` statements to be wrapped in a `conditional { ... }` block. The error message was: `Expecting --> } <-- but found --> 'if'`, which didn't immediately clarify that I needed a `conditional` wrapper.

**Why it was an issue:** As someone familiar with many programming languages, I expected `if` to work standalone like in JavaScript, Python, etc. The need for a `conditional` block is unique to XanoScript and wasn't obvious from the quick reference documentation I initially retrieved.

**Potential solution:** 
- The error message could be more helpful: "`if` statements must be inside a `conditional` block. Try: `conditional { if (condition) { ... } }`"
- The quick reference could include a prominent example of the `conditional` block pattern
- Perhaps consider allowing bare `if` statements (though this may be a language design constraint)

---

## [2026-02-24 20:08 PST] - Filter Precedence and Parentheses

**What I was trying to do:** Compare the result of a filter operation: `if ($arr|count == 0)`

**What the issue was:** The quick reference mentions that filters bind greedily and you need parentheses around filtered expressions when using operators, but this is easy to forget in practice.

**Why it was an issue:** I had to look up the syntax again to confirm: `if (($input.time_series|count) == 0)` is correct.

**Potential solution:**
- A linter warning when filters are used without parentheses in comparisons would be helpful
- The VS Code extension could provide auto-fixes for this common pattern

---

## [2026-02-24 20:10 PST] - Array Indexing Syntax Clarification

**What I was trying to do:** Access an array element by index: `$input.time_series[$i]`

**What the issue was:** I wasn't 100% sure if XanoScript uses bracket notation or a filter for array access.

**Why it was an issue:** I guessed bracket notation would work (common pattern), but confirmation required trial and error since the quick reference only showed `get` filter for objects, not arrays.

**Potential solution:**
- The quick reference could explicitly show array indexing syntax: `$arr[0]` or `$arr[$index]`
- Document whether array access returns null or errors on out-of-bounds
