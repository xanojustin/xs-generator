# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 15:05 PST] - Issue: object_hash filter does not exist

**What I was trying to do:** Create a unique key for each node in a binary tree to store heights in a map during post-order traversal.

**What the issue was:** I assumed there was an `object_hash` filter that could generate a unique identifier for an object, similar to `object_id` or hash functions in other languages. The validation failed with "Unknown filter function 'object_hash'".

**Why it was an issue:** Without a way to uniquely identify nodes, I had to resort to using node values as keys, which assumes unique values in the tree. This is a limitation for trees with duplicate values.

**Potential solution:** 
- Document which filter functions are available (a cheatsheet of all filters would be helpful)
- Consider adding an `object_hash` or `object_id` filter for creating unique identifiers
- Alternatively, provide a `json_hash` or similar filter

---

## [2026-02-21 15:15 PST] - Issue: Comments inside run.job input blocks cause parser errors

**What I was trying to do:** Add inline comments within the `input:` block of a `run.job` to document the test case structure.

**What the issue was:** When I added comments like:
```xs
input: {
  // Test Case 1: Balanced tree
  //      3
  //     / \
  root: { ... }
}
```
The validator reported: "Expecting: Expected an object {} but found: '{'" pointing to the `input:` line.

**Why it was an issue:** This was confusing because:
1. Comments are documented as using `//` syntax
2. The error message didn't indicate it was a comment issue
3. Comments work fine at the top of the file
4. The ASCII art tree diagram may have had special characters

**What I tried:**
- First I removed all comments entirely - that worked
- Then I added back just top-level comments - that worked  
- Then I tried adding a simple comment inside input block - that FAILED

**Potential solution:**
- Document clearly that comments inside `input:` blocks of run jobs are not supported
- Or fix the parser to handle comments in this context
- Provide a better error message like "Comments not allowed in this context"

---

## [2026-02-21 15:08 PST] - Issue: Difficult to discover available filters

**What I was trying to do:** Find a list of all available filter functions.

**What the issue was:** The `xanoscript_docs` with topic `syntax` returns general documentation but I couldn't easily find a comprehensive list of all filters.

**Why it was an issue:** When writing code, I need to know what filters are available. I had to guess `object_hash` existed and then discovered it didn't through validation errors.

**Potential solution:**
- Add a `xanoscript_docs({ topic: "filters" })` that lists all available filters with descriptions
- Or include a comprehensive filter reference in the syntax documentation

---

## General Feedback

**Positive:**
- The validation tool is very helpful with clear error messages (line/column numbers)
- The MCP server is responsive
- Directory-level validation is convenient

**Suggestions:**
1. A "filters" topic in xanoscript_docs would be invaluable
2. Clearer documentation on where comments are/aren't allowed
3. Consider adding more filters for object manipulation (hash, unique id, etc.)
