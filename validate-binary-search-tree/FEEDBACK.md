# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 16:05 PST] - File paths with commas cause issues

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated paths

**What the issue was:** The MCP tool split the file_paths string on each character instead of treating it as an array

**Command:**
```
mcporter call xano.validate_xanoscript file_paths="~/xs/validate-binary-search-tree/run.xs,~/xs/validate-binary-search-tree/function/validate_bst.xs"
```

**Result:**
```
Validated 97 file(s): 0 valid, 97 invalid
File not found: ~
File not found: x
File not found: s
...
```

**Why it was an issue:** The tool treated each character as a separate file path instead of parsing the comma-separated values as an array

**Potential solution (if known):** 
- The MCP should properly parse array parameters when passed via CLI
- Alternative: Use `--args` JSON format for complex parameters
- Workaround: Use `directory` parameter instead for batch validation

---

## [2026-02-22 16:10 PST] - Nullable object syntax confusion

**What I was trying to do:** Define an input parameter as a nullable object with a schema for a binary tree structure

**What the issue was:** The `object?` syntax for nullable objects is not valid in XanoScript

**Code that failed:**
```xs
input {
  object tree {
    schema {
      int? val
      object? left { schema { } }
      object? right { schema { } }
    }
  }
}
```

**Error:**
```
[Line 9, Column 15] Expecting token of type --> Identifier <-- but found --> '?' <--
💡 Suggestion: Use "json" instead of "object"
```

**Why it was an issue:** The documentation wasn't clear about which types support nullable syntax (`?`)

**Potential solution (if known):**
- Document which types support the `?` nullable modifier
- Provide clearer examples of how to handle optional/nullable complex objects
- The `json` type works as a workaround but loses schema validation benefits

---

## [2026-02-22 16:15 PST] - Conditional syntax inside loops

**What I was trying to do:** Use an `if` statement inside a `while` loop's `each` block

**What the issue was:** Bare `if` statements are not allowed directly inside loop blocks — they must be wrapped in `conditional` blocks

**Code that failed:**
```xs
while (($current != null) || (($stack|count) > 0)) {
  each {
    if (($stack|count) > 0) {  // ERROR: Expecting '}' but found 'if'
      // ...
    }
  }
}
```

**Why it was an issue:** This is inconsistent with top-level usage where `if` can be used directly. The error message "Expecting '}' but found 'if'" was confusing — it didn't indicate that `conditional` was required.

**Potential solution (if known):**
- Better error message: "If statements inside loops must be wrapped in a 'conditional' block"
- Document the scope/context rules for `if` vs `conditional` more clearly
- Consider allowing bare `if` inside `each` blocks for consistency

---

## [2026-02-22 16:20 PST] - Documentation could use more recursion/tree examples

**What I was trying to do:** Implement a recursive tree traversal algorithm

**What the issue was:** XanoScript doesn't support recursive function calls (functions can't call themselves), so I had to use an iterative approach with an explicit stack

**Why it was an issue:** Most BST validation algorithms are naturally recursive. The lack of recursion support isn't clearly documented, and there are no examples of tree traversal or similar algorithms.

**Potential solution (if known):**
- Document that functions cannot call themselves recursively
- Provide examples of iterative algorithms for common tree/graph operations
- Add examples of stack-based traversal patterns

---

## [2026-02-22 16:25 PST] - No `break` or early return from loops

**What I was trying to do:** Exit the validation early once an invalid BST is detected

**What the issue was:** XanoScript doesn't have a `break` statement or early return mechanism. The loop continues even after `$is_valid` is set to false.

**Code attempted:**
```xs
if ($node_val <= $prev_val) {
  var.update $is_valid { value = false }
  // Wanted to break here, but no break statement available
}
```

**Why it was an issue:** Inefficient — we continue traversing the entire tree even after finding a violation. For large trees, this wastes computation.

**Potential solution (if known):**
- Add a `break` statement for loops
- Add an early `return` mechanism within functions
- Document workarounds (e.g., using complex while conditions)

---

## General Feedback

### Positive
- The validation tool provides helpful line/column numbers
- The suggestion to use `json` instead of `object` was useful
- The directory-based validation is convenient once discovered

### Suggestions for Improvement
1. **Better array parameter handling** in the MCP CLI interface
2. **More consistent conditional syntax** — either always require `conditional` or always allow bare `if`
3. **Clearer documentation** on nullable type modifiers
4. **Recursion documentation** — explicitly state it's not supported
5. **Control flow improvements** — add `break`/`continue` for loops
