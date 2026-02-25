# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 23:35 PST] - Filter precedence confusion with parentheses

**What I was trying to do:** Check if the input array is empty using `$input.nums|count == 0`

**What the issue was:** The validator reported "An expression should be wrapped in parentheses when combining filters and tests" for the line:
```xs
if ($input.nums|count == 0) {
```

**Why it was an issue:** The documentation mentions that filters bind greedily, but as a new XanoScript developer, it's not intuitive that `|count == 0` would be parsed incorrectly. I had to look up the syntax docs to understand that `($input.nums|count)` needs parentheses.

**Potential solution (if known):** 
- The error message could be more specific: "Wrap the filter expression in parentheses: `if (($input.nums|count) == 0)`"
- A linter warning or IDE hint could catch this pattern early

---

## [2026-02-24 23:37 PST] - Object manipulation syntax unclear

**What I was trying to do:** Build a frequency map (object) by merging key-value pairs into an existing object

**What the issue was:** I tried to use `|merge` filter with object syntax:
```xs
value = $freq|merge:{($num|to_text): 1}
```

This caused a parse error: "Expecting --> } <-- but found --> '(' <--"

**Why it was an issue:** I couldn't find clear documentation on how to dynamically set object properties. I had to look at existing exercise files (`first-unique-character`) to discover the correct pattern using `|set:key:value` and `|has:key` for checking existence.

**Potential solution (if known):**
- Add a "Working with Objects" section to the quickstart or cheatsheet documentation
- Document the `|set`, `|get`, and `|has` filters more prominently with object examples
- Include an example of building a frequency map/counter object as it's a common pattern

---

## [2026-02-24 23:30 PST] - No example of run.job calling a function with input

**What I was trying to do:** Create a run.job that calls a function with test inputs

**What the issue was:** The run.job documentation shows the structure, but I had to infer the correct syntax for passing array inputs. I wasn't sure if arrays should be passed as `[1, 2, 3]` or some other format.

**Why it was an issue:** Trial and error with validation is slow. A clear example of a run.job calling a function with various input types (array, object, primitives) would help.

**Potential solution (if known):**
- Add an example showing `input: { nums: [1, 2, 3, 2] }` in the run.job documentation
- Include a complete working example in the docs that validates successfully

---
