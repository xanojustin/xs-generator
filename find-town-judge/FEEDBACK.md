# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-25 15:05 PST - object[][] type not supported

**What I was trying to do:** Define an input parameter for a 2D array (array of arrays) representing trust relationships `[[1,2], [2,3]]`.

**What the issue was:** Used `object[][] trust` as the type, but XanoScript doesn't support multi-dimensional array type syntax.

**Why it was an issue:** The validation error was:
```
[Line 5, Column 13] Expecting token of type --> Identifier <-- but found --> '[' <--
```

While the suggestion to use "json" was helpful, it wasn't immediately clear that `json` is the catch-all type for complex nested structures in XanoScript.

**Potential solution:** Document the type system more clearly - specifically that `json` should be used for nested arrays/objects.

---

## 2025-02-25 15:08 PST - response cannot be set inside conditional blocks

**What I was trying to do:** Set `response = 1` inside a conditional block to handle an edge case early return.

**What the issue was:** XanoScript doesn't allow `response` to be set inside a `stack` block at all - it must be at the function level.

**Why it was an issue:** The error message was:
```
[Line 11, Column 9] Expecting --> } <-- but found --> 'response' <--
```

This was confusing because it suggested a syntax error rather than a structural issue. I initially thought the problem was being inside a conditional, but the real issue was that `response` belongs outside the `stack` block entirely.

**Potential solution:** 
1. A clearer error message like "'response' must be defined at function level, not inside 'stack' block"
2. Or allow early returns via a `return` statement inside stack blocks

---

## 2025-02-25 15:12 PST - response placement confusion

**What I was trying to do:** Fix the response placement after learning it can't be inside conditionals.

**What the issue was:** Even after moving response outside the conditional, I still had it inside the `stack` block.

**Why it was an issue:** The error was the same confusing "Expecting } but found 'response'" message. Looking at the function quick reference:
```xs
function "<name>" {
  ...
  stack { ... }
  response = $result  // <-- This is outside stack!
}
```

The documentation shows this clearly, but it's easy to miss the nesting level when reading code examples.

**Potential solution:** An error message like "'response' should be at the same level as 'stack', not inside it" would help.

---

## General Observations

1. **Error messages** could be more contextual - instead of generic parser errors, explain XanoScript-specific constraints
2. **Type system** needs clearer documentation - what types exist and when to use `json` vs specific types
3. **Function structure** documentation is good in the quick reference, but perhaps emphasize the `response` placement more prominently
