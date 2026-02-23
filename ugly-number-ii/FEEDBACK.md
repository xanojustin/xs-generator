# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 09:35 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that calls a function with test inputs

**What the issue was:** I initially wrote the run.job with a `stack` block and function calls like:
```xs
run.job {
  description = "..."
  stack {
    function.run "ugly-number-ii" { ... }
  }
}
```

But this is incorrect. The validation error was:
```
[Line 1, Column 9] Expecting: one of these possible Token sequences:
  1. ["..."]
  2. [Identifier]
but found: '{'
```

**Why it was an issue:** The error message doesn't clearly explain that run.job requires a name string in quotes. The "Expecting... but found '{'" is cryptic without context. Also, the documentation shows `run.job {` in the quick reference which is misleading.

**Potential solution (if known):** 
1. Improve the error message to say something like: "run.job requires a name in quotes, e.g., run.job 'My Job Name' {"
2. Update the quick reference to show the name parameter: `run.job "Name" {`

---

## [2025-02-23 09:36 PST] - Documentation clarity on run.job vs function stack

**What I was trying to do:** Understand the difference between how functions are called in a run.job vs a regular function stack

**What the issue was:** It wasn't immediately clear that run.job uses `main = { name: "...", input: {...} }` syntax instead of being able to write procedural code in a stack block. I expected to be able to call multiple functions and debug.log in a run job like in other languages.

**Why it was an issue:** The architecture constraint says "a run job that calls a function" but doesn't clarify that run.job is essentially a declarative pointer to a single function, not a procedural script that can call multiple functions.

**Potential solution (if known):** 
1. Add a note in the run.job documentation that it calls exactly ONE function via `main`
2. Clarify that if you need multiple test cases or procedural logic, that should be inside the function itself, or create multiple run jobs

---

## [2025-02-23 09:37 PST] - No mcporter parameter passing issues

**What I was trying to do:** Pass file_paths array to validate_xanoscript

**What the issue was:** The mcporter call syntax with array parameters wasn't working:
```bash
mcporter call xano.validate_xanoscript file_paths:='["/path/1", "/path/2"]'
```

**Why it was an issue:** The parameter wasn't being recognized. I had to use `--args` with JSON instead.

**Potential solution (if known):** 
1. Document the correct syntax for passing arrays to mcporter call
2. Or make the error message more helpful when parameters aren't recognized

---

## General Observations

**What worked well:**
- The `validate_xanoscript` tool is very helpful and gives clear line/column error locations
- The `xanoscript_docs` tool with mode="quick_reference" is efficient for getting syntax
- The validation errors include the actual code line which helps debugging

**What could be improved:**
1. The quick reference documentation shows `run.job {` without the required name parameter
2. Error messages could be more descriptive about what's expected (e.g., "run.job requires a quoted name")
3. The difference between run.job (declarative, single function) and function (procedural, stack-based) could be more prominently highlighted
