# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 02:35 PST] - run.job syntax confusion

**What I was trying to do:** Create a run.job that calls a function with multiple test inputs and logs results

**What the issue was:** I assumed `run.job` would follow similar syntax patterns as `function` (using `stack`, `function.run`, `debug.log`, etc.), but it uses a completely different structure:

```xs
// What I expected (similar to function syntax):
run.job {
  description = "..."
  stack {
    function.run "name" { input = {...} } as $result
    debug.log { value = ... }
  }
  response = ...
}

// Actual syntax:
run.job "Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

**Why it was an issue:** The error message "Expecting: one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'" was not very helpful in understanding that:
1. run.job requires a quoted name before the opening brace
2. The body uses `main = { name: ..., input: ... }` instead of a stack block

**Potential solution (if known):** 
- The documentation for `run.job` syntax could be more prominent in the quick reference
- A more descriptive error message like "run.job requires a name string before the block" would help
- Perhaps include a complete run.job example in the `quickstart` or `functions` docs that shows calling a function

---

## [2026-02-25 02:32 PST] - Lack of run.job documentation in quick reference

**What I was trying to do:** Find the correct syntax for run.job to call a function

**What the issue was:** The `xanoscript_docs` quick_reference for `run` topic only showed:

```
### Directory Structure
```
run.xs
table/
function/
api/
```
```

There was no actual syntax for how to write a run.job file.

**Why it was an issue:** I had to look at an existing example file in the repo to understand the syntax. The MCP documentation should be self-sufficient.

**Potential solution (if known):** 
- Add a code example to the `run` topic documentation showing the `run.job "Name" { main = { name: "...", input: {...} } }` syntax
- Include a note that run.job syntax is different from function syntax
