# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 13:35 PST] - XanoScript Syntax Discovery

**What I was trying to do:** Write a run.job that contains test logic directly

**What the issue was:** I assumed `run.job` worked like a `function` with a `stack` block where I could write execution logic. Instead, `run.job` uses a `main` property that references a function to execute.

**Why it was an issue:** This is a fundamentally different pattern than typical programming where the entry point contains logic. I had to create a separate `test_runner` function to hold the test logic.

**Potential solution:**
- The documentation is clear about this, but perhaps a more prominent warning at the top of the `run` docs would help
- An example showing "WRONG: using stack in run.job" vs "RIGHT: using main to call a function" could help catch this mistake

---

## [2025-02-27 13:35 PST] - Loop Index Access

**What I was trying to do:** Get the current index inside a `foreach` loop to build a value-to-indices map

**What the issue was:** I tried using `index as $idx` syntax (similar to other template languages), but this isn't valid XanoScript. There's no built-in way to get the loop index directly in the foreach syntax.

**Why it was an issue:** Many algorithms require knowing the position of elements in an array. Without direct index access in foreach, I had to manually track a counter variable.

**Workaround used:**
```xs
var $idx { value = 0 }
foreach ($array) {
  each as $item {
    // use $idx here
    var $idx { value = $idx + 1 }
  }
}
```

**Potential solution:**
- Consider adding `each as $item, $index` syntax for direct index access
- Or document the manual counter pattern as the recommended approach

---

## [2025-02-27 13:35 PST] - MCP Tool Parameter Format

**What I was trying to do:** Call `validate_xanoscript` with multiple file paths

**What the issue was:** The `file_paths` parameter expects an array, but I initially passed it as a comma-separated string. The error message "expected array, received string" was clear, but I wasn't sure of the correct CLI syntax.

**Why it was an issue:** Had to figure out the correct `--args` JSON format for mcporter

**Solution found:**
```bash
mcporter call xano.validate_xanoscript --args '{"file_paths": ["/path/1.xs", "/path/2.xs"]}'
```

**Potential solution:**
- Document example mcporter calls with complex arguments in the MCP help
- Or add a shorthand like `file_path` (singular) that can be used multiple times
