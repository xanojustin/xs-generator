# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 11:35 PST] - Conditional blocks cannot contain Each blocks

**What I was trying to do:** Implement the spiral matrix traversal logic with conditional boundary checks (only traverse right column if rows remain, etc.)

**What the issue was:** The XanoScript parser does not allow `each` blocks to be nested inside `conditional` blocks. When I tried:
```
conditional {
  if ($top <= $bottom) {
    each {
      // operations
    }
  }
}
```
I got the error: `Expecting --> } <-- but found --> 'each'`

**Why it was an issue:** This is a common pattern in programming - conditionally executing a block of code. Having to restructure to use `while` loops with boolean flags is less intuitive:
```
var $continue { value = ($top <= $bottom) }
while ($continue) {
  each {
    // operations
    var.update $continue { value = false }
  }
}
```

**Potential solution:** Either allow `each` inside `conditional` blocks, or provide clearer documentation about valid block nesting rules. The current error message is cryptic - it doesn't explain *why* `each` is unexpected there.

---

## [2025-02-20 11:32 PST] - Confusion about variable update syntax

**What I was trying to do:** Update loop counter variables during iteration

**What the issue was:** I initially used `math.add $var { value = 1 }` and `math.subtract $var { value = 1 }` but noticed other examples used `var.update $var { value = $var + 1 }`

**Why it was an issue:** The validation error mentioned `Use "int" instead of "integer"` which was unrelated to the actual issue. It wasn't clear which pattern was preferred or if both were valid.

**Potential solution:** Standardize on one approach in documentation and examples. The `var.update` pattern seems more flexible since it allows arbitrary expressions, not just increment/decrement.

---

## [2025-02-20 11:30 PST] - MCP server not accessible via openclaw CLI

**What I was trying to do:** Call `xanoscript_docs` tool as instructed in the task description

**What the issue was:** The command `openclaw mcp xanoscript_docs --tool validate_xanoscript` didn't work. Had to use `mcporter` directly instead.

**Why it was an issue:** The task instructions specifically said to call `xanoscript_docs` on the Xano MCP, but didn't clarify that this requires the `mcporter` CLI to be installed and configured separately.

**Potential solution:** Update task instructions to specify using `mcporter call xano.validate_xanoscript` or similar, and ensure `mcporter` is pre-configured in the environment.

---

## [2025-02-20 11:30 PST] - Error messages lack context

**What I was trying to do:** Understand why my code was failing validation

**What the issue was:** The error `Expecting --> } <-- but found --> 'each'` at line 57 didn't explain the *semantic* issue - that `each` blocks aren't allowed inside `conditional` blocks.

**Why it was an issue:** Had to guess and check multiple restructuring attempts before finding a pattern that worked. Wasted time on trial and error instead of understanding the constraint.

**Potential solution:** Improve error messages to explain the constraint violation, e.g.: `Error: 'each' blocks cannot be nested inside 'conditional' blocks. Consider restructuring with a 'while' loop.`
