# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 16:35 PST] - Issue Title: Cannot use `response =` inside conditional blocks

**What I was trying to do:** Return early from a function when handling an edge case (single element array)

**What the issue was:** I tried to use `response = 0` inside a `conditional { if () { ... } }` block, which resulted in error: `Expecting --> } <-- but found --> 'response' <--`

**Why it was an issue:** This is a common pattern in many languages (early return), but XanoScript doesn't support setting the response inside the stack. The `response =` must be at the function level, outside the stack block.

**Potential solution (if known):** 
- Document this more clearly in the quickstart guide
- Consider supporting early returns or `response =` inside conditionals for cleaner code
- Alternative pattern: Use a result variable that gets set inside conditionals, then return it at the end

---

## [2025-02-24 16:35 PST] - Issue Title: Filter expressions in conditionals need clarification

**What I was trying to do:** Check if array length equals 1 using `$input.nums|count == 1`

**What the issue was:** The validation error said `An expression should be wrapped in parentheses when combining filters and tests`

**Why it was an issue:** The error message suggests wrapping in parentheses, but the real issue is that you can't use filters directly in conditional expressions. The solution is to store the filtered value in a variable first, then use that variable in the conditional.

**Potential solution (if known):**
- Clarify the error message to say something like "Filters cannot be used directly in conditional expressions. Store the result in a variable first."
- Or allow filters in conditionals by auto-wrapping them

---

## [2025-02-24 16:35 PST] - Issue Title: mcporter argument format confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with a directory parameter

**What the issue was:** I initially tried using JSON format like `'{"directory": "."}'` but mcporter expects `key:value` format like `directory:.`

**Why it was an issue:** The documentation shows JSON examples but mcporter actually uses key:value pairs. This inconsistency made it harder to figure out the right syntax.

**Potential solution (if known):**
- Update documentation to consistently show the key:value format for mcporter CLI
- Or support both formats

---

## [2025-02-24 16:35 PST] - Issue Title: Lack of detailed syntax documentation in MCP

**What I was trying to do:** Learn about array operations, variable scoping, and control flow patterns in XanoScript

**What the issue was:** The `xanoscript_docs` function gives high-level documentation but lacks specific syntax details for:
- How to properly declare and update variables
- Array indexing syntax
- Filter usage patterns
- Conditional block patterns

**Why it was an issue:** Had to examine existing code examples to understand the correct patterns instead of having clear documentation.

**Potential solution (if known):**
- Add a `syntax` topic with detailed examples for all control flow patterns
- Include a complete list of available filters and their usage
- Provide more example implementations for common patterns

---

## [2025-02-24 16:35 PST] - Positive Feedback: Good error messages

**What worked well:** When validation failed, the error messages included:
- Line and column numbers
- Clear description of what was expected vs what was found
- The actual code that caused the error
- Helpful suggestions (like using "int" instead of "integer")

This made debugging much faster than it would have been otherwise.

---
