# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 03:33 PST] - Nested Stack Blocks Not Allowed

**What I was trying to do:** Implement a TinyURL service with base62 encoding that required while loops for the conversion algorithm.

**What the issue was:** I initially wrote code with `stack` blocks nested inside `conditional` blocks inside the main `stack` block:

```xs
stack {
  conditional {
    if (condition) {
      stack {  // ERROR: stack inside conditional inside stack
        while (...) { ... }
      }
    }
  }
}
```

The validator gave this error:
```
[Line 61, Column 13] Expecting --> } <-- but found --> 'stack'
```

**Why it was an issue:** This pattern seemed natural for scoped variable operations within branches, but XanoScript doesn't support nested `stack` blocks. The documentation mentions "While loop (must be inside stack block)" but doesn't explicitly warn against nesting stacks inside conditionals.

**Potential solution:** 
- Add explicit documentation about stack block nesting rules
- Include an example showing how to restructure code that needs while loops inside conditionals
- Consider a clearer error message like "stack blocks cannot be nested inside conditional blocks"

---

## [2025-03-03 03:35 PST] - While Loops Require Stack Context

**What I was trying to do:** Use while loops for base62 encoding algorithm.

**What the issue was:** The documentation states "While loop (must be inside stack block)" but since I couldn't nest `stack` blocks, I had to use `for` loops instead.

**Why it was an issue:** Had to change algorithm approach from while loops to fixed-iteration for loops, which is less elegant for the base62 conversion where iteration count varies.

**Potential solution:** 
- Document workarounds for when you need while-loop behavior but can't nest stacks
- Show examples of converting while loops to for loops with conditional guards
- Consider if there's a way to allow while loops without requiring stack blocks

---

## [2025-03-03 03:36 PST] - Variable Declaration Location Requirements

**What I was trying to do:** Declare variables close to where they're used for cleaner code.

**What the issue was:** After removing nested stacks, I needed to move all variable declarations to the top of the main `stack` block because you can't declare new variables inside `conditional` blocks that persist outside them.

**Why it was an issue:** This made the code less readable - all variables are declared at the top far from where they're used, and I had to use `var.update` everywhere instead of `var` declarations in branches.

**Potential solution:**
- Document the pattern of declaring all variables upfront
- Consider allowing variable declarations inside conditionals that persist to the response
- Add examples showing the "declare all at top" pattern

---
