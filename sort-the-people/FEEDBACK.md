# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 01:35 PST] - Missing order_by filter

**What I was trying to do:** Sort an array of objects by a specific field (height) in descending order.

**What the issue was:** I assumed there would be an `order_by` filter similar to other languages/frameworks, but the validation error showed: `Unknown filter function 'order_by'`.

**Why it was an issue:** I had to manually implement a bubble sort algorithm instead of using a built-in sorting function. This made the code more verbose and complex than necessary.

**Potential solution (if known):** 
- Add an `order_by` or `sort_by` filter that can sort arrays of objects by a specified field
- Syntax could be: `$array|sort_by:"field_name":"asc|desc"`
- Alternatively, document which filters ARE available for array manipulation more clearly

---

## [2025-02-28 01:36 PST] - Finding available filters is difficult

**What I was trying to do:** Find documentation on what filters are available for arrays and sorting.

**What the issue was:** The `xanoscript_docs` tool returns general documentation but doesn't seem to have specific topic filtering working properly (all my topic queries returned the same general docs). I had to look at existing code examples to figure out what filters exist.

**Why it was an issue:** It's hard to discover the correct syntax without being able to query specific topics or see a comprehensive filter reference.

**Potential solution (if known):**
- Ensure the topic parameter works for `xanoscript_docs` to get specific documentation
- Provide a filters/syntax reference topic that lists all available filters
- Include examples of common operations like sorting, filtering, mapping

---

## [2025-02-28 01:37 PST] - MCP validate_xanoscript parameter format was unclear

**What I was trying to do:** Validate XanoScript files using the MCP tool.

**What the issue was:** Initially tried passing JSON parameters which didn't work. Had to figure out the correct mcporter CLI syntax using `key=value` format.

**Why it was an issue:** Wasted time trying different JSON formats before discovering the flag-style syntax.

**Potential solution (if known):**
- The error message was helpful eventually, showing which parameters were required
- Better documentation on MCP tool parameter formats would help
