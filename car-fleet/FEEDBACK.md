# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-04 05:35 PST] - Filter expressions need parentheses when combined with operators

**What I was trying to do:** Write a precondition to validate that two arrays have the same length.

**What the issue was:** The code `$input.position|count == $input.speed|count` caused a validation error saying "An expression should be wrapped in parentheses when combining filters and tests."

**Why it was an issue:** This syntax feels natural and similar to many other languages where filters/methods can be chained with operators. The need for parentheses wasn't immediately obvious from the error message, though the fix was simple: `($input.position|count) == ($input.speed|count)`.

**Potential solution (if known):** Better error message could suggest the fix directly, e.g., "Wrap each filter expression in parentheses: `($input.position|count) == ($input.speed|count)`"

---

## [2025-03-04 05:38 PST] - Sort filter syntax unclear

**What I was trying to do:** Sort an array of objects by a field named "position".

**What the issue was:** I tried multiple syntaxes that all failed:
- `$cars|sort:position:int:true` - field name without quotes failed
- `$cars|sort:"position":int:true` - with quotes but including type parameter failed
- `$cars|sort:"position":integer:true` - using "integer" instead of "int" failed with suggestion to use "int"

**Why it was an issue:** The documentation example `[{n:"z"},{n:"a"}]|sort:n:text:false` suggests the syntax is `|sort:field:type:descending`, but this didn't work. The actual working syntax was just `|sort:"position"` with only the field name in quotes.

**Potential solution (if known):** The documentation for the sort filter could be clearer about:
1. Whether the field name needs quotes
2. Whether the type parameter is required or optional
3. What the valid type values are (int vs integer)

---

## [2025-03-04 05:42 PST] - Comments between elseif and conditional closing brace cause parse errors

**What I was trying to do:** Add a comment explaining the implicit else case in a conditional block.

**What the issue was:** This code caused a parse error:
```xs
elseif ($car.time > $current_time) {
  // ...
}
// Else: car merges with current fleet (faster but blocked)
}
```

The parser expected `else` or `elseif` after the `elseif` block's closing `}`, but found a comment and then the `conditional` block's closing `}`.

**Why it was an issue:** Comments should generally be allowed anywhere without affecting parsing. The workaround was to remove the comment entirely or move it inside the `elseif` block.

**Potential solution (if known):** The parser should ignore comments when determining block structure, allowing comments between branches of a conditional block.

---

## [2025-03-04 05:44 PST] - Type naming inconsistency

**What I was trying to do:** Use the correct type name in the sort filter.

**What the issue was:** The error suggested using "int" instead of "integer", which was helpful. However, there's an inconsistency in the language where:
- Function input declarations use `int` (e.g., `int target`)
- But the error message about type names suggests "int" as a correction

**Why it was an issue:** Minor confusion about when to use which type name format.

**Potential solution (if known):** Standardize type names across all contexts, or document which contexts use which naming convention.

---

## [2025-03-04 05:45 PST] - MCP tool: xanoscript_docs parameter discovery

**What I was trying to do:** Find the correct syntax for the sort filter by querying documentation.

**What the issue was:** Had to guess which topics might contain the information I needed. The `mode="index"` option wasn't obvious from the initial tool description.

**Why it was an issue:** Had to make multiple calls to find the right documentation topic.

**Potential solution (if known):** The documentation tool could benefit from:
1. A search function to find topics by keyword
2. Better cross-referencing between related topics
3. More examples in the quick_reference mode for common operations

