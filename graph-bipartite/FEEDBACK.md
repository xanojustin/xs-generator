# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-03-03 01:05 PST - Nested Array Type Syntax Error

**What I was trying to do:** Define a function input for a 2D array (adjacency list for graph)

**What the issue was:** Used `object[][] graph` as the type, which resulted in parser error: "Expecting token of type --> Identifier <-- but found --> '['"

**Why it was an issue:** XanoScript doesn't support nested array type syntax like `object[][]`. The error message suggests using "type[]" but doesn't clarify that nested types like `object[]` are the limit.

**Potential solution:** The error message could be improved to say something like "Nested array types are not supported. Use 'json' type for multi-dimensional arrays."

---

## 2026-03-03 01:08 PST - Comment in run.job input causing parse error

**What I was trying to do:** Add a comment inside the run.job input object to document the test case

**What the issue was:** The validator gave cryptic error: "Expecting: Expected an object {} but found: '{'" which didn't clearly indicate that comments aren't allowed in input objects

**Why it was an issue:** The error message was misleading - it made me think there was a syntax error with the object structure, when really it was just the comment

**Potential solution:** Either:
1. Allow comments in input objects (preferred)
2. Provide a clearer error message like "Comments are not allowed in run.job input objects"

---

## 2026-03-03 01:15 PST - Filter expression parentheses requirement

**What I was trying to do:** Use `$input.graph|count` inside a range expression and `$queue|count > 0` in a while loop

**What the issue was:** Got error "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The error message is helpful but doesn't specify exactly which part needs parentheses. I had to guess whether to wrap the entire expression, just the filter, or the comparison.

**Resolution:** Needed to wrap just the filter part: `($input.graph|count)` and `($queue|count)`

**Potential solution:** The error could suggest the exact fix: "Try wrapping the filter expression in parentheses: '($input.graph|count)'"

---

## General Observation: Two Syntax Styles

I noticed there's an inconsistency in the codebase - some older files use `array.push` and `math.add` while newer files use `var.update` with filters like `|push:` and `+` operators. This is a bit confusing when looking for examples.

**Potential solution:** Consider providing a migration guide or deprecation notices for the older syntax style.
