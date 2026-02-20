# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-20 15:05 PST - Major syntax differences from assumptions

**What I was trying to do:** Create a run.job that calls a function and a function that solves the unique paths problem.

**What the issue was:** My initial assumptions about XanoScript syntax were completely wrong. I assumed:
1. `run.job` would have `description` and `stack` like functions
2. `run.job` would use `function.run` inside a stack
3. Conditional blocks used `condition` keyword
4. Loops used `loop` with a condition

All of these assumptions were incorrect.

**Why it was an issue:** The validation failed with cryptic errors like "'description' is not valid in this context" and "Expecting '}' but found 'condition'". Without the MCP docs, I would have been completely stuck.

**Potential solution:** The MCP's `xanoscript_docs` tool saved me here. Perhaps the validation error messages could suggest the correct syntax or link to relevant documentation topics.

---

## 2025-02-20 15:10 PST - Run.job structure is very different from functions

**What I was trying to do:** Write a run.job that runs multiple test cases and logs results.

**What the issue was:** The run.job syntax is completely different from functions. It doesn't have a stack or description. It only has `main = { name: "...", input: {...} }` which calls a single function once. There's no way to run multiple test cases, log intermediate results, or collect outputs in a run.job definition.

**Why it was an issue:** The exercise requirements asked for a run.job that "calls the solution function with test inputs and returns/logs the result" but the actual run.job structure only supports calling ONE function with ONE set of inputs. I had to significantly simplify my run.xs to just call the function with a single test case.

**Potential solution:** This may be a documentation vs. reality mismatch. Either:
1. The run.job syntax needs to support more complex workflows (multiple calls, logging, etc.)
2. The exercise requirements should be updated to match what run.jobs actually support
3. There should be a different mechanism for test runners that supports multiple invocations

It would also help if the docs clearly stated what run.job CAN'T do, not just what it can do.

---

## 2025-02-20 15:12 PST - Range operator syntax is inconsistent

**What I was trying to do:** Create loops to iterate over a range of numbers.

**What the issue was:** The documentation showed `(1..5)` for ranges, but I had to figure out that:
1. The range operator needs parentheses around it: `((0..($cols - 1)))`
2. The foreach requires double parentheses when using a dynamic range: `foreach ((1..($rows - 1)))`

**Why it was an issue:** Initially I tried `loop` which doesn't exist, then tried `foreach (0..$cols)` which had syntax errors. Took a few attempts to get the nesting of parentheses right.

**Potential solution:** More examples in the docs showing dynamic ranges with variables like `foreach ((0..($n - 1)))` would be helpful.

---

## 2025-02-20 15:15 PST - Expressions in conditionals require backticks

**What I was trying to do:** Write a conditional check with a compound boolean expression.

**What the issue was:** The `if` statement in a conditional block requires backticks for expressions: `if (`$rows <= 0 || $cols <= 0`)`. Without the backticks, it doesn't parse.

**Why it was an issue:** The docs mention expressions use backticks but it's easy to miss that this applies to conditional expressions too. First attempt without backticks failed.

**Potential solution:** A more prominent note in the conditional section about requiring backticks for expressions would help. The error message "unexpected token" wasn't very helpful in identifying this.

---

## General Feedback

**MCP Tool Experience:** The `xanoscript_docs` tool is essential and works well. However, the "quick_reference" mode is too terse to learn from - I needed the "full" mode to understand the syntax properly. The quick reference is good as a reminder but not for learning.

**Validation Tool:** The validation tool gives good line/column information but the error messages could be more helpful. For example:
- Instead of "'description' is not valid in this context", maybe: "run.job does not support 'description'. Use 'main' to specify the function to run."
- Instead of "Expecting '}' but found 'condition'", maybe: "Unknown keyword 'condition'. Did you mean 'conditional'?"

**Learning Curve:** XanoScript has some unique syntax choices that differ significantly from other languages (backticks for expressions, `~` for concat, `:` instead of `=` in object literals for run.job). Having a "XanoScript for JavaScript/Python developers" guide would help.
