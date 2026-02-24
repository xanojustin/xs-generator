# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-24 02:00 PST - MCP Parameter Parsing Issue

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The mcporter call with JSON syntax didn't work correctly. I tried multiple approaches:
```bash
# This failed with "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"
mcporter call xano validate_xanoscript '{"directory": "/Users/justinalbrecht/xs/sort-list"}'

# This also failed with the same error
mcporter call xano validate_xanoscript '{"file_path": "/Users/justinalbrecht/xs/sort-list/run.xs"}'
```

The issue was that the JSON wasn't being parsed correctly by mcporter.

**Why it was an issue:** This blocked validation until I found the correct syntax through trial and error.

**Potential solution:** The working syntax uses key=value format instead of JSON:
```bash
mcporter call xano validate_xanoscript file_path="/Users/justinalbrecht/xs/sort-list/run.xs"
```

It would be helpful if the documentation showed examples of the correct mcporter call syntax, or if JSON format was also accepted.

---

## 2025-02-24 02:00 PST - Documentation Returns Same Content for Different Topics

**What I was trying to do:** Get specific documentation for different topics (quickstart, functions, run, syntax)

**What the issue was:** Calling `xanoscript_docs` with different topic parameters returned the same index/overview content each time:
```bash
mcporter call xano xanoscript_docs '{"topic": "quickstart"}'
mcporter call xano xanoscript_docs '{"topic": "functions"}'
mcporter call xano xanoscript_docs '{"topic": "run"}'
mcporter call xano xanoscript_docs '{"topic": "syntax"}'
```

All returned the same general documentation instead of topic-specific content.

**Why it was an issue:** I couldn't access detailed syntax documentation to verify specific language constructs. I had to rely on studying existing code examples in the repository instead.

**Potential solution:** 
1. Fix the topic filtering in the documentation function
2. Or provide a note that the general documentation is all that's available and recommend studying existing examples
3. Add a `cheatsheet` mode that returns compact syntax examples

---

## 2025-02-24 02:00 PST - No Issues With XanoScript Syntax

**What I was trying to do:** Write a complex algorithm (merge sort on linked list) in XanoScript

**What the issue was:** None - the syntax was clear after studying existing examples

**Why it was NOT an issue:** The existing implementations in the repository (particularly `merge-sort` and `merge-two-sorted-lists`) provided excellent patterns to follow. Key patterns learned:

1. **Recursion via `function.run`:** XanoScript supports recursion by calling functions within the stack
2. **JSON object manipulation:** Using `|get:`, `|set:`, `|append:` filters for linked list operations
3. **Conditional blocks:** Clear if/elseif/else structure
4. **While loops:** Standard while with `each` block for the loop body
5. **Variable scoping:** Variables defined in `each` blocks are scoped to that block

**Positive feedback:** The language is quite expressive and the patterns are consistent once you see a few examples.

---

## 2025-02-24 02:00 PST - Linked List Representation

**What I was trying to do:** Understand how to represent linked lists in XanoScript

**What the issue was:** Initially unclear how linked lists should be structured for these exercises

**Why it was an issue:** The documentation doesn't describe the linked list representation convention.

**What I learned from existing code:**
```json
{
  "nodes": [
    { "value": 4, "next": 1 },   // next is the INDEX of the next node
    { "value": 2, "next": 2 },
    { "value": 1, "next": null } // null indicates end of list
  ],
  "head_index": 0  // index of the head node
}
```

**Potential solution:** Add a note in the documentation about common data structure representations used in exercises (linked lists, trees, graphs).
