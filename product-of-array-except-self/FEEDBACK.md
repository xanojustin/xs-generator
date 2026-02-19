# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 09:05 PST] - min_count Filter Not Working on Array Types

**What I was trying to do:** Add input validation to ensure the `int[] nums` array parameter has at least 2 elements.

**What the issue was:** I attempted to use `filters=min_count:2` on an array input declaration:
```xs
int[] nums filters=min_count:2 {
  description = "Array of integers (minimum 2 elements)"
}
```

This resulted in the error:
```
[Line 4, Column 24] Filter 'min_count' cannot be applied to input of type 'int'
```

The error message suggests the filter is being applied to the inner `int` type rather than the `int[]` array type itself.

**Why it was an issue:** This was confusing because:
1. The documentation mentions `min_count` as a validation filter
2. I expected `int[]` to be treated as an array type for filter purposes
3. The error message says "int" not "int[]", implying the filter sees the element type, not the container type
4. I had to work around this by using a `precondition` in the stack instead of the declarative input filter

**Potential solution (if known):** 
- Clarify in documentation which filters work on array types vs element types
- Either fix `min_count` to work on array inputs, or provide an alternative like `array_min_count`
- Improve the error message to say "int[]" instead of "int" if that's what's being validated
- Consider adding array-specific filters like `min_length`, `max_length` for arrays

**Workaround used:** Replaced the filter with a `precondition` check in the stack:
```xs
precondition (($input.nums|count) >= 2) {
  error_type = "standard"
  error = "Input array must contain at least 2 elements"
}
```

---
