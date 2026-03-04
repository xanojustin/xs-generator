# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-04 03:45 PST] - Bitwise Operator Syntax Unclear

**What I was trying to do:** Implement a bitwise OR operation (`|`) to combine two integers

**What the issue was:** Initially wrote `$prev_or | $current_num` directly, but the parser interpreted `|` as a filter pipe operator instead of bitwise OR

**Why it was an issue:** The validation failed with "Expecting token of type --> Identifier <-- but found --> '$current_num'"

**Solution discovered:** After looking at the fizzbuzz example, I noticed that expressions like `$i % 15 == 0` are wrapped in backticks. I applied the same pattern: `` `$prev_or | $current_num` `` which validated successfully.

**Potential solution:** The documentation should explicitly mention:
1. That backticks are needed for bitwise operations
2. A list of which operators require backtick expression syntax vs which can be used inline
3. Examples showing `+`, `-`, `*`, `/`, `%`, `|`, `&`, `^` operators in context

---

## [2026-03-04 03:45 PST] - Documentation Request: Set/Deduplication Operations

**What I was trying to do:** Deduplicate an array of integers to simulate a "set" data structure

**What the issue was:** XanoScript doesn't appear to have a built-in `unique` or `deduplicate` filter for arrays. I had to implement manual deduplication using nested loops.

**Why it was an issue:** The algorithm became verbose and less efficient - O(n²) instead of O(n) for deduplication.

**Workaround used:** Nested for loops checking if each element already exists in the result array before adding it.

**Potential solution:** Consider adding a `unique` filter for arrays (e.g., `$array|unique`) or a set data type.

---

## [2026-03-04 03:45 PST] - Documentation Request: Array Value Lookup

**What I was trying to do:** Access a single element from an array at a specific index

**What the issue was:** The syntax `$array[$index]` doesn't work in XanoScript. I had to use `$array|slice:$index:1|first` which is verbose.

**Why it was an issue:** Made the code more complex than necessary, especially in nested loops.

**Workaround used:** The slice+first pattern works but is not intuitive.

**Potential solution:** Consider adding:
1. A direct index access syntax like `$array[$index]` or `$array|at:$index`
2. Better documentation of the `slice` filter for single element access

---

## [2026-03-04 03:45 PST] - Positive Feedback: Validation Tool

**What worked well:** The `validate_xanoscript` tool with the `directory` parameter made it easy to validate both files at once.

**Why it matters:** For multi-file exercises, this is much more convenient than validating files individually.

---
