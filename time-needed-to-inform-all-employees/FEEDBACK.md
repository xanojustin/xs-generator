# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 19:10 PST] - run.job Syntax Misunderstanding

**What I was trying to do:** Create a run job that calls a function with test inputs and logs results for multiple test cases.

**What the issue was:** I misunderstood the `run.job` syntax. I wrote it as an imperative block with `function.run` calls and `debug.log` statements inside:

```xs
run.job {
  function.run "time_needed_to_inform" { ... }
  debug.log { ... }
}
```

But the correct syntax is declarative with a `main` block:

```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

**Why it was an issue:** This blocked me because I couldn't figure out how to run multiple test cases within a single run job. The documentation shows `main` only accepts a single function call. I had to simplify to just one test case instead of the multiple test cases I originally planned.

**Potential solution (if known):** 
- The quick reference documentation for `run` was very brief and didn't show the full syntax with `main = { name: ..., input: ... }`
- It would help to have an example showing how to run multiple test cases, or clarify if run.job is designed for single function execution only
- Maybe add a "Testing Patterns" section showing recommended approaches for testing functions with multiple inputs

---

## [2025-03-03 19:12 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Use a filter in a while loop condition: `while ($stack|count > 0)`

**What the issue was:** The validator error said "An expression should be wrapped in parentheses when combining filters and tests" but the error message didn't clearly explain what needed parentheses. I had to guess whether it meant:
- `while (($stack|count) > 0)` - wrap just the filter
- `while ($stack|count > 0)` - wrap the whole expression

**Why it was an issue:** The error message was ambiguous about the scope of parentheses needed. I tried `($stack|count > 0)` first (wrapping the comparison), but the correct answer was `(($stack|count) > 0)` (wrapping just the filter expression).

**Potential solution (if known):**
- Improve the error message to say: "Filters must be wrapped in parentheses when used in comparisons. Example: `($arr|count) > 0` not `$arr|count > 0`"
- Or provide both the problematic code and the corrected code in the error message

---

## [2025-03-03 19:05 PST] - mcporter Command Syntax Quirks

**What I was trying to do:** Call the validate_xanoscript tool with multiple file paths.

**What the issue was:** The mcporter command syntax was tricky with shell quoting. I tried:
```bash
mcporter call xano.validate_xanoscript file_paths: '["~/xs/.../run.xs", "~/xs/.../function.xs"]'
```

But got a zsh parse error. I eventually used the `directory` parameter instead.

**Why it was an issue:** Shell escaping of JSON arrays in mcporter commands is difficult. The directory approach worked but isn't ideal when you want to validate specific files.

**Potential solution (if known):**
- Document recommended shell escaping patterns for complex parameters
- Or support a simpler comma-separated format: `file_paths: "file1.xs,file2.xs"`

---

## General Feedback

**What worked well:**
- The `xanoscript_docs` tool with `mode=full` provided excellent detailed documentation
- The validation error messages include line/column numbers and code snippets
- The error detection caught real syntax issues that would have caused runtime failures

**What could be improved:**
- Quick reference docs for `run` were too brief - didn't show the actual syntax
- Error messages could be more explicit about the exact fix needed
- Would love to see more examples of common patterns (testing, loops with filters, etc.)
