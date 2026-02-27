# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 23:05 PST] - run.job syntax confusion

**What I was trying to do:** Create a run.xs file that tests the function with multiple test cases

**What the issue was:** I wrote the run.job using the same syntax as a function (with a `stack` block, variable declarations, function.run calls, etc.), but run.job has a completely different syntax. The validation error was:
```
[Line 1, Column 9] Expecting: one of these possible Token sequences:
  1. ["..."]
  2. [Identifier]
but found: '{'
```

**Why it was an issue:** The error message doesn't clearly explain that run.job needs a name string after it (like `run.job "Name" {`). The quick_reference documentation for the `run` topic is extremely minimal and doesn't show the actual syntax structure with examples.

**Potential solution:** 
1. The `run` topic quick_reference should include a complete example showing the `run.job "Name" { main = { name: "...", input: { ... } } }` syntax
2. The validation error could be more descriptive, like "run.job requires a name string, e.g., run.job 'My Job' {"

---

## [2026-02-26 23:08 PST] - Cannot run multiple test cases in a single run.job

**What I was trying to do:** Run multiple test cases in a single run.job execution to verify the function works correctly across different inputs

**What the issue was:** The run.job syntax only supports calling a single function via the `main` block. There's no way to:
- Run the same function multiple times with different inputs
- Log intermediate results
- Compare expected vs actual outputs
- Return aggregated results from multiple tests

**Why it was an issue:** For a coding exercise generator, being able to test multiple cases is essential. I had to reduce my test suite from 5 test cases to just 1 in the run.job, making it less useful for verification.

**Potential solution:**
1. Allow `stack` blocks in run.job for more complex orchestration
2. Support a `tests` array where multiple function calls can be specified
3. Or document the limitation clearly and suggest using multiple run.xs files or a different approach

---

## [2026-02-26 23:10 PST] - mcporter CLI parameter format inconsistency

**What I was trying to do:** Call the validate_xanoscript tool using the CLI format shown in the schema

**What the issue was:** The schema shows parameters like `file_path`, but the CLI requires kebab-case `--file-path` or JSON args with `--args`. I initially tried:
```
mcporter call xano.validate_xanoscript file-path="..."
```
But this failed with "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required". I had to use `--args '{"file_path": "..."}'` instead.

**Why it was an issue:** The error message made it seem like the parameter name was wrong, not the format. The mcporter documentation doesn't clearly explain when to use which format.

**Potential solution:** 
1. Better error messages that suggest using `--args` for complex parameters
2. More examples in the mcporter skill documentation showing different parameter types

---

## General Observation: Limited documentation for complex patterns

**What I noticed:** The quick_reference mode provides syntax basics, but complex patterns like:
- Working with nested objects/arrays in loops
- Variable scoping rules in nested while/foreach loops
- Best practices for counting/updating variables in loops

...are not well documented. I had to infer the pattern from the essentials docs.

**Potential solution:**
Add more examples in the documentation for common algorithmic patterns (binary search, two-pointer techniques, etc.)
