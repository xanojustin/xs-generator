# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 23:05 PST] - Issue 1: Unknown filter function 'has_key'

**What I was trying to do:** Build an adjacency list to represent a graph using an object where keys are vertex IDs and values are arrays of neighbors.

**What the issue was:** I tried to use `$adj|has_key:$u` to check if a key exists in the object, but `has_key` is not a valid XanoScript filter.

**Why it was an issue:** The validation failed with error: "Unknown filter function 'has_key'". I had to search the syntax documentation to find the correct filter name.

**Potential solution:** The correct filter is `has` (e.g., `$adj|has:$u`). It would be helpful if the MCP validation error suggested the correct filter name, or if there was an alias from `has_key` to `has` since `has_key` is a common name in other languages.

---

## [2026-03-01 23:08 PST] - Issue 2: Unknown filter function 'tail'

**What I was trying to do:** Implement BFS traversal using a queue, dequeue by removing the first element and getting the remaining elements (tail).

**What the issue was:** I tried to use `$queue|tail` to get all elements except the first, but `tail` is not a valid XanoScript filter.

**Why it was an issue:** The validation failed with error: "Unknown filter function 'tail'". I had to consult the array filters documentation to find an alternative.

**Potential solution:** I worked around this by using `slice:1:$queue_len` instead. It would be convenient if `tail` was available as an alias for `slice:1:count`, or if the error message suggested using `slice`. Alternatively, a statement-level `array.shift` could be used.

---

## [2026-03-01 23:10 PST] - Issue 3: Difficulty discovering available filters

**What I was trying to do:** Find the correct filter names for object and array operations.

**What the issue was:** I had to call `xanoscript_docs` multiple times with different topic parameters to find the filter documentation. The documentation is well-organized but discovering which topic contains what I needed took some trial and error.

**Why it was an issue:** It slowed down development as I had to make multiple documentation calls to find `has`, `slice`, `push`, etc.

**Potential solution:** 
- A filter index or search functionality in the MCP would be helpful (e.g., `search_filters query:"check if object has key"`)
- Or a `list_filters` tool that returns all available filters organized by type
- Error messages could include "Did you mean:" suggestions for common misnamed filters

---

## [2026-03-01 23:12 PST] - Positive Feedback: Good error messages

**What worked well:** The validation error messages from the MCP were very helpful - they included:
- Exact line and column numbers
- The problematic code snippet
- Clear description of what was expected vs what was found

This made debugging much faster once I understood the filter naming conventions.

---

## General Observations

1. **Filter naming is consistent but different from JS/Python:** Once I understood that XanoScript uses short names like `has`, `get`, `set`, `count`, `slice` without underscores, it became easier to guess the right filter names.

2. **Type-specific filters prevent bugs:** The strict separation between string filters (`strlen`, `substr`) and array filters (`count`, `slice`) is a good design choice that prevents common bugs.

3. **Documentation is comprehensive:** The `xanoscript_docs` tool provides excellent documentation once you find the right topic.

---
