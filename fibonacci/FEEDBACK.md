# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 17:32 PST] - MCP Tool: Array parameter passing unclear

**What I was trying to do:** Validate multiple XanoScript files using the `validate_xanoscript` tool with the `file_paths` parameter

**What the issue was:** The mcporter CLI syntax for passing array parameters was not clear. I tried:
- `file_paths=~/xs/fibonacci/function/fibonacci.xs,~/xs/fibonacci/run.xs` - resulted in each character being treated as a separate file path
- `file_paths=/Users/justinalbrecht/xs/fibonacci/function/fibonacci.xs,/Users/justinalbrecht/xs/fibonacci/run.xs` - same issue

**Why it was an issue:** The comma-separated format doesn't work as expected. The tool was splitting on every character instead of treating the comma as a delimiter for array items.

**Potential solution:** Better documentation in the tool description about how to pass arrays via CLI, or support for comma-separated values properly. The `--args '{"file_paths":["...","..."]}'` JSON format worked but wasn't immediately obvious.

---

## [2025-02-19 17:35 PST] - XanoScript: run.job syntax confusion

**What I was trying to do:** Create a run.job that tests multiple inputs by calling a function multiple times with different parameters

**What the issue was:** I assumed run.job would use the same syntax as functions (with `description`, `stack`, `input`, `response`), but run.job uses a completely different structure with just `main = { name: "...", input: {...} }`

**Why it was an issue:** The documentation shows run.job examples but doesn't clearly contrast it with function syntax. I tried to use `stack` and `description` which are not valid in run.job context.

**Potential solution:** A side-by-side comparison in the run documentation showing "Function vs run.job syntax" would help. The error messages were helpful though - they clearly stated "'stack' is not valid in this context" which led me to re-read the docs.

---

## [2025-02-19 17:38 PST] - XanoScript: conditional block requirement unclear

**What I was trying to do:** Write early return guard clauses in a function using `if` statements

**What the issue was:** I wrote `if` directly inside the `stack` block, but XanoScript requires `if` to be inside a `conditional` block. The error message said "Expecting: one of these possible Token sequences... but found: 'if'"

**Why it was an issue:** The error message didn't explicitly say "if must be inside a conditional block". I had to infer this from the token options which included "if" as a valid token but my syntax was still wrong.

**Potential solution:** The error message could be more explicit: "'if' statements must be wrapped in a 'conditional' block" would be much clearer.

---

## [2025-02-19 17:45 PST] - XanoScript: elseif vs else if

**What I was trying to do:** Write a conditional with multiple branches

**What the issue was:** After fixing the `if` to be inside a `conditional` block, I initially tried `else if` (two words) instead of `elseif` (one word). 

**Why it was an issue:** Most languages use `else if` or `elif`, so `elseif` as a single keyword is unusual. The validation caught it and I fixed it by looking at the quick reference.

**Potential solution:** The quick reference clearly shows `elseif` so the documentation is correct. Just noting this as a common syntax gotcha for developers coming from other languages.

---

## [2025-02-19 17:50 PST] - Architecture: Testing multiple inputs in run.job

**What I was trying to do:** Follow the requirement that run.job should "call the solution function with test inputs" (plural)

**What the issue was:** run.job only supports calling a single function with a single input. To test multiple cases, I had to create a separate "test runner" function that internally calls the solution function multiple times.

**Why it was an issue:** The architecture requirement implies the run job itself should handle multiple test cases, but the language doesn't support this directly. The workaround (test runner function) works but adds an extra file.

**Potential solution:** Either:
1. Clarify the architecture requirement to say "run.job calls a test function which exercises the solution with multiple inputs"
2. Or extend run.job to support multiple `main` calls or a `test` block

The current solution (separate test runner function) is clean and follows the pattern well once understood.
