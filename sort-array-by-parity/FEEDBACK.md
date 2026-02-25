# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 17:35 PST] - Filter compatibility confusion

**What I was trying to do:** Add input validation to ensure the array input has at least 0 elements (is not null)

**What the issue was:** I used `filters=min_count:0` on an `int[]` type input, but got the error "Filter 'min_count' cannot be applied to input of type 'int'"

**Why it was an issue:** The error message was confusing because I was applying the filter to `int[]` (array of ints), not `int`. It seems like the validation is checking the element type rather than the container type. I expected `min_count` to work on arrays to validate minimum array length.

**Potential solution (if known):** 
- Clarify in documentation which filters work on arrays vs primitives
- Better error message: "Filter 'min_count' cannot be applied to array element type 'int' - use on array type instead" or similar
- List valid filters for array types in the types documentation

---

## [2025-02-24 17:32 PST] - Finding filter documentation

**What I was trying to do:** Find what filters are available for array type inputs

**What the issue was:** The `xanoscript_docs` function has a `types` topic but it wasn't immediately obvious how to discover valid filters for specific types

**Why it was an issue:** Had to guess at filter names based on common patterns. Would be helpful to have a quick reference of "valid filters by type"

**Potential solution (if known):** 
- Add a "filters by type" quick reference topic to documentation
- Or include common filter examples in the quickstart guide for each type

---
