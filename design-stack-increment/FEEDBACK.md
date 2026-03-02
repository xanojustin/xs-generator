# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 18:35 PST] - Filter expressions require parentheses when combined with operators

**What I was trying to do:** Write a conditional that checks if a stack is empty using `$stack|count == 0`

**What the issue was:** The validator rejected the code with error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This wasn't clear from the initial documentation. The pattern `$variable|filter == value` seems natural but requires parentheses around the filter expression.

**Potential solution (if known):** 
- The docs mention this in the syntax section but it's easy to miss
- A linter warning or auto-formatter could help catch this
- Perhaps the parser could be more forgiving for simple cases like `$stack|count == 0`

---

## [2025-03-01 18:36 PST] - Array slice syntax for removing last element

**What I was trying to do:** Remove the last element from an array to implement pop

**What the issue was:** I used `$stack|slice:0:$top_idx` but wasn't sure if this was the correct approach

**Why it was an issue:** The documentation mentions `slice` filter but doesn't give clear examples for common operations like "remove last element" or "get all but last"

**Potential solution (if known):**
- Add more examples for common array manipulation patterns
- A `drop_last` or `pop` filter could be useful for stack operations

---

## [2025-03-01 18:37 PST] - JSON type for mixed array input

**What I was trying to do:** Accept an array where each element could be either a number or an array of numbers (for operation arguments)

**What the issue was:** The values array contains mixed types: `[]` for pop operations and `[2, 100]` for increment operations

**Why it was an issue:** XanoScript doesn't seem to have a clean way to express "array of mixed types" in the input schema. I used `json` type as a workaround.

**Potential solution (if known):**
- Support for union types would be helpful: `int[] | int[][]`
- Better documentation on handling heterogeneous arrays
- An `any` or `mixed` type for truly dynamic input

---

## [2025-03-01 18:38 PST] - Array indexing with variables

**What I was trying to do:** Access array elements using a variable index: `$stack[$j]`

**What the issue was:** I wasn't sure if variable indexing was supported or if there was a specific syntax

**Why it was an issue:** The docs show basic array access but don't clearly document dynamic indexing

**Potential solution (if known):**
- Add explicit examples of variable-based array indexing
- Clarify if this works the same for all array types
