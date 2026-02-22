# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 03:05 PST] - Arrow function syntax not supported

**What I was trying to do:** Implement a recursive DFS algorithm for cloning a graph, using a closure/callback function to handle the recursive node cloning.

**What the issue was:** I tried to use arrow function syntax `->($original) { ... }` which is common in many languages (JavaScript, Rust, etc.), but XanoScript does not support this syntax. The validation error was:
```
[Line 29, Column 15] Expecting: Expected an expression but found: '-'
```

**Why it was an issue:** This blocked me from using a natural recursive approach. I had to completely rewrite the algorithm to use iterative DFS with an explicit stack instead.

**Potential solution:**
1. Document clearly that XanoScript does not support first-class functions or closures
2. If closures are intentionally not supported, provide examples in docs showing the iterative alternative patterns
3. Consider adding support for named recursive function calls within the same function (if not already possible)

---

## [2026-02-22 03:05 PST] - Run job syntax completely different from expected

**What I was trying to do:** Create a run.xs file following what I thought was the pattern from other exercises (using stack/description/response blocks).

**What the issue was:** The run.job syntax is completely different from function syntax. I wrote:
```xs
run.job {
  description = "..."
  stack { ... }
  response = ...
}
```
But the correct syntax is:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

**Why it was an issue:** The error message was cryptic:
```
[Line 1, Column 9] Expecting: one of these possible Token sequences but found: '{'
```
This didn't clearly indicate that run.job requires a string name parameter.

**Potential solution:**
1. Improve the error message to say something like "run.job requires a job name string, e.g., run.job 'My Job' { ... }"
2. The quick_reference docs for 'run' don't show the complete syntax with the job name string
3. Consider adding a more prominent example in the run documentation showing the full correct syntax

---

## [2026-02-22 03:05 PST] - MCP file_paths parameter parsing issue

**What I was trying to do:** Validate multiple files by passing comma-separated paths to the file_paths parameter.

**What the issue was:** The command:
```
mcporter call xano.validate_xanoscript file_paths=/Users/justinalbrecht/xs/clone-graph/function/clone-graph.xs,/Users/justinalbrecht/xs/clone-graph/run.xs
```

Caused the MCP to split the path into individual characters as separate file entries, resulting in errors like:
```
File not found: U
File not found: s
File not found: e
...
```

**Why it was an issue:** This is a CLI parsing issue where the comma-separated values aren't being parsed correctly as an array.

**Potential solution:**
1. Fix the mcporter CLI parsing for array parameters
2. Or document that file_paths should be passed using JSON format: `--args '{"file_paths": ["path1", "path2"]}'`

Workaround: Use the `directory` parameter instead, which works correctly.

---

## [2026-02-22 03:10 PST] - Missing syntax documentation for recursive patterns

**What I was trying to do:** Understand how to implement recursive algorithms in XanoScript.

**What the issue was:** After discovering closures aren't supported, I wasn't sure if:
1. A function can call itself by name
2. There was any way to achieve recursion
3. All algorithms must be written iteratively

**Why it was an issue:** Many classic algorithms (graph traversal, tree operations) are naturally expressed recursively. Without knowing the pattern, I had to rewrite as iterative.

**Potential solution:**
Add a section to the functions or syntax documentation explicitly stating:
- Whether self-referential function calls are supported
- Recommended patterns for recursive algorithms (iterative with explicit stack)
- Examples of common recursive algorithms rewritten iteratively

---
