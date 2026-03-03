# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 05:05 PST] - Object Creation Syntax Confusion

**What I was trying to do:** Create an object with multiple properties to return as the function result (a subset array and a size integer).

**What the issue was:** I incorrectly tried to use `var $result { subset = [], size = 0 }` syntax which is not valid XanoScript. The validator reported: `The argument 'subset' is not valid in this context`.

**Why it was an issue:** The documentation didn't clearly show how to create objects with the `var` declaration. I had to look at existing exercise code (specifically `design-tic-tac-toe`) to discover the correct syntax:
```xs
value = {
  board: $board,
  n: $size,
  current_player: 1
}
```

**Potential solution (if known):** The essentials documentation could include a clear example of object literal syntax, showing how to create objects with multiple properties for use in `return` statements or variable assignments.

---

## [2026-03-03 05:06 PST] - Array Initialization Pattern Uncertainty

**What I was trying to do:** Initialize a dp (dynamic programming) array with a specific value repeated n times.

**What the issue was:** I initially used a `while` loop with `merge:[1]` to build up the array, but wasn't sure if this was the idiomatic approach.

**Why it was an issue:** After looking at existing code, I discovered the `for ($n) { each as $i { ... } }` pattern combined with `array.push` or `|push:` filter which is cleaner.

**Potential solution (if known):** The documentation could benefit from a "Common Patterns" section showing:
1. How to initialize arrays with repeated values
2. The difference between `array.push`, `var.update` with `push:`, and `merge:`
3. When to use `for` vs `while` loops

---

## [2026-03-03 05:07 PST] - Return vs Response Pattern

**What I was trying to do:** Return early from a function for edge cases (empty input, single element).

**What the issue was:** I wasn't clear on the difference between `return { value = ... }` and `response = $result` at the end of the stack.

**Why it was an issue:** I initially had `response = $result` at the end but was using `return` for early exits. Looking at other examples, I see that:
- `return` is used for early exits with a value
- `response = $var` is used at the end to set the final response
- But if you use `return` for all exits (including at the end), you still need `response = $result` which seems redundant

**Potential solution (if known):** Clarify in documentation:
1. Is `response = $var` required even if all code paths use `return`?
2. What's the execution flow - does `return` immediately exit the function?
3. Can `response` be assigned conditionally, or must it always be at the end?

---

## [2026-03-03 05:08 PST] - Variable Update Syntax Inconsistencies

**What I was trying to do:** Update variables within loops (counters, arrays).

**What the issue was:** There appear to be multiple ways to update variables and it's not clear when to use each:
- `var.update $i { value = $i + 1 }`
- `math.add $col { value = 1 }`
- Direct reassignment with `var $i { value = $i + 1 }` (creates new var in scope?)

**Why it was an issue:** Different exercises use different patterns. The `spiral-matrix` example uses `math.add` and `array.push`, while `two-sum` uses `var.update` and `|set:` filter.

**Potential solution (if known):** A decision tree in the documentation:
- Use `var.update` when...
- Use `math.add`/`math.sub` when...
- Use filters like `|set:` and `|push:` when...
- When is each approach preferred?

---

## [2026-03-03 05:09 PST] - MCP Tool Parameter Format

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths.

**What the issue was:** The mcporter CLI syntax for passing array parameters was not intuitive. I initially tried several approaches:
- `mcporter call xano validate_xanoscript file_paths='[...]'` (didn't work)
- Various JSON formats

**Why it was an issue:** The error messages weren't helpful in indicating the correct format. I eventually found that `file_paths='["path1", "path2"]'` with single quotes around the whole thing works.

**Potential solution (if known):** Include examples in the MCP tool descriptions showing the exact mcporter CLI syntax for array and object parameters.

---

## [2026-03-03 05:10 PST] - Filter Parentheses Requirement

**What I was trying to do:** Compare the result of a filter operation.

**What the issue was:** The documentation mentions that filters bind greedily and you need parentheses, but I still made mistakes like `$input.nums|count == 0` instead of `($input.nums|count) == 0`.

**Why it was an issue:** It's easy to forget the parentheses, and the error messages don't always clearly indicate this is the problem.

**Potential solution (if known):** The validator could detect this common mistake and provide a specific suggestion: "Did you mean to wrap the filter in parentheses?"

---
