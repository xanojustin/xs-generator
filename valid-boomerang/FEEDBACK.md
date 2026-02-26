# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 02:35 PST] - file_paths parameter parsing issue

**What I was trying to do:** Validate multiple XanoScript files at once using the `file_paths` parameter

**What the issue was:** When passing multiple file paths as a comma-separated string to `file_paths`, the MCP parsed each character as a separate file path. For example, passing `file_paths=/Users/justinalbrecht/xs/valid-boomerang/run.xs,/Users/justinalbrecht/xs/valid-boomerang/function/check_valid_boomerang.xs` resulted in the MCP trying to validate individual characters like "U", "s", "e", "r", "s", etc.

**Why it was an issue:** This prevented batch validation of multiple files, requiring individual validation calls instead

**Potential solution (if known):** The MCP should properly parse comma-separated file paths in the `file_paths` array parameter, or the documentation should clarify the expected format

---

## [2026-02-26 02:35 PST] - Documentation request for array slicing

**What I was trying to do:** Access the second and third elements of an array using the `slice` filter

**What the issue was:** The documentation shows `slice` exists but doesn't clearly explain the indexing behavior (0-based vs 1-based, inclusive vs exclusive end index)

**Why it was an issue:** I had to guess that `slice:1:2` returns a single element at index 1, and `slice:2:3` returns the element at index 2

**Potential solution (if known):** Add clear examples to the documentation showing slice behavior with arrays

---

## [2026-02-26 02:35 PST] - Positive feedback - clear syntax documentation

**What I was trying to do:** Write XanoScript code for a function and run job

**What worked well:** The documentation for `function` and `run.job` was clear and provided good examples. The syntax for input blocks, stack blocks, and response was well-documented.

**Result:** Both files passed validation on the first attempt without any errors.
