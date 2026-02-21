# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 02:35 PST] - Filter expression parentheses requirement

**What I was trying to do:** Write a conditional statement that compares the result of a filter operation, like `$arr|count <= 1` and `$arr|get:$mid|to_int == 0`.

**What the issue was:** The validator rejected expressions like `$arr|count <= 1` with the error: "An expression should be wrapped in parentheses when combining filters and tests". I had to wrap the filter portion in parentheses: `($arr|count) <= 1`.

**Why it was an issue:** This wasn't clear from the quick reference documentation. The examples show `($status|to_text)` for string concatenation, but don't explicitly mention that comparison operations with filters require parentheses around the filter expression portion.

**Potential solution (if known):** 
- Add a note in the quickstart documentation under "Quick Filter Reference" or "Conditional Logic" sections explicitly stating that filter expressions used in comparisons must be wrapped in parentheses
- Example: `if (($arr|count) > 0)` not `if ($arr|count > 0)`
- This applies to any binary operator (==, !=, <, >, <=, >=) when the left operand is a filter expression

---

## [2026-02-21 02:32 PST] - Array element access syntax clarification

**What I was trying to do:** Access array elements by index using a variable, like `$arr[$mid]` or similar syntax.

**What the issue was:** I wasn't sure what the correct syntax was for accessing array elements by dynamic index in XanoScript. I guessed `|get:$mid` based on the filter pattern used elsewhere.

**Why it was an issue:** The quick reference documentation doesn't explicitly show how to access array elements by variable index. The filter reference mentions `|get` but not specifically for array indexing with variables.

**Potential solution (if known):**
- Add an example in the quickstart showing array element access: `$arr|get:$index` for accessing by variable index
- Clarify the difference between `$arr|first` (filter) vs `$arr|get:$i` (dynamic index access)

---

## [2026-02-21 02:30 PST] - to_int filter for array element comparison

**What I was trying to do:** Compare an array element (which comes from a dynamic `get` filter) to an integer value.

**What the issue was:** I assumed that after using `$arr|get:$mid`, the result would be an integer that could be directly compared. However, I wasn't sure if type coercion was automatic or if I needed explicit conversion, so I added `|to_int` to be safe.

**Why it was an issue:** Unclear whether array elements accessed via `|get` retain their type or become generic values that need casting for comparison.

**Potential solution (if known):**
- Document type behavior when accessing array elements via filters
- Clarify if `|get` preserves the original type or if explicit type conversion is recommended for comparisons

---

## [2026-02-21 02:30 PST] - Array modification in place (set filter)

**What I was trying to do:** Swap array elements in place as required by the Dutch National Flag algorithm.

**What the issue was:** I wasn't sure if XanoScript arrays are mutable or if I need to create new arrays. I guessed that `|set:index:value` creates a new array with the modification rather than modifying in place, which seems to be the pattern (reassigning to `$arr`).

**Why it was an issue:** Functional vs imperative paradigm isn't clear. The documentation shows `var $arr { value = ... }` for declaration but doesn't clarify if reassignment creates a new variable or updates existing.

**Potential solution (if known):**
- Clarify immutability semantics in XanoScript
- Document that `|set` returns a new array rather than modifying in place
- Add example showing the pattern: `var $arr { value = $arr|set:$i:$newValue }`

---
