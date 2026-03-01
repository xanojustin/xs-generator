# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 23:35 PST] - run.job syntax confusion

**What I was trying to do:** Create a run.xs file that calls the custom-sort-string function with test inputs

**What the issue was:** The original run.xs used incorrect syntax:
```xs
run.job {
  description = "..."
  // multiple function.run calls and debug.log statements
}
```

This resulted in the error:
```
[Line 1, Column 9] Expecting: one of these possible Token sequences:
  1. ["..."]
  2. [Identifier]
but found: '{'
```

**Why it was an issue:** The error message was clear about what was expected (a string or identifier), but it wasn't immediately obvious that `run.job` requires a job name. The pattern `run.job { description = ... }` seemed intuitive but was wrong.

**Potential solution:** The documentation in `xanoscript_docs` clearly shows the correct syntax, but perhaps the error message could suggest "Did you forget to provide a job name?" or show an example like `run.job "Job Name" { ... }`.

---

## [2026-02-28 23:36 PST] - Multiple test cases in run.job

**What I was trying to do:** Run multiple test cases in a single run.job execution

**What the issue was:** The original code had multiple `function.run` calls with `debug.log` statements to test different inputs. The correct `run.job` syntax only supports a single `main` function call.

**Why it was an issue:** For testing purposes, it's useful to run multiple test cases and see all results. The simplified version only tests one case.

**Potential solution:** The current pattern works for simple validation, but having a way to run multiple test cases (perhaps through a test harness function or a `run.test` construct) would be valuable for exercises like this. Alternatively, documenting a pattern where the main function itself runs sub-tests and returns aggregated results would help.

---

## [2026-02-28 23:37 PST] - MCP tool file_paths parameter format

**What I was trying to do:** Validate multiple files using the `file_paths` parameter

**What the issue was:** Initially tried passing a comma-separated string:
```
file_paths="/path/to/file1.xs,/path/to/file2.xs"
```

This failed with:
```
Invalid arguments: file_paths: Invalid input: expected array, received string
```

**Why it was an issue:** The MCP tool expects an array, but passing arrays via command line is non-obvious.

**Potential solution:** The `directory` parameter worked perfectly for this use case. The documentation could mention that `directory` is often easier than `file_paths` for batch validation. Also, showing an example of the correct array format for `file_paths` (if supported via CLI) would help.

---

## General Feedback

1. **Documentation is helpful:** The `xanoscript_docs` tool with `mode="full"` provided clear examples that helped identify the correct syntax.

2. **Validation tool works well:** Once the correct parameters were used, the validation tool gave clear error messages with line/column numbers.

3. **The exercise pattern is clear:** Following existing exercises (like fizzbuzz, two-sum) made it easy to understand the expected structure.
