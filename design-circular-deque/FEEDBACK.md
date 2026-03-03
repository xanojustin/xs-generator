# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 11:02 PST] - Input Parameter Syntax Confusion

**What I was trying to do:** Define input parameters with filters (min:1) and optional flag

**What the issue was:** I incorrectly assumed XanoScript uses `filters = "min:1"` and `optional = true` inside the `{ }` block of input parameters, similar to other declarative languages.

**Why it was an issue:** The validator reported:
- "The argument 'filters' is not valid in this context"
- "The argument 'optional' is not valid in this context"

This blocked me from creating valid code until I looked up the correct syntax in the types documentation.

**Potential solution:**
1. The MCP could provide more helpful error messages suggesting the correct syntax
2. The docs could have a clearer example showing the difference between:
   - `int capacity { description = "..." }` - basic required parameter
   - `int capacity filters=min` - with filters (if this is valid?)
   - `int? value?` - optional nullable parameter
   - `int value?` - optional non-nullable parameter

The `?` syntax is elegant but not immediately discoverable from the error messages alone.

---

## [2026-03-03 11:05 PST] - Documentation Discovery

**What I was trying to do:** Find the correct syntax for input parameters

**What the issue was:** Had to call `xanoscript_docs topic="types"` to find the correct syntax. The initial "functions" topic quick reference didn't include the input parameter modifier syntax.

**Why it was an issue:** It took an extra MCP call and some reading to find the specific syntax for optional parameters (the `?` suffix).

**Potential solution:** 
1. Include a brief note about the `?` modifier syntax in the "functions" quick reference
2. Or have the validator error message link to the relevant documentation topic

---

## [2026-03-03 11:08 PST] - Design Problem State Management

**What I was trying to do:** Implement a design problem (circular deque) that requires maintaining state across multiple operations

**What the issue was:** XanoScript functions are stateless - each call is independent. For a design problem like this, the state needs to be either:
1. Passed in and out with each operation (what I ended up doing conceptually)
2. Stored in a database table
3. Stored in Redis/cache

**Why it was an issue:** The classic LeetCode-style "design" problems assume object-oriented patterns where you create an instance and call methods on it. Translating this to XanoScript's functional style requires a different approach.

**Potential solution:**
The exercise is still valuable for demonstrating the algorithm, but future design exercises might need clearer guidance on how to handle state in XanoScript. The MCP could potentially offer a "design pattern" guide for common OOP-to-XanoScript translations.

---

## General Notes

The validation tool worked well - it caught syntax errors immediately and helped me iterate quickly. The error messages were specific about line numbers and what was wrong. The main friction was understanding the correct syntax patterns, which improved once I found the right documentation topics.

The MCP server itself was responsive and the documentation was comprehensive once I knew which topics to query.
