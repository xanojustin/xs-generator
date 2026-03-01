# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 19:10 PST] - function.run syntax confusion

**What I was trying to do:** Call a helper function from within another function using `function.run`

**What the issue was:** I incorrectly used the syntax:
```xs
function.run {
  name = "function_name"
  input = { ... }
}
```

**Why it was an issue:** This syntax is invalid. The correct syntax is:
```xs
function.run "function_name" {
  input = { ... }
} as $result
```

**Potential solution:** The documentation could include a clear example of `function.run` syntax in the essentials or functions topic.

---

## [2025-02-28 19:12 PST] - Multiple functions in one file

**What I was trying to do:** Define a helper function in the same file as the main function

**What the issue was:** I initially tried to put both `function "minesweeper"` and `function "reveal_cell"` in the same `minesweeper.xs` file

**Why it was an issue:** The validation error said "Expecting: one of these possible Token sequences" which wasn't immediately clear that it was rejecting a second function definition. The documentation states "Each `.xs` file must contain exactly one definition" but I forgot this constraint.

**Potential solution:** A more specific error message like "Only one function definition allowed per file" would help. Also, the documentation is clear about this but easy to miss.

---
