# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 23:32 PST] - Inline Comments Not Supported

**What I was trying to do:** Write a well-documented function with inline comments explaining the algorithm

**What the issue was:** Added a comment at the end of a line with code:
```xs
var $first {
  value = 2147483647  // Max int value
}
```

This caused a parse error: `but found: '/'` at the comment position.

**Why it was an issue:** The documentation says "XanoScript only supports `//` for comments" but doesn't clearly specify that inline comments (at the end of code lines) are not allowed. I assumed standard C-style comment behavior where `//` works anywhere on a line.

**Potential solution:** 
1. Update documentation to explicitly state: "Comments must be on their own lines. Inline comments at the end of code lines are not supported."
2. Or ideally, support inline comments as they're common in most programming languages

---

## [2025-03-02 23:33 PST] - Return vs Response Pattern Unclear

**What I was trying to do:** Understand the relationship between `return` in the stack block and `response` at the function level

**What the issue was:** Initially wrote code with both `return { value = ... }` inside the stack AND `response = ...` at the end. The documentation shows both patterns but doesn't clearly explain:
- Is `response` required if all paths use `return`?
- Does `return` exit the function or just the stack block?
- What's the interaction between `return` and `response`?

**Why it was an issue:** Unclear if having both is redundant or necessary. The examples show functions with only `response = $var` at the end, and others using `return` inside conditionals, but none show both together clearly.

**Potential solution:** Add documentation clarifying:
1. `response = $var` is always required at the end of a function
2. `return { value = ... }` exits the entire function early with that value
3. If `return` is used, it overrides/supersedes the `response` declaration
4. Show an example with both early `return` and final `response`

---

## General Feedback

**MCP Tool Working Well:**
- The `validate_xanoscript` tool is very helpful and provides clear error messages with line/column numbers
- The `xanoscript_docs` tool with topics is comprehensive and well-organized
- File path validation works correctly with absolute paths

**Documentation Quality:**
- The essentials doc with "Common Mistakes" section is excellent and prevented several errors
- The type system documentation is clear (text vs string, int vs integer, etc.)
- More examples of complete, working functions would be helpful
