# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 21:35 PST] - Documentation Structure is Excellent

**What I was trying to do:** Write a XanoScript function and run job for the "Rotate Image" matrix rotation exercise.

**What the experience was:** The `xanoscript_docs` tool provided excellent documentation with clear examples. Having both `quick_reference` and `full` modes is very helpful for context management.

**Why it was helpful:** 
- The quickstart guide had a comprehensive "Common Mistakes" section that addressed many syntax gotchas
- The examples showed proper patterns like `elseif` vs `else if`, parentheses around filtered expressions, and `params` vs `body` for API requests
- The function and run job documentation was clear about structure and required properties

---

## [2026-02-21 21:36 PST] - Array/Object Manipulation Syntax Could Be Clearer

**What I was trying to do:** Implement matrix rotation which requires accessing and updating nested array elements (matrix[row][col]).

**What the issue was:** The documentation covers filters like `get` and `set` for objects, but working with nested arrays (2D arrays/matrices) wasn't explicitly covered. I had to infer the syntax from object manipulation patterns.

**Why it was an issue:** When implementing matrix operations, I needed to:
1. Access elements: `$result[$first][$i]` - this worked
2. Update nested arrays - the syntax for `set` with nested arrays wasn't clear

The pattern I used was:
```xs
var.update $result {
  value = $result|set:$first:($result|get:$first|set:$i:$newValue)
}
```

This is verbose and might not be the most efficient way.

**Potential solution:** 
- Add a dedicated section on "Array/Object Manipulation" with examples for:
  - Accessing nested array elements
  - Updating values in 2D arrays/matrices
  - Common matrix operation patterns

---

## [2026-02-21 21:37 PST] - While Loop Variable Update Syntax

**What I was trying to do:** Use a while loop to iterate through matrix layers and elements.

**What the issue was:** I needed to increment counters like `var.update $layer { value = $layer + 1 }`. The documentation mentions `var.update` but doesn't show many loop iteration examples.

**Why it was an issue:** It's not immediately obvious that `var.update` is the correct way to mutate loop counters. I found it in the quickstart examples, but a dedicated "Loops" section would be helpful.

**Potential solution:**
- Add a "Loops and Iteration" section to the quickstart with:
  - While loop patterns with counter increment
  - foreach patterns for arrays
  - Common iteration patterns (for i=0 to n, etc.)

---

## [2026-02-21 21:38 PST] - Matrix/2D Array Type Considerations

**What I was trying to do:** Define the matrix input parameter with an appropriate type.

**What the issue was:** There's no specific "array of arrays" or "matrix" type. I used `json` which works, but doesn't provide type safety for the nested structure.

**Why it was an issue:** For matrix operations, it would be nice to have:
- Type validation that ensures the input is actually a 2D array
- Constraints like "square matrix" (n x n)

**Potential solution:**
- Document how to handle 2D array/matrix inputs
- Consider if there's a way to validate array dimensions
- Show examples of validating nested array structures in preconditions

---

## [2026-02-21 21:39 PST] - MCP Tool Works Great Overall

**What I was trying to do:** Validate XanoScript code.

**What the experience was:** The `validate_xanoscript` tool worked perfectly. It provided clear, actionable error messages.

**Positive feedback:**
- Fast validation response
- Clear pass/fail indication
- The ability to validate by file_path is much easier than escaping code strings
- Batch validation with file_paths would be useful for CI/CD

---

## Summary

The Xano MCP and XanoScript documentation were sufficient to complete this exercise successfully on the first try. The main areas for improvement are:

1. **More examples for array manipulation**, especially 2D arrays/matrices
2. **Dedicated loops section** with common iteration patterns
3. **Matrix/array validation patterns** for complex data structures
