# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 13:05 PST] - Issue: Nested array types not supported

**What I was trying to do:** Define input parameters for a function that accepts arrays of string pairs (equations like `[["a", "b"], ["b", "c"]]`)

**What the issue was:** Used `text[][]` syntax thinking it would create a nested array type, but XanoScript doesn't support this syntax. Got error: `Expecting token of type --> Identifier <-- but found --> '['`

**Why it was an issue:** Had to change approach and use `json` type instead, which loses type safety and clear documentation of the expected structure.

**Potential solution:** Document more clearly what array types are supported. Consider supporting `type[]` for nested arrays or document that `json` should be used for complex nested structures.

---

## [2025-03-01 13:08 PST] - Issue: run.job syntax documentation confusion

**What I was trying to do:** Create a run.job that calls a function with test inputs

**What the issue was:** Initially wrote the run.job as a direct code block with `function.run` inside, similar to how functions work. Got error: `Expecting: one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'`

**Why it was an issue:** The quick_reference docs for `run` were minimal and didn't clearly show the `main = { name: "...", input: {...} }` syntax. Had to fetch the full docs to understand the correct structure.

**Potential solution:** The quick_reference for `run` could include a complete minimal example showing the `main` property syntax.

---

## [2025-03-01 13:12 PST] - Issue: Description strings with nested quotes

**What I was trying to do:** Write descriptive documentation in the input block that included example JSON arrays like `[["a", "b"], ["b", "c"]]`

**What the issue was:** The parser failed on nested quotes inside description strings. Got errors about expecting commas or closing brackets.

**Why it was an issue:** Had to remove the helpful examples from descriptions, making the documentation less useful. No clear escaping mechanism was documented.

**Potential solution:** Document how to escape quotes in strings (if supported) or support different quote types (single vs double) for nesting.

---

## [2025-03-01 13:20 PST] - Issue: while loop syntax requires 'each' block

**What I was trying to do:** Implement a Union-Find algorithm with path compression using while loops to traverse up the parent chain

**What the issue was:** Wrote `while (condition) { var.update ... }` but the parser expected `each` keyword inside the while block. Got error: `Expecting --> each <-- but found --> '\n'`

**Why it was an issue:** The documentation in essentials shows `while` loops require an `each` block inside them, which is unusual syntax. This wasn't immediately clear from the error message.

**Diff of confusion:**
```xs
// What I tried (natural expectation):
while ($root_num != ($parent.value|get:$root_num)) {
  var $weight_num { value = $weight_num * (($weight.value|get:$root_num)) }
  var $root_num { value = $parent.value|get:$root_num }
}

// What actually works:
while ($root_num != ($parent.value|get:$root_num)) {
  each {
    var $weight_num { value = $weight_num * (($weight.value|get:$root_num)) }
    var $root_num { value = $parent.value|get:$root_num }
  }
}
```

**Potential solution:** 
1. The error message could be more helpful: "while loops require an 'each' block for their body"
2. The quick_reference for syntax could mention this requirement
3. Consider allowing direct statements in while loops for more intuitive syntax

---

## [2025-03-01 13:25 PST] - Issue: filter precedence confusion with parentheses

**What I was trying to do:** Compare the result of a filter operation, like `$parent.value|has:$num`

**What the issue was:** Initially wrote `!$parent.value|has:$num` which parses incorrectly due to filter precedence. Had to wrap in parentheses: `!($parent.value|has:$num)`

**Why it was an issue:** The documentation mentions filter precedence but the error messages when you get it wrong aren't always clear about what's happening.

**Potential solution:** The validation errors could detect common filter precedence issues and suggest adding parentheses.

---

## Summary

The Xano MCP validation tool was **extremely helpful** - it caught errors quickly and provided good error messages with line numbers. The main struggles were:

1. **Type system limitations** - No nested array types
2. **Syntax surprises** - while loops needing `each`, run.job structure
3. **String handling** - No clear quote escaping for descriptions
4. **Documentation gaps** - Some features only shown in full docs, not quick_reference

Overall the experience was positive - the validation feedback loop was fast and effective.
