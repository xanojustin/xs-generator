# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 22:05 PST] - Tilde (~) path expansion not working in validation

**What I was trying to do:** Validate files using `~/xs/meeting-rooms-ii` path with tilde expansion.

**What the issue was:** The MCP tool doesn't expand `~` to the home directory. Instead, it tried to validate individual characters as separate files, resulting in errors like "File not found: ~", "File not found: x", "File not found: s", etc.

**Why it was an issue:** Had to use absolute paths (`/Users/justinalbrecht/xs/...`) instead of the more convenient tilde notation.

**Potential solution:** Either support tilde expansion in the MCP or document that absolute paths are required.

---

## [2026-02-22 22:10 PST] - Unclear conditional block syntax

**What I was trying to do:** Write an if statement in a function stack block.

**What the issue was:** The documentation mentions `if` but doesn't clearly indicate that `if` statements must be wrapped in `conditional { ... }` blocks. I tried putting `if` directly in the stack and got parse errors.

**Why it was an issue:** Wasted validation cycles figuring out the correct structure. The error message "Expecting } but found 'if'" was cryptic.

**Potential solution:** 
1. Document the `conditional { if (...) { ... } else { ... } }` pattern more prominently
2. Include a clear example in the functions quick reference showing the required wrapper

---

## [2026-02-22 22:15 PST] - Null-safe operators not valid in conditionals

**What I was trying to do:** Use the null-safe comparison operator `<=?` in a conditional expression.

**What the issue was:** The syntax docs list `<=?` as a valid null-safe operator, but using it in a conditional caused a parse error: "Expecting various tokens but found: '?'"

**Why it was an issue:** The documentation says these operators exist, but they don't seem to work in conditional contexts. Had to switch to regular `<=`.

**Potential solution:** Either fix the parser to accept null-safe operators in conditionals, or document where they can/can't be used.

---

## [2026-02-22 22:18 PST] - Nested conditional blocks confusing

**What I was trying to do:** Write an if-else inside another if's else branch (nested conditionals).

**What the issue was:** Had to wrap each if/else in its own `conditional` block, which felt verbose and unintuitive. The nesting became hard to read.

**Why it was an issue:** Code like:
```xs
conditional {
  if (condition1) {
    // ...
  } else {
    conditional {
      if (condition2) {
        // ...
      } else {
        // ...
      }
    }
  }
}
```
is awkward compared to most languages.

**Potential solution:** Consider allowing conditionals without the wrapper block, or document best practices for complex nested logic.

---

## [2026-02-22 22:20 PST] - Array access syntax unclear

**What I was trying to do:** Access array elements by index.

**What the issue was:** Wasn't sure if array access uses `$array[index]` or `$array|get:"index"` or something else.

**Why it was an issue:** The documentation shows filters like `|first` and `|last` but doesn't clearly show indexed access syntax.

**Potential solution:** Add indexed array access to the syntax quick reference with an example.
