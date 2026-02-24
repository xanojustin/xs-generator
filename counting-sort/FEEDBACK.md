# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 23:30 PST] - Issue: Backtick Syntax in Conditionals

**What I was trying to do:** Check if the input array is empty using a conditional statement with a filter.

**What the issue was:** I wrote `if ($input.arr|count == 0)` which failed validation with the error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The syntax for conditionals that involve filters wasn't immediately clear from the quick reference. The error message suggested using parentheses, but the actual fix required backticks (`` `...` ``) around the expression.

**Potential solution (if known):** The documentation could be clearer about when to use backticks vs regular parentheses in conditionals. The quick reference shows:
```xs
conditional {
  if (`$status == "active"`) {
```
But it doesn't explain *why* backticks are needed vs bare expressions or regular parentheses.

**Suggestion:** Add a note in the quickstart or syntax documentation explaining:
- Backticks (`` `...` ``) are required when the expression contains filters or operators
- Bare expressions work for simple variable access
- Regular parentheses are for grouping, not for conditional expressions

---

## [2026-02-23 23:32 PST] - Success: Clear Run Job Structure

**What I was trying to do:** Understand how to structure a run job that calls a function.

**What worked well:** The run job documentation was very clear about the structure:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { key: value }
  }
}
```

**Why it helped:** The examples in the documentation directly translated to working code. The separation between `run.job` and the actual `function` implementation was easy to understand.

**No changes needed** - this part of the documentation is excellent.
