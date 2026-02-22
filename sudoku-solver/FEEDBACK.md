# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-22 14:35 PST - Issue: Nested array type syntax not supported

**What I was trying to do:** Define a 2D array input parameter for the Sudoku board

**What the issue was:** I initially wrote `int[][] board` which caused a parse error: "Expecting token of type --> Identifier <-- but found --> '['"

**Why it was an issue:** XanoScript doesn't support nested array type declarations like `int[][]`. This is a common pattern in many languages so it was surprising it wasn't supported.

**Potential solution:** Either support `int[][]` syntax or provide clearer documentation that complex arrays should use `json` type. I found the solution by looking at existing code (rotate-image used `json matrix`).

---

## 2025-02-22 14:40 PST - Issue: Functions cannot be nested inside other functions

**What I was trying to do:** Define helper functions (`is_valid`, `find_empty`, `solve`) inside the main `sudoku_solver` function's stack block

**What the issue was:** Got error: "Expecting: one of these possible Token sequences... but found: 'function'" - nested function definitions aren't allowed

**Why it was an issue:** Many languages support nested functions for encapsulation. I had to restructure into separate files which is more verbose but works.

**Potential solution:** Document this restriction clearly. The error message was helpful but it took trial and error to understand. Alternatively, support nested functions would be nice for organization.

---

## 2025-02-22 14:45 PST - Issue: `response` cannot be used inside conditional blocks

**What I was trying to do:** Return early from a function inside an if statement: `if (!found) { response = {solved: true} }`

**What the issue was:** Parser expected `}` but found `response` - response assignments must be at the end of the stack block, not inside conditionals

**Why it was an issue:** This is different from most programming languages where you can return from anywhere. I had to restructure to use result variables that get set in conditionals, then assign response at the end.

**Potential solution:** Either support early returns (with `return` keyword) or document this pattern clearly. The `return` keyword exists (I saw it in rotate-image) but seems to work differently.

---

## 2025-02-22 14:50 PST - Issue: Array assignment syntax is non-obvious

**What I was trying to do:** Modify a 2D array: `$input.board[$row][$col] = $num`

**What the issue was:** Direct assignment isn't supported. The parser gave: "Expecting --> } <-- but found --> '$input'"

**Why it was an issue:** This is standard syntax in virtually every language. XanoScript requires using filter chains: `$board|set:$row:($board|get:$row|set:$col:$num)` which is verbose and unintuitive.

**Potential solution:** Support standard assignment syntax as syntactic sugar for the filter chain. Or at minimum, document this pattern prominently with 2D array examples.

---

## 2025-02-22 14:55 PST - Issue: MCP parameter passing is finicky

**What I was trying to do:** Call `validate_xanoscript` with the `file_paths` parameter as JSON

**What the issue was:** The MCP tool didn't recognize the JSON format. Had to use `directory:` syntax instead.

**Why it was an issue:** The tool description shows `file_paths?: string[]` as a parameter but I couldn't get it to work with JSON formatting.

**Potential solution:** Make parameter passing more robust or provide clear examples in the tool description.

---

## 2025-02-22 15:00 PST - Positive Feedback: Error messages are helpful

**What went well:** Once I understood the syntax, the validation tool gave clear line/column numbers and helpful error messages.

**Why it matters:** Good error messages made debugging much faster than it could have been.

---

## Summary

The main friction points were:
1. Type system limitations (no 2D array types)
2. Function organization restrictions (no nesting)
3. Control flow limitations (no early return)
4. Array mutation syntax (filter chains instead of assignment)

Most of these were solvable by looking at existing examples, but better documentation of these restrictions would help new developers.