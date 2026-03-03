# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 13:00 PST] - Initial Setup

**What I was trying to do:** Set up the Xano MCP and get documentation for XanoScript syntax

**What the issue was:** None - MCP was already configured and working via mcporter

**Why it was an issue:** N/A

**Potential solution (if known):** N/A

---

## [2025-03-03 13:05 PST] - Run Job Syntax Confusion

**What I was trying to do:** Create a run job that calls a function with test inputs

**What the issue was:** I incorrectly assumed `run.job` had a similar structure to `function` with `description` and `stack` blocks. The validation error said "The argument 'description' is not valid in this context" which was confusing because functions use descriptions.

**Why it was an issue:** The `run.job` syntax is quite different from `function` syntax. I expected to be able to write multiple test cases in the run job's stack block, but run jobs simply specify a `main` function to call with fixed input values.

**Potential solution (if known):** 
1. The documentation in `xanoscript_docs` is clear about the correct syntax once you read it, but it's easy to miss the distinction between run jobs and functions.
2. A suggestion in the error message like "Did you mean to use 'main = { name: ... }' instead of 'stack'?" could help.
3. Perhaps a code example in the validation error output showing correct run.job syntax would be helpful.

---

## [2025-03-03 13:10 PST] - Limitation: Testing Multiple Cases in Run Jobs

**What I was trying to do:** Run multiple test cases from the run job

**What the issue was:** The `run.job` syntax only allows calling a single function with fixed input. I wanted to test multiple cases (like str1="abac"/str2="cab", str1="abc"/str2="def", etc.) but had to reduce it to just one test case.

**Why it was an issue:** For a coding exercise generator, it's valuable to demonstrate multiple test cases. The run job limitation means I can only show one example per run job.

**Potential solution (if known):** 
1. Could create multiple run jobs (run1.xs, run2.xs, etc.) for different test cases
2. Could modify the function to accept an array of test cases and return all results
3. The run.job syntax could potentially support a sequence of function calls or a "tests" array

---
