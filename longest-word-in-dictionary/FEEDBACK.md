# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 02:32 PST] - Sort filter syntax confusion

**What I was trying to do:** Sort an array of strings by their length (descending), and for equal lengths, lexicographically.

**What the issue was:** The initial attempt used `|sort:$$|strlen:text:false` which caused a parse error. The MCP error message suggested using "text" instead of "string" which was misleading - the actual issue was that the sort filter doesn't support computed expressions like `strlen` as sort keys.

**Why it was an issue:** The error message "Use 'text' instead of 'string' for type declaration" didn't help because I wasn't using "string" - I was trying to chain filters. It took experimentation to realize the sort filter expects a property name for object sorting, not computed values.

**Potential solution (if known):** The documentation could clarify:
1. The `sort` filter syntax more explicitly: `|sort:propertyName:type:ascending`
2. That computed values/filters cannot be used as sort keys directly
3. How to sort by computed values (may need to use map to create objects with computed properties first)

---

## [2026-03-01 02:35 PST] - Sort filter type parameter confusion

**What I was trying to do:** Sort an array of text values lexicographically with explicit type specification.

**What the issue was:** Used `|sort:$$|text:true` thinking `$$` represents the element itself and `text` is the type, but this resulted in "Unknown filter function 'text'" error.

**Why it was an issue:** The documentation shows `|sort:n:text:false` for sorting objects by property `n`, but it's unclear what syntax to use for sorting primitive arrays. The `$$` symbol and type parameter caused confusion.

**Potential solution (if known):** The quick reference could include:
1. Example for sorting primitive arrays: `["b", "a", "c"]|sort` → `["a", "b", "c"]`
2. Clarify that for primitives, just use `|sort` without parameters
3. Show the difference between object sorting (with property name) and primitive sorting

---

## [2026-03-01 02:38 PST] - Missing array sort by computed value pattern

**What I was trying to do:** Sort words by their string length, which is a common pattern in coding exercises.

**What the issue was:** XanoScript doesn't appear to have a straightforward way to sort by a computed value (like `strlen`). I had to restructure the algorithm to find max length first, then iterate through lengths in reverse order.

**Why it was an issue:** This made the code more complex than necessary. Instead of a simple sort, I needed nested loops and manual length filtering.

**Potential solution (if known):** 
1. Add a `sort_by` filter that takes an expression: `|sort_by:$$|strlen`
2. Or document a pattern using `map` to create temporary objects with computed properties, sort, then extract
3. Example:
   ```xs
   var $with_lengths { value = $words|map:{word: $$, len: $$|strlen} }
   var $sorted { value = $with_lengths|sort:len:int:false }
   var $result { value = $sorted|map:$$.word }
   ```

---

## General Observations

**Positive:**
- The `validate_xanoscript` tool is very helpful with clear error messages including line/column numbers
- The suggestion hints in error messages are useful (when relevant to the actual error)
- Documentation for basic constructs (functions, run jobs, variables) is comprehensive

**Areas for improvement:**
1. More complex filter chaining examples in documentation
2. Clarify filter syntax limitations (what can/cannot be chained)
3. Common algorithm patterns (sorting by computed values, custom comparators)
