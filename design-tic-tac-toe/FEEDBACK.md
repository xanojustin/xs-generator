# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-03-01 21:05 PST - No nested array type support (int[][])

**What I was trying to do:** Define a 2D array input for the Tic-Tac-Toe board using `int[][] board?`

**What the issue was:** XanoScript parser rejected the syntax with error: `Expecting token of type --> Identifier <-- but found --> '['`

**Why it was an issue:** This is a common pattern in many languages for representing grids/matrices. I had to refactor to use a flattened 1D array with manual index calculation (row * n + col).

**Potential solution:** Support for nested array types would make grid-based problems more natural to implement. Alternative: document this limitation clearly in the types documentation.

---

## 2026-03-01 21:15 PST - Response placement confusion

**What I was trying to do:** Return different response objects from within conditional blocks based on the operation type (init vs move)

**What the issue was:** Got error `Expecting --> } <-- but found --> 'response'` when trying to use `response = { ... }` inside a conditional within the stack block

**Why it was an issue:** Intuitively, it feels like you should be able to return early from different branches. I had to restructure to use a `$result` variable that's updated in conditionals and then returned at the function level.

**Potential solution:** Either:
1. Support early return syntax (like `return { value = ... }` inside conditionals)
2. Clarify in documentation that response must be at function level, not inside stack
3. Provide better error message explaining the correct pattern

---

## 2026-03-01 21:20 PST - Limited documentation on XanoScript constraints

**What I was trying to do:** Find documentation on what XanoScript supports and doesn't support

**What the issue was:** Had to discover through trial and error that:
- No 2D arrays
- No early return from functions
- Response must be at function level

**Why it was an issue:** Wastes time with validation cycles when the constraints are known but not documented. The `essentials` topic was helpful but could include a "Common Gotchas" section.

**Potential solution:** Add a "Limitations and Constraints" section to the essentials documentation that lists:
- Type system limitations (no nested arrays)
- Control flow constraints (no early return)
- Structure requirements (response placement)

---

## 2026-03-01 21:25 PST - Missing CHANGES.md update automation

**What I was trying to do:** Keep CHANGES.md updated between validation attempts

**What the issue was:** It's manual and easy to forget. The workflow requires documenting after each validation but this is tedious.

**Why it was an issue:** Manual documentation steps interrupt the flow of write → validate → fix.

**Potential solution:** The validate_xanoscript tool could optionally append to CHANGES.md automatically, or generate a diff report that can be easily copied.

---

## 2026-03-01 21:30 PST - No ternary operator support?

**What I was trying to do:** Use ternary operator for player switching: `$input.current_player == 1 ? 2 : 1`

**What the issue was:** Unsure if this syntax is supported - the validator accepted it but I haven't actually tested execution.

**Why it was an issue:** Uncertainty about whether the code will work at runtime.

**Potential solution:** Document supported operators more explicitly, including whether ternary/conditional expressions work.

---

## Summary

Overall the MCP validation tool was very helpful - fast feedback and clear error messages with line/column numbers. The main pain points were:

1. **Language feature discovery** - Had to learn by failing validation rather than reading upfront constraints
2. **Array type limitations** - Common pattern (2D arrays) not supported, requiring workaround
3. **Function structure** - Response placement rules not immediately obvious

The validation workflow itself worked well and helped me fix issues quickly.