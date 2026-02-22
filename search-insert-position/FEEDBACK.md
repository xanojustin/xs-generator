# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 09:05 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that runs test cases for the search_insert_position function

**What the issue was:** I initially wrote the run.xs file with a `stack` block containing the test logic, similar to how functions are structured. However, the validator rejected this with errors saying `description`, `stack`, and `response` are not valid in the run.job context.

**Why it was an issue:** The quick reference documentation for `run` topics didn't clearly show the contrast between the minimal run.job syntax and the full function syntax. I assumed run.jobs could have stack blocks like functions.

**Potential solution (if known):** The `run` documentation could include a "Common Mistakes" section that explicitly states "run.job uses `main = { name: ..., input: ... }` syntax, NOT `stack { ... }` blocks like functions." The examples do show the correct syntax, but a warning about this specific confusion would help.

---

## [2026-02-22 09:06 PST] - File path array parsing issue

**What I was trying to do:** Validate multiple specific files using the `file_paths` parameter

**What the issue was:** When passing comma-separated file paths to the `file_paths` parameter, the MCP tool was splitting the string by characters instead of treating it as an array of paths. This resulted in errors like "File not found: U", "File not found: s", etc. (each character of the path was treated as a separate file).

**Why it was an issue:** I had to switch to using the `directory` parameter instead of `file_paths`, which validates all files in the directory. This works but is less precise when you only want to validate specific files.

**Potential solution (if known):** The MCP tool should properly parse the `file_paths` parameter as an array when provided in the format `file_paths=path1,path2` or support JSON array format.

---

## [2026-02-22 09:08 PST] - Documentation request: run.job vs function architecture

**What I was trying to do:** Understand the architectural pattern for run jobs that need to execute multiple test cases

**What the issue was:** The documentation shows simple run.jobs that call a single function, but doesn't explicitly show the pattern for "a run job that runs multiple tests and aggregates results."

**Why it was an issue:** I had to infer that the solution is to create a separate "test runner" function that contains the stack logic, then have the run.job call that function. This pattern works well but wasn't immediately obvious.

**Potential solution (if known):** The documentation could include a "Testing Pattern" example showing:
1. A solution function (the actual implementation)
2. A test runner function (calls solution with multiple inputs, aggregates results)
3. A run.job (simple entry point that calls the test runner)

This would clarify the architecture: run.job = entry point configuration, function = executable logic.

---
