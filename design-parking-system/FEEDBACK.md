# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 09:35 PST] - run.job syntax confusion

**What I was trying to do:** Create a run.xs file that calls a function with test inputs and logs results

**What the issue was:** I initially wrote the run.xs file with the logic directly inside the `run.job` block, similar to how functions work. The validation failed with:
```
[Line 1, Column 9] Expecting: one of these possible Token sequences:
  1. ["..."]
  2. [Identifier]
but found: '{'
```

**Why it was an issue:** The error message didn't clearly indicate that `run.job` requires a quoted name after it. Looking at the documentation helped, but the error could be more specific about missing the job name.

**Potential solution (if known):** The error message could say something like: "run.job requires a name in quotes, e.g., run.job 'Job Name' { ... }"

---

## [2025-02-28 09:37 PST] - run.job structure unclear from quick_reference

**What I was trying to do:** Understand how to write a run.xs that calls a function and logs results

**What the issue was:** The quick_reference for `run` only showed the basic structure without the `main` property details. I initially tried putting logic directly in the run.job block like:
```xs
run.job {
  function.run "..."
  debug.log "..."
}
```

But the actual structure requires:
```xs
run.job "Name" {
  main = {
    name: "function-name"
    input: { ... }
  }
}
```

**Why it was an issue:** The quick_reference showed `run.job` and `run.service` but not the internal `main` property structure. I had to fetch the full documentation to understand this.

**Potential solution (if known):** The quick_reference for `run` could include a complete minimal example showing the `main` property.

---

## [2025-02-28 09:38 PST] - function.run only accepts constant inputs

**What I was trying to do:** Create a test function that calls another function multiple times and aggregates results

**What the issue was:** Initially I tried to put multiple `function.run` calls in the run.xs directly, but the documentation states "Input values must be constants - No variables like $input allowed" in run jobs. This means I needed to create a separate test function to call the main function multiple times.

**Why it was an issue:** This wasn't immediately obvious and required re-reading the validation rules section of the documentation. The architecture of run.job -> main function -> test function calling solution function adds an extra layer of indirection.

**Potential solution (if known):** The documentation could more prominently state that run.jobs are essentially just configuration that delegates to a single function, and any complex logic or multiple function calls must happen inside that function.

---

## Positive Feedback

The `validate_xanoscript` tool worked great and provided helpful line/column error positions. Once I understood the structure, creating and validating the files was straightforward.
