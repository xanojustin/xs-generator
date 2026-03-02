# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 12:05 PST] - run.job syntax confusion

**What I was trying to do:** Create a run.job that calls a function with multiple test inputs

**What the issue was:** I incorrectly assumed `run.job` could contain a `stack` block like functions do. I wrote:
```xs
run.job {
  description = "..."
  stack {
    function.run "..." { ... }
  }
}
```

But the correct syntax requires a job name string and uses `main` to specify which function to call:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

**Why it was an issue:** The error message `Expecting: one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'` was technically correct but cryptic. It took re-reading the full documentation to understand that `run.job` requires a quoted name string.

**Potential solution:** 
- The quick reference for `run` topic could include a complete minimal example showing the required name string
- A more helpful error message might say something like: `run.job requires a name string, e.g., run.job "My Job" { ... }`

---

## [2026-03-02 12:10 PST] - run.job limited to single function call

**What I was trying to do:** Run multiple test cases from the run job

**What the issue was:** The `run.job` `main` property only allows calling a single function with static input values. To test multiple cases with different inputs, I had to create a separate "test harness" function that calls the solution function multiple times.

**Why it was an issue:** This adds an extra layer of indirection. The exercise requirements ask for "a run.job that uses function.run to call the solution function with test inputs" - but `run.job` itself cannot use `function.run` in a stack. It can only reference a single function via `main`.

**Potential solution:**
- Clarify in documentation that `run.job` is a configuration/entry point, not executable logic
- Consider allowing `run.job` to have a `stack` block for more flexibility (though this might break the clean separation of concerns)
- Document the "test harness function" pattern as the recommended approach for testing multiple scenarios

---

## [2026-03-02 12:15 PST] - Directory validation with mcporter

**What I was trying to do:** Validate multiple .xs files at once using the directory parameter

**What the issue was:** The shell quoting for mcporter call with JSON arrays was problematic. I tried:
```bash
mcporter call xano.validate_xanoscript file_paths: '["path1", "path2"]'
```

This caused shell quoting issues. Using `directory: '.'` with relative paths also didn't work initially.

**Why it was an issue:** Had to use absolute paths with the directory parameter to get validation working.

**Potential solution:**
- The `mcporter call` command could handle shell escaping better
- Or provide simpler single-file validation that's easier to call repeatedly

---

## [2026-03-02 12:20 PST] - Accessing array elements

**What I was trying to do:** Access 2D array elements like `$current[$r][$c]`

**What the issue was:** Was unsure if XanoScript supports chained array access. Testing showed it does work, which is good.

**Why it was an issue:** Uncertainty about syntax when building the DP table for the knight probability solution.

**Potential solution:**
- The quick reference could include an example of multi-dimensional array access
- Something like: `$matrix[$row][$col]` or `$data[$i]|get:$j`

---

## General Observations

**What worked well:**
- The `xanoscript_docs` tool with different modes (quick_reference vs full) is very helpful
- The validation tool gives clear line/column error locations
- The function syntax is clean and intuitive

**What was challenging:**
- The difference between `run.job` (configuration) and `function` (executable logic) wasn't immediately obvious
- Understanding that `$input.field` is required (not `$field`) took re-reading the essentials doc
- The `?` modifier placement (after type vs after variable name) is subtle but important
