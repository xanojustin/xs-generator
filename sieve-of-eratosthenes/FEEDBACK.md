# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 10:05 PST] - Missing array index filters

**What I was trying to do:** Implement the Sieve of Eratosthenes algorithm using an array to track prime numbers, where array indices represent the numbers and values represent whether they're prime.

**What the issue was:** I assumed XanoScript would have `set_index` and `get_index` filters for arrays (similar to how objects have `get` and `set`). The validation failed with "Unknown filter function 'set_index'" and "Unknown filter function 'get_index'".

**Why it was an issue:** I had to completely refactor my approach from using an array to using an object with string keys. This changed:
- Array initialization from `for` loop with `append` to `while` loop with `set`
- Index access from numeric indices to string-converted keys (`$idx|to_text`)
- The mental model of the data structure

**Potential solution:** 
1. Add `set_index` and `get_index` filters for arrays to allow direct index manipulation
2. Or improve documentation to clearly state that objects should be used when you need to set/get by key/index

---

## [2025-02-20 10:06 PST] - Documentation search took multiple calls

**What I was trying to do:** Find the correct syntax for array and object operations.

**What the issue was:** The documentation for `xanoscript_docs` is quite large. I had to make multiple calls to get different topics (quickstart, functions, run, syntax). The syntax documentation alone is very long and I had to truncate it to find relevant array filters.

**Why it was an issue:** It took several attempts to understand:
- That arrays don't have index-based set/get filters
- That objects have `get`/`set` filters but arrays don't
- The difference between array filters and array functions

**Potential solution:** 
1. Provide a more concise "cheatsheet" or "quick reference" topic that focuses on common data structure operations
2. Add an index or search capability to the documentation

---

## [2025-02-20 10:07 PST] - While loop variable scope

**What I was trying to do:** Use a `while` loop to iterate through numbers for the sieve algorithm.

**What the issue was:** Initially I wasn't sure if the `each` block was required inside `while` or just for `for`/`foreach` loops.

**Why it was an issue:** The documentation shows `while` loops with `each` blocks, but it's not immediately clear if this is required for simple iteration or just when you want to process each item.

**Potential solution:** 
1. Clarify in the documentation when `each` is required vs optional inside loops
2. Provide examples of simple counter-based while loops

---