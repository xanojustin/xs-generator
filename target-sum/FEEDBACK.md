# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 06:05 PST] - Unary Minus Operator Not Supported

**What I was trying to do:** Write a condition to check if target is outside the valid range using `-total` for negation.

**What the issue was:** XanoScript parser doesn't support unary minus operator. Writing `-$total` causes a parse error.

**Why it was an issue:** This is a common mathematical operation that most languages support. I had to work around it by using `0 - $total` instead, which is less intuitive.

**Potential solution:** Support unary minus operator in expressions, or at least document this limitation clearly with examples of the workaround.

---

## [2025-02-28 06:08 PST] - Array Length Filter Name Confusion

**What I was trying to do:** Get the length of an array using the `|length` filter.

**What the issue was:** The filter is named `|count` not `|length`. The error message suggested using "int" instead of "integer" which was misleading - the real issue was the wrong filter name.

**Why it was an issue:** Most languages use `.length`, `.size()`, or `|length` for array/string length. `|count` is non-obvious and the error message was confusing.

**Potential solution:** 
1. Add `|length` as an alias for `|count` for better developer experience
2. Improve error messages to suggest the correct filter name

---

## [2025-02-28 06:10 PST] - While Loop Syntax Unclear

**What I was trying to do:** Write a while loop to iterate until a condition is met.

**What the issue was:** While loops require an `each { ... }` block inside them, but this isn't documented in the basic syntax reference I retrieved.

**Why it was an issue:** The syntax `while (condition) { each { ... } }` is unusual. Most languages use `while (condition) { ... }` directly. The error message just said "expecting 'each'" without explaining why.

**Potential solution:** 
1. Document while loop syntax clearly with examples
2. The error message could be more helpful: "While loops require an 'each' block. Example: while (condition) { each { ... } }"

---

## [2025-02-28 06:12 PST] - var vs var.update Inside Loops

**What I was trying to do:** Update a counter variable inside a while loop.

**What the issue was:** Initially used `var $i { value = $i + 1 }` to update the counter, but this creates a new variable scope. Need to use `var.update $i { value = $i + 1 }` to modify the existing variable.

**Why it was an issue:** This distinction isn't obvious from the documentation. The error wasn't caught by validation but would cause infinite loops or incorrect behavior at runtime.

**Potential solution:** 
1. Document the difference between `var` (create) and `var.update` (modify)
2. Consider a linter warning when `var` shadows an existing variable in the same scope

---

## [2025-02-28 06:15 PST] - MCP Tool Parameter Format

**What I was trying to do:** Call the validate_xanoscript tool with a file path.

**What the issue was:** The parameter format wasn't immediately clear. Tried JSON format first (`'{"file_path": "..."}'`) which didn't work, then `--file_path` which also didn't work. Finally found that `file_path="..."` works.

**Why it was an issue:** Inconsistent parameter passing style compared to other tools. The `mcporter describe` output showed example as `file_path: "..."` but that syntax didn't work.

**Potential solution:** 
1. Standardize parameter format across all MCP tools
2. Provide clear examples in the tool description
3. Support both positional and named parameters consistently

---

## [2025-02-28 06:20 PST] - Documentation Completeness

**What I was trying to do:** Find detailed documentation on XanoScript syntax for loops, conditionals, and variable operations.

**What the issue was:** The `xanoscript_docs` tool returned generic README content for all topics (functions, run, syntax, essentials). Didn't get specific syntax details like while loop structure.

**Why it was an issue:** Had to infer correct syntax by reading existing code examples in the `~/xs/` directory rather than from documentation.

**Potential solution:** 
1. Ensure topic-specific documentation returns detailed syntax information
2. Include complete code examples for each construct (if/elseif/else, while, foreach, etc.)
3. Document all available filters with examples

---

## General Observations

**What worked well:**
- The validation tool provides helpful line/column information
- Error messages sometimes include helpful suggestions
- The overall structure of function + run job is clear

**Areas for improvement:**
- More comprehensive syntax documentation
- Consistent error messages with examples
- Support for common language features (unary operators)
