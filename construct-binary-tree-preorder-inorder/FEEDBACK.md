# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 15:05 PST] - Array Iteration Syntax Confusion

**What I was trying to do:** Iterate over an array to build a hashmap of value-to-index mappings for the inorder array.

**What the issue was:** I incorrectly assumed XanoScript had a foreach-style syntax like `each ($array as $item)`. The validator returned: `Expecting --> } <-- but found --> 'each' <--`

**Why it was an issue:** This is a common pattern in many languages (PHP, Twig, etc.), so it was an easy assumption to make. The documentation quick reference doesn't explicitly show how to iterate over arrays.

**Potential solution:** 
- Add a clear example in the quickstart docs showing the correct pattern for array iteration using `while` + index
- Consider adding a filter like `|each` or documenting the `each` block more explicitly
- The docs mention `each` as "iterates through the parent while loop" but don't show the common "for loop over array" pattern

---

## [2026-02-23 15:05 PST] - Discovered File Naming Convention

**What I was trying to do:** Name my function file following the pattern I inferred from the problem name.

**What the issue was:** Initially named the file `buildTree.xs` (camelCase), but looking at existing examples, they use `snake_case.xs` (e.g., `valid_parentheses.xs`, `merge_sorted_arrays.xs`).

**Why it was an issue:** Inconsistent naming could make the codebase harder to navigate. I had to rename the file after validation.

**Potential solution:**
- Document the naming convention explicitly in the skill documentation or README
- The prompt mentions naming patterns but doesn't explicitly state snake_case for files

---

## [2026-02-23 15:05 PST] - Missing Documentation on Array Operations

**What I was trying to do:** Add items to arrays and increment counters.

**What the issue was:** Didn't know about `array.push` and `math.add` operations. Initially used `merge` and manual `var.update`.

**Why it was an issue:** The quick reference documentation shows filters but not operations like `array.push`, `math.add`, etc. I had to discover these by reading existing example files.

**Potential solution:**
- Add a section to the quick reference showing common operations (array.push, math.add, etc.)
- Or document that users should look at existing examples in ~/xs/ for common patterns

---

## General Observations

**What worked well:**
- The MCP validator gives clear error messages with line/column numbers
- Having existing examples in ~/xs/ was invaluable for learning correct syntax
- The `file_path` parameter in validate_xanoscript is much easier than escaping code strings

**Suggestions for MCP improvement:**
1. Consider adding a `topic=cookbook` or `topic=patterns` to xanoscript_docs that shows common code patterns (iteration, recursion simulation, etc.)
2. The validation error could suggest the correct syntax when common mistakes are detected (e.g., "Did you mean to use 'while' with an index counter?" for invalid `each` usage)
