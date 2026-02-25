# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 09:05 PST] - Run Job Syntax Confusion

**What I was trying to do:** Create a run job that calls a function with test inputs and logs results

**What the issue was:** I initially wrote the run.xs file using a `stack` block with `debug.log` statements, similar to how functions work. The validation failed with errors:
- `The argument 'description' is not valid in this context`
- `The argument 'stack' is not valid in this context`

**Why it was an issue:** The run.job syntax is significantly different from function syntax. I expected it to work like a function where I can write procedural code with a stack block, but run.jobs only accept a `main` property that points to a function to execute.

**Potential solution (if known):** The documentation was clear once I read the full `run` topic, but the quick reference didn't show the complete syntax. A clear example in the quick reference showing the difference between run.job (uses `main`) vs function (uses `stack`) would help. Maybe a side-by-side comparison.

---

## [2026-02-25 09:06 PST] - Input Default Value Syntax Error

**What I was trying to do:** Define an optional input parameter with a default value for the number of buckets

**What the issue was:** I wrote `int bucket_count?={10}` thinking the curly braces were needed for the default value object. The validator failed with:
- `Expecting: one of these possible Token sequences... but found: '{'`
- 💡 Suggestion: Use "decimal" instead of "number"

**Why it was an issue:** I was confused about the syntax for optional parameters with defaults. The error message about using "decimal" instead of "number" was misleading since I was using `int`, not `number`. The real issue was the `{10}` syntax instead of `=10`.

**Potential solution (if known):** The quickstart guide showed `text role?="user"` for optional with default, but I missed that the `?` (optional) and `=` (default) are separate operators. A more explicit example in the cheatsheet showing `int count?=10` vs `int count?={10}` would be helpful. The error message could also be improved to mention the correct default value syntax.

---

## [2026-02-25 09:07 PST] - No Debug/Logging in Run Jobs

**What I was trying to do:** Log test results within the run job to see output during execution

**What the issue was:** After learning run.jobs can't have stack blocks, I realized I can't use `debug.log` directly in a run job. I had to create a separate function to hold all the test logic and call that from the run job.

**Why it was an issue:** This creates more files than expected. For a simple exercise with multiple test cases, I needed:
1. `run.xs` - minimal entry point
2. `function/bucket-sort.xs` - the actual algorithm
3. `function/run-bucket-sort-tests.xs` - wrapper to run multiple tests

This is 3 files instead of 2 (if run jobs could have procedural code). It's not a huge issue, but it was unexpected.

**Potential solution (if known):** If there's a reason run.jobs must be declarative only, the documentation should emphasize this architectural decision. Alternatively, supporting a `stack` block in run.jobs (even if limited) would reduce file count for simple testing scenarios.

---

## [2026-02-25 09:08 PST] - Positive Validation Experience

**What worked well:** Once I read the correct documentation, the validation tool was very helpful:
- Clear error messages with line/column numbers
- Actual code snippets showing the problematic lines
- The tool correctly identified all 3 files as valid after fixes

**Suggestion:** The validation tool is excellent - the main friction was understanding the correct syntax patterns before validation. More syntax examples in quick_reference mode would reduce the trial-and-error cycle.
