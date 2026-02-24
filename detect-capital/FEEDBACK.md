# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 05:05 PST] - Run Job Syntax Misunderstanding

**What I was trying to do:** Create a run job that runs multiple test cases and logs results

**What the issue was:** I assumed `run.job` worked like a `function` with a `stack` block, `description`, and `response`. This is wrong.

**Why it was an issue:** The validation errors were:
- `The argument 'description' is not valid in this context`
- `The argument 'stack' is not valid in this context`

I had written:
```xs
run.job "detect-capital-test" {
  description = "..."  // ERROR
  stack {              // ERROR
    // test logic
  }
  response = $results  // ERROR
}
```

**Potential solution (if known):** The quick_reference for `run` was too brief - it only showed the property table but no actual syntax examples. I had to call the full docs to understand that `run.job` only supports:
- `main` (required) - with `name` and `input`
- `env` (optional) - array of environment variable names

The syntax is:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { key: value }
  }
}
```

**Suggestion:** The quick_reference for `run` should include at least one complete syntax example.

---

## [2026-02-24 05:08 PST] - One Function Per File Limitation

**What I was trying to do:** Put both the solution function and test function in the same file (`function/detect-capital.xs`)

**What the issue was:** Got error: `Redundant input, expecting EOF but found: function`

**Why it was an issue:** I thought I could define multiple functions in one file like in JavaScript or Python. The error message was clear but I didn't know about this constraint beforehand.

**Potential solution (if known):** The `functions` quick_reference shows only a single function example. Adding a note like "Only one function definition per .xs file" would help. Alternatively, allowing multiple functions per file would be more convenient for small test functions.

---

## [2026-02-24 05:00 PST] - Documentation Discovery

**What I was trying to do:** Find the correct XanoScript syntax before writing code

**What the issue was:** The `xanoscript_docs` tool has many topics but it wasn't immediately clear which ones I needed for this task.

**Why it was an issue:** I had to call the tool multiple times with different topics (`functions`, `run`, `syntax`, `types`, `quickstart`, `cheatsheet`) to piece together the information I needed.

**Potential solution (if known):** A `topic=guide` or `topic=example-task` that combines relevant docs for common scenarios (like "build a run job with tests") would be helpful. Or a topic index that suggests which topics to read for specific use cases.

---

## General Feedback

**What worked well:**
- The `validate_xanoscript` tool is fast and gives clear error messages with line/column numbers
- The `file_path` parameter for validation is much easier than escaping code strings
- The directory validation option is convenient for batch checking

**What was confusing:**
- The distinction between `run.job` (for one-time execution) and `function` (for reusable logic) wasn't clear until I got errors
- Not knowing that `run.job` is just a configuration entry point, not executable code
