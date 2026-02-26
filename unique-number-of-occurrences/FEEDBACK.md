# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 18:35 PST] - Loop Syntax Confusion

**What I was trying to do:** Iterate over an input array to count element frequencies

**What the issue was:** I incorrectly used `each ($input.arr as $num)` as a standalone loop construct, similar to JavaScript's `for...of` or PHP's `foreach`. The validator reported: `Expecting --> } <-- but found --> 'each'`

**Why it was an issue:** I assumed `each` was the primary loop keyword in XanoScript based on other languages, but it's actually a secondary keyword used inside `foreach` or `for` loops to access the current iteration variable. The correct pattern is:
```xs
foreach ($input.arr) {
  each as $num {
    // use $num here
  }
}
```

**Potential solution:** The quickstart documentation does show the correct pattern, but it wasn't immediately obvious that `each` can't be used standalone. A more prominent "Common Mistake" entry about loop syntax would help, or an IDE/linter that suggests the `foreach` + `each` pattern when `each` is used incorrectly.

---

## [2025-02-25 18:37 PST] - Object Key Existence Filter Name

**What I was trying to do:** Check if a key exists in an object (frequency map)

**What the issue was:** I guessed the filter name would be `has_key` (common in many languages), but XanoScript uses simply `has`. The validator reported: `Unknown filter function 'has_key'`

**Why it was an issue:** Without IDE autocomplete or a clear filter reference in the quickstart, I had to guess the filter name. I tried `has_key` first since that's common in PHP and other languages.

**Potential solution:** 
1. Include a "Common Object Operations" section in the quickstart with `has`, `get`, `set`, `keys`, `values` filters
2. The MCP could provide a `suggest_filter` tool that takes a description and returns likely filter names
3. The error message could suggest similar filter names ("Did you mean `has`?")

---

## General Feedback

**MCP Tool Experience:** The `validate_xanoscript` tool works well and provides helpful line/column positions and suggestions. The `file_paths` parameter for batch validation is convenient.

**Documentation Gaps:**
1. A concise "Filter Cheat Sheet" in the quickstart showing the most common filters by category (object, array, string) would save time
2. More cross-references between related topics (e.g., from `quickstart` to `syntax` for complete filter list)

**Overall:** Once I understood the correct patterns, writing XanoScript was straightforward. The main friction points were around guessing the right syntax/filter names for common operations.
