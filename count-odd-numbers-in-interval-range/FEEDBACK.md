# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 12:05 PST] - Run Job Syntax Confusion

**What I was trying to do:** Create a run.job that calls a function multiple times with different test inputs, as specified in the task requirements ("A `run.job` that uses `function.run` to call the solution function with test inputs").

**What the issue was:** The task description suggests using `function.run` inside the run.job, but run.job does not support a `stack` block or direct `function.run` calls. The correct run.job syntax only allows:
- `main = { name: "...", input: {...} }` 
- `env = [...]`

Attempting to use `stack { function.run ... }` inside run.job causes validation errors.

**Why it was an issue:** This caused confusion because:
1. The task explicitly states the run job should use `function.run` to call the solution function
2. Looking at existing exercises, some (like `candy/run.xs`) appear to use this pattern but actually use INVALID syntax that doesn't validate
3. Valid exercises like `fizzbuzz/run.xs` and `two-sum/run.xs` only call a single test case via `main = {...}`

**Potential solution:** 
- Update the task description to clarify that run.job cannot contain `function.run` directly
- Or provide a template showing the wrapper function pattern (run.job → test function → multiple function.run calls)
- The candy example should be fixed or removed as it uses invalid syntax

---

## [2025-03-01 12:08 PST] - MCP Validation Tool Works Well

**What I was trying to do:** Validate XanoScript files after making changes.

**What the issue was:** None - the validation tool worked perfectly.

**Why it was helpful:** The error messages were clear and included line/column numbers. The suggestions for common mistakes in the documentation were also helpful.

**Positive feedback:** The `validate_xanoscript` tool with `directory` parameter made it easy to validate all files at once. The error messages were specific enough to diagnose the syntax issues quickly.

---

## [2025-03-01 12:10 PST] - Documentation Discovery

**What I was trying to do:** Find the correct syntax for run.job.

**What the issue was:** Had to call `xanoscript_docs` multiple times with different topics to piece together the correct syntax.

**Why it was an issue:** The quick_reference mode for run documentation was too minimal - it only showed the directory structure without the actual syntax for run.job.

**Potential solution:** 
- Include the complete `run.job` and `run.service` syntax examples in the quick_reference mode
- Or provide a code example directly in the quick reference showing the `main = { name: "...", input: {...} }` pattern

---

## Summary

The Xano MCP tools worked well overall. The main friction points were:
1. Task description didn't match the actual valid syntax for run.job
2. Some existing examples in the repo use invalid syntax (candy/run.xs)
3. Quick reference documentation was too minimal for run jobs

The validation tool was excellent - clear error messages with line numbers made debugging fast.