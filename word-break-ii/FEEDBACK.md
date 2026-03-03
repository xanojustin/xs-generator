# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 07:05 PST] - Missing run.job documentation in quick reference mode

**What I was trying to do:** Create a run.job that executes multiple test cases and logs results

**What the issue was:** The quick reference documentation for `run` topic only showed the directory structure without any syntax details:
```
# run
## Quick Reference
| Type | Purpose | Lifecycle |
...
### Directory Structure
```

There was no information about:
- The `main` property required for run.job
- The correct syntax structure
- The fact that `description` and `execute` blocks are not valid

**Why it was an issue:** I assumed run.job would work like function with a description and an execute/stack block, but the syntax is completely different. The run.job uses `main` to point to a function, rather than containing logic directly.

**Potential solution:** Include the basic syntax pattern in the quick reference mode, at least showing:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { key: value }
  }
}
```

---

## [2025-03-03 07:08 PST] - Filter precedence confusion with parentheses

**What I was trying to do:** Write array length checks and string operations using filters

**What the issue was:** I initially wrote code like `$arr|count > 0` which the documentation says is wrong, but I forgot to wrap in parentheses in some places initially.

**Why it was an issue:** The filter binds greedily to the left, so `$arr|count == 0` is parsed as `$arr | (count == 0)` which is invalid.

**Potential solution:** The documentation is clear about this in the `syntax` topic, but maybe a linter warning or better error messages could help. The current error message doesn't clearly indicate that parentheses are needed around filtered expressions.

---

## [2025-03-03 07:10 PST] - No nested function support requires workaround

**What I was trying to do:** Implement recursive backtracking for Word Break II

**What the issue was:** XanoScript doesn't support nested function definitions, so I couldn't write a helper recursive function inside the main function. I had to convert the recursive algorithm to an iterative one using an explicit stack.

**Why it was an issue:** For backtracking problems, recursion is the natural and most readable approach. The iterative DFS with manual stack management is more verbose and harder to understand.

**Potential solution:** Document this limitation clearly in the essentials documentation, or consider adding support for nested functions or some form of recursion. The current workaround (iterative with explicit stack) works but is less intuitive.

---

## [2025-03-03 07:15 PST] - Empty input block syntax confusion

**What I was trying to do:** Create a function with no inputs for the test runner

**What the issue was:** Initially I wrote `input { }` on one line but the documentation says braces must be on separate lines for empty input blocks.

**Why it was an issue:** The syntax requirement is specific and easy to miss. The error message wasn't clear about needing newlines.

**Potential solution:** Either allow `input { }` on one line or provide a clearer error message indicating the brace positioning requirement.

---
