# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 15:05 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that calls a function with test inputs

**What the issue was:** I used a `stack` block and `description` field in `run.job`, but the validator rejected both:
- `The argument 'description' is not valid in this context`
- `The argument 'stack' is not valid in this context`

The documentation I retrieved showed the correct syntax:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { key: value }
  }
}
```

But my initial instinct from reading other exercises made me think run.jobs could have stack blocks.

**Why it was an issue:** I had to rewrite the entire run.xs file to use the correct `main = { ... }` syntax instead of a more verbose test runner with multiple test cases.

**Potential solution:** The quick_reference documentation for `run` topic could be more explicit that `run.job` only accepts `main` and `env` parameters - no `description`, no `stack`. The full docs were clear, but I initially looked at the quick reference.

---

## [2026-03-01 15:07 PST] - Nested conditionals require separate conditional blocks

**What I was trying to do:** Check if we've reached the end of the string, then check if the value matches the target

**What the issue was:** I wrote:
```xs
conditional {
  if ($idx >= $num_len) {
    if ($val == $input.target) {  // ERROR: expecting } but found if
      ...
    }
  }
}
```

**Why it was an issue:** XanoScript doesn't allow direct nesting of `if` statements. Each `if` needs its own `conditional` wrapper:
```xs
conditional {
  if ($idx >= $num_len) {
    conditional {  // Need this wrapper!
      if ($val == $input.target) {
        ...
      }
    }
  }
}
```

This is quite verbose and was unexpected coming from other languages where `if` statements can nest freely.

**Potential solution:** The syntax documentation could highlight this more prominently. The `conditional` block is unique to XanoScript and the requirement to wrap every `if` (even nested ones) is a common pitfall. A dedicated "Common Syntax Pitfalls" section would help.

---

## [2026-03-01 15:10 PST] - Validation tool path handling

**What I was trying to do:** Validate multiple specific files using `file_paths` parameter

**What the issue was:** The command `mcporter call xano.validate_xanoscript file_paths='["~/xs/add-operators/run.xs", ...]'` failed with zsh escaping issues. I had to switch to using the `directory` parameter instead.

**Why it was an issue:** Shell escaping of JSON arrays is tricky. The `directory` parameter worked fine, but it would be nice to validate specific files sometimes.

**Potential solution:** Document the recommended shell escaping approach for `file_paths` in the MCP tool examples, or accept a simpler comma-separated string format.

---

## [2026-03-01 15:15 PST] - Lack of recursion in XanoScript

**What I was trying to do:** Implement a recursive backtracking algorithm for the add-operators problem

**What the issue was:** XanoScript doesn't seem to support recursive function calls. I had to convert my solution to use an explicit stack with a `while` loop instead of natural recursion.

**Why it was an issue:** Backtracking problems are naturally expressed recursively. The iterative stack-based approach works but is more verbose and harder to reason about.

**Potential solution:** If recursion is indeed not supported, documenting this limitation in the essentials/syntax docs would help developers know upfront to use iterative approaches. If it is supported, an example would be helpful.

---

## General Observations

### Positive
- The MCP validation tool provides excellent error messages with line/column numbers
- The suggestions (like "Use 'text' instead of 'string'") are helpful
- The `xanoscript_docs` tool is comprehensive when you know what to ask for

### Areas for Improvement
1. **Quick reference gaps:** The quick_reference mode for `run` didn't clearly show the exact syntax constraints (no `description`, `main` is required, etc.)
2. **Nesting rules:** The `conditional` block requirement for every `if` is unusual and could be highlighted more prominently
3. **Expression syntax:** Understanding when to use parentheses around filtered expressions (like `($arr|count) == 0`) took some trial and error
