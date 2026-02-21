# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 18:32 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that executes test cases for the intersection function

**What the issue was:** I initially wrote the run.job with a `description` field and `stack` block, similar to how functions are structured:
```xs
run.job "intersection_test" {
  description = "Test the intersection function with various test cases"
  stack {
    // test logic here
  }
}
```

This caused validation errors:
- `The argument 'description' is not valid in this context`
- `The argument 'stack' is not valid in this context`

**Why it was an issue:** The run.job syntax is fundamentally different from function syntax. I expected it to follow similar patterns (description + stack), but it uses a completely different structure with `main = { name: "...", input: {} }`.

**Potential solution:** 
- The quick reference for `run` topic could show a complete working example right at the top
- The error message could suggest "Did you mean to use `main = { name: ... }`?"
- A cheatsheet comparing function vs run.job vs run.service syntax side-by-side would help

---

## [2026-02-20 18:33 PST] - Where to put test logic

**What I was trying to do:** Run multiple test cases with debug output from a run.job

**What the issue was:** Once I understood run.job only calls a single function via `main`, I realized I couldn't put multiple test cases directly in the run.job. I had to create a separate "test" function that contains all the test logic, which then calls the actual solution function multiple times.

**Why it was an issue:** This wasn't immediately obvious from the documentation. The examples show run.jobs calling a single function, but don't explain the pattern for testing (where you need to call a function multiple times with different inputs).

**Potential solution:**
- Add an example showing "Testing Pattern: run.job calling a test function that exercises another function multiple times"
- Document common patterns like "Test Runner Pattern" in the run job docs

---

## [2026-02-20 18:31 PST] - validate_xanoscript file_paths parameter

**What I was trying to do:** Validate multiple files by passing an array of file paths

**What the issue was:** The initial attempt to use `file_paths` parameter failed with an error that one of the parameters was required. The exact JSON array syntax for the CLI wasn't clear.

**Why it was an issue:** The documentation shows `file_paths?: string[]` but doesn't give a CLI example of the proper format for passing arrays.

**Potential solution:**
- Add CLI examples showing: `mcporter call xano.validate_xanoscript file_paths:='["file1.xs", "file2.xs"]'`
- The `directory` parameter worked perfectly and was easier to use

---

## General Feedback

**What worked well:**
- The `directory` parameter for validation is convenient
- The error messages include line/column numbers which is helpful
- The documentation for `run` topic was comprehensive once I read the full version

**What could be improved:**
- A "Common Syntax Mistakes" section specifically for run.job vs function differences
- More cross-links between related topics (function docs should mention run.job patterns)
