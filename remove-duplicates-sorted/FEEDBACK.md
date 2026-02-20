# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 12:00 PST] - Early return limitations

**What I was trying to do:** Implement an early return for edge cases (empty array or single element) in the remove_duplicates function

**What the issue was:** I tried to use `response $n` followed by `return` inside a conditional block within the `stack`, but this caused a syntax error: `[Line 11, Column 9] Expecting } but found response`

**Why it was an issue:** The documentation mentions "Return early - Use return for guard clauses" as a best practice, but it's not clear that `response` cannot be used inside the `stack` block. I had to restructure my logic to avoid early returns by wrapping the main logic in a conditional that only executes when the edge case conditions are NOT met.

**Potential solution (if known):** Clarify in the documentation that `response` is only valid as the final block of a function, not inside `stack`. Also clarify the exact syntax for early returns - perhaps show an example of a proper guard clause.

---

## [2025-02-20 12:05 PST] - Cannot modify input arrays by index

**What I was trying to do:** Update elements in the input array by index using `var.update $input.nums[$write_index] { value = $current }`

**What the issue was:** Got error: `[Line 22, Column 28] expecting variable (e.g. $variable or $var.variable) but found: '$input'`. The `$input` variable is reserved and cannot be modified, even for array element updates.

**Why it was an issue:** The classic "remove duplicates in-place" algorithm requires modifying the array. Since XanoScript doesn't allow modifying `$input` arrays directly by index, I had to create a copy of the array (`var $nums_copy { value = $input.nums }`) and modify that instead. This increases space complexity from O(1) to O(n).

**Potential solution (if known):** 
1. Allow modifying input array elements if they are passed by value/copy semantics
2. Or document this limitation clearly with guidance on the recommended workaround
3. Or provide a way to declare input parameters as mutable/reference types

---

## [2025-02-20 12:08 PST] - Documentation search was helpful

**What I was trying to do:** Find the correct XanoScript syntax for various constructs

**What the issue was:** None - the `xanoscript_docs` tool with `mode: quick_reference` was very useful for getting syntax quickly without burning too many tokens.

**Why it was NOT an issue:** The MCP documentation tool worked well and provided the information I needed.

**Potential solution (if known):** Keep this functionality! The quick_reference mode is great for active development.

---

## [2025-02-20 12:10 PST] - Array indexing in var.update

**What I was trying to do:** Update a specific element in an array variable using an index variable

**What the issue was:** Initially uncertain if `var.update $nums[$index] { value = ... }` was valid syntax

**Why it was an issue:** Not clear from documentation if array indexing works in `var.update` statements

**Potential solution (if known):** Add an example to the `var.update` documentation showing array element updates with variable indices.

---

## [2025-02-20 12:12 PST] - for() loop iteration syntax

**What I was trying to do:** Loop from 0 to n-2 to compare adjacent elements

**What the issue was:** The `for()` loop syntax uses `each as $i` which starts from 0 and goes up to the count-1. This wasn't immediately obvious.

**Why it was an issue:** Had to infer the iteration behavior from the foreach example and adapt it

**Potential solution (if known):** Add a clear example of the `for(count)` loop showing that `$i` starts at 0 and increments.
