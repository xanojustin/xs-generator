# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 21:35 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that executes a function with multiple test inputs and logs the results.

**What the issue was:** I incorrectly assumed `run.job` used a `stack` block like functions do. I wrote:
```xs
run.job {
  description = "..."
  stack {
    // test logic
  }
}
```

**Why it was an issue:** The validation failed with error: `Expecting: one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'`. This error message doesn't clearly indicate that `run.job` requires a name string (e.g., `run.job "Job Name"`).

**Potential solution:** 
- The error message could be more specific: "run.job requires a name string: run.job \"Job Name\" {"
- Documentation could emphasize that run.job has a completely different structure from functions (uses `main` instead of `stack`)

---

## [2025-03-01 21:35 PST] - for loop syntax ambiguity

**What I was trying to do:** Create a loop that executes N times to left-shift a number.

**What the issue was:** I wrote:
```xs
for ($shift_count) {
  each {
    var.update $result { value = $result | multiply:2 }
  }
}
```

The validation failed with: `Expecting --> as <-- but found --> '{'`.

**Why it was an issue:** The `for` loop requires `each as $idx` syntax, not just `each`. Looking at the documentation, the example shows:
```xs
for (10) {
  each as $idx {
    debug.log { value = $idx }
  }
}
```

But I missed that the `as $idx` part is required, not optional.

**Potential solution:**
- The error message could suggest: "for loops require 'each as $variable_name' syntax"
- Documentation could clarify whether the index variable is optional or required

---

## [2025-03-01 21:35 PST] - Lack of bitwise shift operators

**What I was trying to do:** Implement bitwise left and right shift operations (>> and << in most languages).

**What the issue was:** XanoScript doesn't appear to have bitwise shift operators. I had to use `divide:2` for right shift and `multiply:2` for left shift as workarounds.

**Why it was an issue:** For a problem explicitly about bitwise operations, not having native shift operators makes the code less readable and potentially less efficient.

**Potential solution:**
- Add bitwise shift operators: `| shift_right: n` and `| shift_left: n`
- Or add math filters: `| shr: n` and `| shl: n`

---

## [2025-03-01 21:35 PST] - Quick reference helpful but fragmented

**What I was trying to do:** Learn the correct syntax for XanoScript constructs.

**What the issue was:** I needed to call `xanoscript_docs` multiple times with different topics (`functions`, `run`, `syntax`, `essentials`) to piece together the full picture.

**Why it was an issue:** Each topic is documented separately, which is good for focus but requires multiple round trips to understand how different pieces work together (e.g., how run.job calls functions).

**Potential solution:**
- A single "complete example" showing run.job + function working together would be very helpful
- A "common patterns" topic with full working examples

---

## General Observations

1. **Validation is fast and helpful** - The MCP validation tool provides quick feedback with line/column numbers.

2. **Error messages could be more actionable** - Many errors describe what was found vs expected, but don't suggest the fix.

3. **Type system is clear** - The type names (int, text, bool, decimal) are distinct from other languages, which prevents confusion.

4. **Filter syntax is powerful** - The `|` filter chaining is intuitive once learned.
