# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 10:05 PST] - Issue: Unknown filter function 'has_key'

**What I was trying to do:** Check if a key exists in an object (frequency map) to either increment an existing count or initialize a new one.

**What the issue was:** I assumed there was a `has_key` filter similar to other languages, but XanoScript uses `has` instead. The error message was clear: "Unknown filter function 'has_key'".

**Why it was an issue:** I had to look through the full syntax documentation to find the correct filter name. The quick reference didn't explicitly show the `has` filter for objects.

**Potential solution (if known):** The quick reference could include a small table of common object filters like `has`, `get`, `set`, `keys`, `values` to make them more discoverable.

---

## [2025-02-21 10:06 PST] - Issue: Object merge syntax confusion

**What I was trying to do:** Update an object by adding or modifying a key-value pair using the `merge` filter.

**What the issue was:** I tried to use `$freq_map|merge:{($num|to_text): $updated}` which caused a parse error: "Expecting --> } <-- but found --> '(' <--". The syntax for creating objects with dynamic keys inside filters is unclear.

**Why it was an issue:** The documentation shows basic `merge` examples but doesn't clearly explain how to construct objects with dynamic keys or that `set` is the preferred way to update a single key in an object.

**Potential solution (if known):** 
1. Document that `set` should be used for updating individual object properties: `$obj|set:"key":value`
2. Provide examples of dynamic key usage in the object filters section
3. Clarify the difference between `merge` (for merging two objects) and `set` (for setting a property)

---

## [2025-02-21 10:07 PST] - Issue: Object.keys function syntax not obvious

**What I was trying to do:** Get all keys from an object to iterate over them.

**What the issue was:** I tried `$freq_map|keys` which didn't work. I discovered I needed to use the statement-level function: `object.keys { value = $freq_map } as $keys`.

**Why it was an issue:** The documentation mentions `keys` as an object filter, but using it as a filter on an object variable didn't work as expected. The distinction between filter syntax and statement-level function syntax for objects wasn't immediately clear.

**Potential solution (if known):** 
1. Clarify in the docs that `keys` and `values` as filters work differently than `object.keys` and `object.values` functions
2. Show examples of both approaches with clear use cases for each

---

## [2025-02-21 10:08 PST] - Issue: Foreach loop syntax with 'each' keyword

**What I was trying to do:** Iterate over arrays using foreach loops.

**What the issue was:** The syntax `foreach ($array) { each as $item { ... } }` feels unusual compared to other languages. I initially expected something like `foreach ($array as $item) { ... }`.

**Why it was an issue:** While not a blocker (the docs are clear), it's a cognitive overhead when coming from other languages. I had to double-check the syntax multiple times.

**Potential solution (if known):** This is more of a language design note than a documentation issue. The current syntax works fine once learned, but the `each as` structure is unique to XanoScript.

---

## [2025-02-21 10:09 PST] - General Feedback: Documentation is Good!

**Positive note:** The full syntax documentation is comprehensive and well-organized. Once I found the right sections, I was able to fix my issues quickly. The quick reference is useful for common patterns, and the full reference has the details needed for complex operations.

**The validation tool is excellent** - it caught my errors immediately with clear line/column positions and helpful messages. This made the iterative development process much smoother.
