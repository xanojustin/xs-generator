# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 14:05 PST] - Initial Run Job Syntax Confusion

**What I was trying to do:** Create a run job that calls a function with multiple test inputs

**What the issue was:** I used `run "job" {` syntax which was incorrect. The correct syntax is `run.job "Test Name" {`

**Why it was an issue:** The validator gave an error: `[Line 1, Column 5] Expecting --> . <-- but found --> '"job"'`. Without checking existing examples, I wouldn't have known that `run.job` is the correct construct name.

**Potential solution:** The error message could suggest valid run constructs like `run.job`, `run.service`, etc.

---

## [2025-02-26 14:05 PST] - Run Job Structure for Multiple Tests

**What I was trying to do:** Create a run job that runs multiple test cases against the function

**What the issue was:** My initial approach tried to use a `stack` block with multiple `function.run` calls and `debug.log` statements, but the correct simple run.job syntax only supports a single `main = { name: ..., input: ... }` call.

**Why it was an issue:** I had to simplify my run.xs to only test one input case instead of multiple test cases. Looking at other examples (fizzbuzz, bubble-sort, merge-sort), they all follow this simpler pattern.

**Potential solution:** The documentation could clarify whether there's a way to run multiple function calls in a single run job, or if the pattern should be one test per run job.

---

## [2025-02-26 14:05 PST] - While/Each Block Nesting

**What I was trying to do:** Implement nested while loops for the selection sort algorithm

**What the issue was:** I had a `var.update` statement outside the `each` block but inside the `while` loop. The validator complained about expecting `}` but finding `var`.

**Why it was an issue:** The structure requires all statements to be inside `each { ... }` when inside a `while` loop. I had:
```xs
while ($j < $n) {
  each {
    ...
  }
  var.update $j { ... }  // This was outside each
}
```

**Potential solution:** The error message was actually helpful here (pointed to the exact line), but it would be even better if it explicitly stated "statements inside while loops must be within the each block."

---

## [2025-02-26 14:05 PST] - Positive Feedback

**What worked well:**
- The `xanoscript_docs` MCP tool with topics like `functions` and `quickstart` was very helpful
- Reading existing working examples from `~/xs/` directory was essential
- The validation error messages included line numbers and showed the actual code
- The bubble-sort example was a perfect reference since it also uses nested while loops

---
