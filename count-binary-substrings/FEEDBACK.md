# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 03:05 PST] - Parentheses Required for Filter Expressions in Comparisons

**What I was trying to do:** Write a condition that checks if the length of a string is less than or equal to 1: `if ($input.binary_string|strlen <= 1)`

**What the issue was:** The validation failed with error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This syntax requirement wasn't immediately obvious from reading the examples. I had to wrap the filter expression in parentheses: `(($input.binary_string|strlen) <= 1)`

**Potential solution (if known):** 
- The error message was clear and helpful, suggesting exactly what to do
- It would be useful if the documentation had a specific section on "Filter Expression Precedence" that explains when parentheses are required
- Alternatively, the syntax could be more forgiving and auto-wrap simple filter expressions

---

## [2026-03-01 03:05 PST] - Documentation Discovery

**What I was trying to do:** Find specific syntax documentation for XanoScript, particularly for run jobs and function definitions

**What the issue was:** The `xanoscript_docs` topic parameter returns high-level summaries rather than detailed syntax reference. I had to look at existing code examples in `~/xs/` to understand the actual syntax patterns.

**Why it was an issue:** Without existing examples in the repo, I wouldn't have known:
- The exact structure for `run.job` blocks
- How to use `function.run` or the `main = { name: ..., input: ... }` pattern
- How to structure function inputs with the `input { type name { ... } }` pattern

**Potential solution (if known):**
- A `syntax/functions` or `syntax/run-jobs` topic with specific grammar/syntax definitions would be helpful
- Include complete working examples in each topic documentation
- The MCP tool schema shows there is a `syntax/functions` topic but when I called it, I got the same overview content

---

## [2026-03-01 03:05 PST] - String Indexing Not Clear

**What I was trying to do:** Access individual characters in a string by index: `$input.binary_string[$i]`

**What the issue was:** I assumed this would work based on typical programming languages, but I wasn't 100% certain if XanoScript supports direct string indexing or if I needed to use `split:""` first.

**Why it was an issue:** The validation passed, so it seems to work, but the documentation didn't clearly confirm this was valid syntax.

**Potential solution (if known):**
- Include a section on string indexing in the string-filters documentation
- Clarify whether strings are treated as arrays of characters or if there's a conversion happening

---

## [2026-03-01 03:05 PST] - Ternary Operator Works Well

**What I was trying to do:** Use a conditional expression to get the minimum of two values

**What the issue was:** None - the ternary operator `$prev_length < $curr_length ? $prev_length : $curr_length` worked on the first try

**Why it was an issue:** N/A - positive feedback

**Potential solution (if known):**
- The ternary operator syntax is intuitive and worked as expected
- Would be good to document this explicitly in the syntax reference

---

## [2026-03-01 03:05 PST] - MCP Tool Works Well

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** None - the tool worked great and provided helpful error messages with line/column numbers

**Why it was an issue:** N/A - positive feedback

**Potential solution (if known):**
- The error messages are clear and actionable
- The suggestion to use `file_paths` instead of `files` parameter was helpful
- The validation is fast and accurate
