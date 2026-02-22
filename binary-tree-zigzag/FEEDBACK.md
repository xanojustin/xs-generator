# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 22:05 PST] - Nullable object schema syntax unclear

**What I was trying to do:** Define a recursive binary tree node structure with optional left/right children in the input block.

**What the issue was:** I tried to use `object? left { schema { ... } }` to define a nullable nested object with a schema, but the parser rejected it with "Expecting token of type --> Identifier <-- but found --> '?'".

**Why it was an issue:** The documentation shows how to use `text?` for nullable strings and `object` for nested objects, but doesn't clearly explain how to combine them. I assumed `object?` would work like `text?` or `int?`.

**Potential solution:** 
- The error message suggesting "Use 'json' instead of 'object'" was helpful, but it would be clearer if the docs explicitly stated: "For nullable/recursive nested structures, use `json` type instead of `object` with schema"
- Consider adding an example of a tree/node structure to the functions documentation

---

## [2025-02-21 22:08 PST] - Filter expressions need parentheses in conditionals

**What I was trying to do:** Check if a queue has items using `$queue|count > 0` in a while loop condition.

**What the issue was:** The parser complained "An expression should be wrapped in parentheses when combining filters and tests".

**Why it was an issue:** The quickstart docs mention "parentheses around filters in expressions" in the TL;DR, but I missed it. The exact syntax `($queue|count) > 0` wasn't immediately obvious from the error message alone.

**Potential solution:**
- The error message is actually pretty good, but could include the corrected code example
- Add a specific example to the quickstart showing filter usage in while/if conditions: `while (($items|count) > 0)`

---

## General Observations

**Good:**
- The `validate_xanoscript` tool is fast and gives clear line numbers
- Error messages include the actual code that failed
- Suggestions (like "Use json instead of object") are actionable

**Could be improved:**
- Documentation about input schema for recursive structures (trees, linked lists) is sparse
- More examples of BFS/queue-based algorithms would help
