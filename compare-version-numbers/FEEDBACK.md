# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 06:05 PST] - Filter name confusion: `length` vs `count`

**What I was trying to do:** Get the length of an array to compare version segment counts

**What the issue was:** I assumed the filter was called `length` (common in many languages), but XanoScript uses `count` for arrays. The error message was helpful but the suggestion mentioned "Use 'text' instead of 'string' for type declaration" which was unrelated to my actual issue.

**Why it was an issue:** Had to make multiple validation attempts to discover the correct filter name. The `count` filter was only visible in the quick_reference documentation under "Common Filters".

**Potential solution (if known):** 
- Include `count` in the error suggestion when `length` is used on an array
- Or provide a "Did you mean 'count'?" hint

---

## [2026-02-23 06:05 PST] - Logical operator confusion: `and` vs `&&`

**What I was trying to do:** Write a while loop with a compound condition checking two conditions

**What the issue was:** I used `and` (Python-style) instead of `&&` (C-style). The parser error "Expecting --> ) <-- but found --> 'and' <--" was somewhat helpful but didn't suggest the correct operator.

**Why it was an issue:** Without the syntax documentation, I wouldn't have known which logical operators are valid in XanoScript. Many languages use different conventions (Python: `and`/`or`, JS: `&&`/`||`, SQL: `AND`/`OR`).

**Potential solution (if known):**
- Include a "Did you mean '&&'?" suggestion in the error message
- Or list valid logical operators in the error context

---

## [2026-02-23 06:06 PST] - Type conversion filter confusion: `int` vs `to_int`

**What I was trying to do:** Convert a string segment to an integer for numeric comparison

**What the issue was:** I assumed the filter was `int` but it's actually `to_int`. This follows a pattern (`to_text`, `to_int`, `to_bool`) but the error only said "Unknown filter function 'int'" without suggesting alternatives.

**Why it was an issue:** Had to search through the full syntax documentation to find the correct filter name.

**Potential solution (if known):**
- Suggest `to_int` when `int` filter is not found
- Document common filter naming patterns more prominently

---

## [2026-02-23 06:04 PST] - Filter precedence with parentheses

**What I was trying to do:** Compare the result of a filter operation: `$v2_parts|count > $max_len`

**What the issue was:** Filters bind greedily to the left, so the parser was trying to use `count > $max_len` as a filter argument. The error message "An expression should be wrapped in parentheses when combining filters and tests" was actually very helpful!

**Why it was an issue:** This is a common gotcha - many languages don't have this filter binding behavior.

**Potential solution (if known):** The current error message is good, but perhaps add an example showing the correct syntax: `if (($arr|count) > 0)`

---

## General Observations

**What worked well:**
- The MCP server was easy to install via npm
- The `validate_xanoscript` tool gave precise line/column error locations
- The `xanoscript_docs` tool with `quick_reference` mode was very helpful
- Error messages generally included helpful suggestions

**Areas for improvement:**
1. **Filter discovery:** A complete filter reference or "Did you mean?" suggestions would reduce trial-and-error
2. **Operator documentation:** The quick reference doesn't list logical operators (`&&`, `||`, `!`) - had to search full docs
3. **Syntax examples:** More examples of complex expressions with filters would be helpful
