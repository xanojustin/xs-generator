# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 17:35 PST] - Issue 1: 2D Array Type Syntax Unclear

**What I was trying to do:** Define an input parameter for a 2D integer array (triangle structure)

**What the issue was:** Used `int[][] triangle` syntax which is common in many languages (Java, C++, TypeScript), but XanoScript doesn't support this syntax

**Why it was an issue:** The error message "Use 'type[]' instead of 'array'" was a bit confusing because I wasn't using the word "array" - I was using `int[][]`. It took me a moment to realize that XanoScript doesn't support multi-dimensional array type declarations at all.

**Potential solution (if known):** 
- The documentation could explicitly state that multi-dimensional arrays like `int[][]` or `text[][]` are not supported
- Suggest using `json` type for nested array structures instead
- The error message could be more specific: "Multi-dimensional array types like int[][] are not supported. Use 'json' type for nested arrays."

---

## [2026-02-25 17:37 PST] - Issue 2: Input Field Description Syntax Inconsistent

**What I was trying to do:** Add a description to an input field using inline syntax: `json triangle description="..."`

**What the issue was:** The parser expected the closing brace `}` after the field name, but found `description` instead. The correct syntax requires braces around the description: `json triangle { description = "..." }`

**Why it was an issue:** The quick reference shows the syntax as `<type> <name> [filters=...] { description = "..." }`, but it's easy to miss that the description must be inside braces. Coming from other languages where inline attribute syntax is common, this felt unintuitive.

**Potential solution (if known):**
- Add a more prominent example in the quickstart showing the correct description syntax
- The error message could suggest the correct syntax: "Description must be inside braces: `{ description = \"...\" }`"
- Consider allowing inline syntax like `json triangle description="..."` for consistency with other attribute declarations

---

## [2026-02-25 17:40 PST] - Issue 3: Filter Expressions in Conditionals Need Backticks

**What I was trying to do:** Use a filter in an if condition: `if ($input.triangle|count == 0)`

**What the issue was:** When combining filters with comparison operators in conditionals, the expression must be wrapped in backticks: ``if (`$input.triangle|count == 0`)``

**Why it was an issue:** This is a subtle syntax rule that's easy to forget. The error message "An expression should be wrapped in parentheses when combining filters and tests" was helpful but said "parentheses" when backticks are actually required. I tried parentheses first which didn't work, then remembered backticks from the quickstart examples.

**Potential solution (if known):**
- Update the error message to say "backticks" instead of "parentheses" since that's what the syntax actually requires
- Add a dedicated section in the quickstart about "Expressions with Filters" showing this pattern clearly
- Example: ``if (`$array|count > 0`)`` vs `if ($array|count > 0)` (wrong)

---

## [2026-02-25 17:42 PST] - Issue 4: Response Placement in Function Body

**What I was trying to do:** Return a value from a function by placing `response = $dp[0]` inside the `stack` block

**What the issue was:** The `response` assignment must be outside the `stack` block, at the same level as `input` and `stack`

**Why it was an issue:** This is different from many programming languages where the return statement is inside the function body. The function structure has `stack { ... }` for logic and then `response = ...` after it, which wasn't immediately obvious from the structure.

**Potential solution (if known):**
- The error message "Expecting '}' but found 'response'" was somewhat helpful but could be more specific
- Consider adding a note in the quick reference: "⚠️ Note: `response` must be outside the `stack` block"
- The function documentation example shows this correctly, but it's easy to miss when quickly scanning

---

## General Feedback

### MCP Tool Experience
- The `validate_xanoscript` tool worked well and provided helpful error messages with line/column numbers
- The suggestions in error messages were generally useful
- Having the actual code snippet in the error output was very helpful for debugging

### Documentation Feedback
- The quickstart is great for getting started but some edge cases (like filters in conditionals) could be more prominent
- A "Common Mistakes" section in the quickstart would be valuable
- The distinction between `input { ... }` field syntax and the `stack { ... }` / `response` structure could be visually emphasized

### Suggestions for XanoScript
1. Consider allowing `json[]` for arrays of JSON objects (if not already supported)
2. The backtick requirement for filter expressions in conditionals feels like a parser limitation rather than a feature - could this be made more seamless?
3. Allowing descriptions inline (like `text name description="User name"`) would feel more natural alongside `filters=trim`
