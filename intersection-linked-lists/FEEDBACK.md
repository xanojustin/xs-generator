# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 14:05 PST] - Lambda/Arrow Function Syntax Not Supported

**What I was trying to do:** Create a helper function within the stack to calculate linked list length, similar to helper functions in other languages.

**What the issue was:** I attempted to use `->($node) { ... }` lambda syntax which I thought might exist based on general programming knowledge, but XanoScript doesn't support inline/lambda functions.

**Why it was an issue:** The validation error was clear (`Expected an expression but found: '-'`), but I had to look up the documentation to confirm that lambdas aren't supported. This required rewriting the logic to be inline.

**Potential solution:** 
- Document this limitation clearly in the quickstart guide
- Consider adding support for simple inline functions, or
- Provide a clearer error message suggesting to inline the logic

---

## [2026-02-22 14:08 PST] - Nullable Object Type Syntax Confusing

**What I was trying to do:** Define an input parameter that could be either an object or null (for a linked list node's `next` pointer).

**What the issue was:** I used `object? next { ... }` following the pattern from other nullable types, but this syntax is invalid for objects.

**Why it was an issue:** The error message was actually very helpful: `💡 Suggestion: Use "json" instead of "object"`. However, it wasn't clear why `object?` doesn't work when `text?` and `int?` do.

**Potential solution:**
- Document that `object?` nullable syntax is not supported
- Explain when to use `json` vs `object` types
- Consider supporting `object?` for consistency with other types

---

## [2026-02-22 14:12 PST] - Deeply Nested Object Literals Cause Parse Errors

**What I was trying to do:** Create test data in `run.xs` with deeply nested object literals representing a linked list with shared references.

**What the issue was:** The parser failed with `Expecting: Expected an object {} but found: '{'` when I tried to use nested objects like:
```xs
head_a: {
  val: 4
  next: {
    val: 1
    next: {
      ...
    }
  }
}
```

**Why it was an issue:** The error message was not descriptive of the actual problem. I had to experiment with simpler structures to discover that:
1. The nesting level was causing issues
2. JSON can't represent shared references anyway (needed for intersection)

**Potential solution:**
- Document the recommended linked list representation (array-based with index pointers)
- Provide a clearer error message for nesting limits
- Add an example of linked list test data in the run job documentation

---

## [2026-02-22 14:15 PST] - File Path Parsing Issue with Multiple Files

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated values.

**What the issue was:** The MCP incorrectly parsed the comma-separated string, treating each character as a separate file path:
```
Validated 146 file(s): 0 valid, 146 invalid
File not found: U
File not found: s
File not found: e
...
```

**Why it was an issue:** This appears to be a bug in how the MCP parses the `file_paths` array parameter from the CLI. I had to validate files individually.

**Potential solution:**
- Fix the array parameter parsing in the MCP
- Or document that files should be validated one at a time

---

## [2026-02-22 14:18 PST] - Discovering Linked List Pattern from Other Exercises

**What I was trying to do:** Find the correct way to represent linked lists in XanoScript for the run job test data.

**What the issue was:** There was no documentation about linked list representations. I had to discover by looking at existing exercises (`merge-two-sorted-lists`, `linked-list-reversal`) that the convention is:
- Arrays of objects with `value`/`val` and `next` properties
- `next` is an integer index, not a nested object
- Separate `head` or `head_index` parameter

**Why it was an issue:** Without looking at existing code, I would have had to discover this through trial and error.

**Potential solution:**
- Document common data structure patterns (linked lists, trees, graphs)
- Create a "patterns" or "cookbook" section in the documentation
- Provide helper functions for common data structures

---

## General Feedback

### Positive
- The validation tool is fast and provides line/column information
- Error suggestions (like "Use json instead of object") are helpful
- Documentation via `xanoscript_docs` is comprehensive

### Areas for Improvement
1. **Syntax documentation:** Some syntax patterns are only discoverable through existing examples
2. **Error messages:** Some errors are cryptic until you understand the parser's expectations
3. **Data structure patterns:** Common patterns (linked lists, trees) should be documented
4. **Test data format:** The run job input format limitations should be clearer
