# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-19 02:35 PST - Initial Validation Success

**What I was trying to do:** Validate the merge sort function implementation

**What happened:** The validation passed on the first attempt with no errors

**Why this worked well:** 
- The XanoScript syntax patterns from existing examples were clear and consistent
- The iterative bottom-up merge sort approach translated cleanly to XanoScript's variable and loop constructs
- Using `var.update` for array modifications and index tracking worked as expected

---

## 2025-02-19 02:32 PST - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter

**What the issue was:** The parameter format was unclear. Initially tried JSON format with `mcporter call xano validate_xanoscript '{"file_path": "/path"}'` but got "parameter required" errors

**Why it was an issue:** The documentation in the tool description shows `mcporter call xano.validate_xanoscript(file_path: "/path/to/file.md", file, ...)` but the actual working syntax is `mcporter call xano.validate_xanoscript "file_path=/path/to/file"`

**Potential solution:** Clearer documentation on the exact mcporter CLI syntax for passing named parameters. The parenthetical notation in the tool description looks like Python/TypeScript function call syntax, not shell CLI syntax.

---

## 2025-02-19 02:30 PST - XanoScript Documentation Topics Not Differentiated

**What I was trying to do:** Get specific documentation for syntax, functions, and run topics to understand merge sort implementation patterns

**What the issue was:** All calls to `xanoscript_docs` with different topics (quickstart, functions, syntax, run) returned identical general documentation

**Why it was an issue:** Expected topic-specific content (e.g., detailed loop syntax, variable patterns, examples) but received the same workspace structure overview each time

**Potential solution:** Either the topic filtering isn't working correctly, or the documentation needs to be segmented into topic-specific content. The general docs were helpful but didn't provide the deep syntax reference expected.

---

## 2025-02-19 02:28 PST - Merge Sort Algorithm Adaptation

**What I was trying to do:** Implement merge sort in XanoScript

**What the challenge was:** Classic merge sort is recursive (divide array, sort halves, merge), but XanoScript functions don't appear to support direct recursion

**Why it was a challenge:** Had to convert the recursive algorithm to an iterative bottom-up approach using variable-width subarrays

**The solution:** Used a `width` variable that doubles each iteration (1, 2, 4, 8...) and merges adjacent subarrays of that width. This achieves the same O(n log n) complexity without recursion.

**Documentation suggestion:** Would be helpful to have guidance on algorithmic patterns - when to use iteration vs trying to simulate recursion with explicit stacks

---

## General Observations

**What worked well:**
- Existing exercise examples (bubble-sort, merge-sorted-arrays) provided excellent reference patterns
- XanoScript's syntax for arrays, conditionals, and loops is intuitive
- The `each` block pattern for while loops is clear once understood
- Filter syntax like `|min:`, `|merge:`, `|set:` is powerful

**XanoScript syntax notes for future reference:**
- `var $name { value = ... }` declares a variable
- `var.update $name { value = ... }` updates a variable
- `conditional { if (...) { ... } else { ... } }` for if-else logic
- `$array[$index]` for element access
- `$array|set:$index:$value` for setting elements
- `$array|merge:[$element]` for appending elements
- `$value|min:$other` for minimum function
- `while` loops require `each` blocks inside them
