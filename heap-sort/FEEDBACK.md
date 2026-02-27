# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 01:35 PST] - Missing array index manipulation filters

**What I was trying to do:** Implement heap sort algorithm which requires swapping elements at specific indices within an array

**What the issue was:** XanoScript doesn't have `set_index` or `get_index` filters for arrays. The validation failed with "Unknown filter function 'set_index'" when I tried to use:
```
var $heap { value = $heap|set_index:$parent_idx,$heap[$largest] }
```

**Why it was an issue:** Heap sort (and many other in-place algorithms) require the ability to modify array elements at specific indices. Without this capability, I had to:
1. Convert the array to an object with string keys
2. Use `set:(index|to_text):value` and `get:(index|to_text)` for manipulation
3. Convert back to array at the end

This workaround is less intuitive and adds unnecessary complexity.

**Potential solution:** Add `set_index` and `get_index` filters for arrays:
- `array|set_index:index:value` - Set element at index to value
- `array|get_index:index` - Get element at index (or just allow array[index] syntax in all contexts)

---

## [2025-02-27 01:38 PST] - Backtick expression assignment syntax unclear

**What I was trying to do:** Define a helper "function" using backtick expressions to reduce code duplication for getting heap values

**What the issue was:** I attempted to write:
```
var $get_heap_value = `
  function($heap, $index) {
    $index_text = $index|to_text;
    $heap|$index_text
  }
`
```

This resulted in a parser error: "Expecting: one of these possible Token sequences... but found: '='"

**Why it was an issue:** I was unsure how to properly use backtick expressions in XanoScript. The syntax for creating reusable expression logic isn't clear from examples.

**Potential solution:** 
1. Clarify in documentation what backtick expressions can and cannot be used for
2. Provide examples of proper backtick expression usage
3. If reusable functions/helpers aren't supported, explicitly state this limitation

---

## [2025-02-27 01:40 PST] - Array vs Object type confusion for mutable data structures

**What I was trying to do:** Find the best way to implement an in-place sorting algorithm

**What the issue was:** XanoScript treats arrays as immutable for index-based modifications, but objects are mutable with `set`/`get` filters. This distinction wasn't immediately obvious.

**Why it was an issue:** Required trial and error to discover that:
- Arrays work with `push`, `merge`, `~` operators
- Objects work with `set`, `get` filters for key-based access
- Converting between them requires manual iteration

**Potential solution:** 
1. Add documentation section comparing array vs object capabilities
2. Provide a cookbook example showing how to implement in-place algorithms
3. Consider adding a `to_object` and `to_array` filter pair for easier conversion

---

## [2025-02-27 01:42 PST] - Validation feedback quality

**What I was trying to do:** Validate XanoScript code during development

**What the issue was:** The validation tool worked well! The error messages were specific (line numbers, column positions) and the suggestions were helpful.

**Positive feedback:**
- Line and column numbers made it easy to locate issues
- The "Code at line X:" snippet helped understand context
- Suggestion to use "int" instead of "integer" was helpful

---
