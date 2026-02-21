# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 09:35 PST] - Run job syntax confusion

**What I was trying to do:** Create a run.job that calls a function with test inputs

**What the issue was:** I assumed `run.job` would have the same structure as `function` with a `stack` block and `function.run` calls. Instead, `run.job` uses a completely different syntax with `main = { name: "...", input: {...} }`.

**Why it was an issue:** The validation error messages were confusing - they said `'description' is not valid in this context` and `'stack' is not valid in this context` without explaining what the valid structure should be. I had to look at existing examples to understand the correct pattern.

**Potential solution:** The error message could suggest the correct syntax: "run.job does not support 'stack'. Use 'main = { name: \"function_name\", input: {...} }' instead."

---

## [2025-02-21 09:38 PST] - Array iteration syntax unclear

**What I was trying to do:** Iterate through an array of Roman numeral mappings using `each ($mappings as $mapping)`

**What the issue was:** The syntax `each ($array as $item)` is not valid in XanoScript. The validation error said `Expecting --> } <-- but found --> 'each'` which was confusing.

**Why it was an issue:** I was trying to use a common pattern from other languages (PHP, JavaScript, etc.) that doesn't exist in XanoScript. The documentation mentions `each` but doesn't clearly show how to iterate arrays.

**Potential solution:** 
1. Add a clear example of array iteration to the syntax documentation
2. Provide a better error message like "Array iteration with 'each ($array as $item)' is not supported. Use 'foreach' or index-based access instead."

---

## [2025-02-21 09:40 PST] - Nested while inside each not supported

**What I was trying to do:** Use a `while` loop inside an `each` block for nested iteration

**What the issue was:** XanoScript doesn't support nested `while` loops inside `each` blocks. The parser expects `each` to have a specific structure.

**Why it was an issue:** I needed nested iteration for the Roman numeral algorithm (iterate through value mappings, then subtract repeatedly). The error message `Expecting --> each <-- but found --> '}'` was cryptic.

**Potential solution:** 
1. Document the limitation clearly: "each blocks cannot contain while loops"
2. Provide an alternative pattern in the error message or documentation

---

## [2025-02-21 09:42 PST] - While loop body requires "each" wrapper

**What I was trying to do:** Execute multiple statements inside a `while` loop

**What the issue was:** In XanoScript, a `while` loop body that contains multiple statements must wrap them in an `each` block. This is unusual and not immediately obvious.

**Why it was an issue:** Looking at the fizzbuzz example, I saw `while (...) { each { ... } }` but didn't understand why the `each` was needed. It seems like `each` is used as a "block" construct for multiple statements.

**Potential solution:** 
1. Document this pattern clearly in the quickstart guide
2. Consider allowing multiple statements directly in while loops (like most other languages)

---

## General Feedback

**Documentation gaps:**
1. The difference between `run.job` and `function` syntax needs to be more prominent
2. Array iteration patterns need clearer examples
3. The relationship between `while` and `each` needs better explanation

**Error message improvements:**
1. When an invalid property is used, suggest valid alternatives
2. When syntax is invalid, provide context about what the parser expected
3. Link to relevant documentation topics in error messages

**MCP tool feedback:**
The `validate_xanoscript` tool works well and provides helpful suggestions. The `xanoscript_docs` tool is useful but could benefit from:
1. More cross-referencing between related topics
2. A "common patterns" section that shows how different constructs work together
