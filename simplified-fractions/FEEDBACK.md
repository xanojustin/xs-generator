# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-03-01 01:03 PST - While Loop Syntax Confusion

**What I was trying to do:** Write a function with `while` loops to iterate through denominators and numerators for the simplified fractions exercise.

**What the issue was:** I initially wrote:
```xs
while ($d <= $input.n) {
  // code here
}
```

This failed validation with:
```
[Line 18, Column 29] Expecting --> each <-- but found --> '
' <---
```

**Why it was an issue:** The error message indicates that `each` is expected after a `while` condition, but this pattern wasn't clear from the syntax documentation I retrieved. The `syntax` topic documentation shows `while` loops in examples (like the complete job example) but doesn't explicitly document the requirement for `each { ... }` as the body.

**Potential solution:** 
1. The syntax documentation should explicitly document that `while` loops require an `each { ... }` block as their body
2. A clearer error message like "while loops require an 'each { ... }' block as their body" would be more helpful
3. A quick reference for loop constructs would be valuable

---

## 2026-03-01 01:05 PST - Documentation Discovery Process

**What I was trying to do:** Find the correct syntax for XanoScript constructs.

**What the issue was:** I had to look at existing exercises (fizzbuzz) to discover the correct `while` + `each` pattern. The `syntax` documentation retrieved via `xanoscript_docs` is comprehensive but doesn't clearly highlight the structure of loop constructs.

**Why it was an issue:** It's inefficient to require developers to examine existing code to discover basic language constructs. The documentation should be self-contained.

**Potential solution:**
1. Add a "Control Flow" or "Loops" section to the syntax documentation with clear examples of:
   - `while` loops with `each` blocks
   - `foreach` loops (if they exist)
   - Other iteration patterns

2. Consider adding a "Common Patterns" or "Language Constructs" topic that focuses on code structure rather than just filters.

---

## 2026-03-01 01:06 PST - Overall MCP Experience

**Positive feedback:**
- The `validate_xanoscript` tool is very helpful and provides specific line/column information
- The `xanoscript_docs` tool provides comprehensive documentation
- Having the MCP integrated with mcporter makes it easy to call from the command line

**Areas for improvement:**
1. **Syntax reference organization:** The documentation is comprehensive but could benefit from more structural/construction examples (not just filter references)
2. **Error messages:** While helpful, they could be more prescriptive (suggest the fix, not just identify the problem)
3. **Pattern examples:** More complete mini-examples showing how constructs fit together would be valuable
