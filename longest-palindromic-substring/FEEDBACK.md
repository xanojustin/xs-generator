# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 12:35 PST] - MCP Documentation Topics Return Same Content

**What I was trying to do:** Get specific documentation about XanoScript syntax, functions, and run jobs by calling `xanoscript_docs` with different topics.

**What the issue was:** All topic queries (`quickstart`, `functions`, `tasks`, `syntax`, `run`) returned identical high-level index content instead of detailed documentation for each topic.

**Why it was an issue:** I had to inspect existing implementation files to learn the correct syntax patterns instead of relying on the MCP documentation. This was time-consuming and error-prone.

**Potential solution:** The MCP should return topic-specific detailed documentation when queried, or the documentation index should be removed if not implemented.

---

## [2025-02-21 12:40 PST] - Unknown Filter 'substring'

**What I was trying to do:** Extract a substring from a string using the `substring` filter, which is a common name in many programming languages.

**What the issue was:** The validator reported `Unknown filter function 'substring'`. I had to search existing code to discover that XanoScript uses `substr` instead.

**Why it was an issue:** The error message didn't suggest the correct filter name. I had to grep through existing files to find `substr` being used in other functions like `caesar-cipher` and `count-vowels`.

**Potential solution:** 
1. Add `substring` as an alias for `substr` for better developer experience
2. Include a "Did you mean 'substr'?" suggestion in the error message
3. Document common filter names in the MCP response

---

## [2025-02-21 12:42 PST] - No Early Return Pattern

**What I was trying to do:** Handle an edge case (empty string) by returning early from the function using `response = ""` inside a conditional block.

**What the issue was:** XanoScript doesn't support early returns. The validator gave the cryptic error: `Expecting --> } <-- but found --> 'response' <--`.

**Why it was an issue:** The error message wasn't clear about what was wrong. I had to examine other functions to see that `response` is only set once at the end of the `stack` block. This required restructuring the entire function logic to use if/else instead of early return.

**Potential solution:**
1. Improve the error message to say something like "response cannot be set inside conditional blocks - move to end of stack"
2. Document this constraint clearly in the MCP docs
3. Consider supporting early returns for cleaner code

---

## [2025-02-21 12:45 PST] - Filter Expressions Need Parentheses

**What I was trying to do:** Use a filter in a conditional expression: `if ($input.s|strlen == 0)`.

**What the issue was:** The validator required parentheses around the expression: `if (($input.s|strlen) == 0)` or similar wrapping.

**Why it was an issue:** The error message "An expression should be wrapped in parentheses when combining filters and tests" was helpful, but it wasn't clear exactly what needed parentheses. I had to experiment with different placements.

**Potential solution:** The error message could show the suggested fix with proper parentheses placement.

---

## General Observations

1. **Validation tool works well** - The directory validation is convenient and catches errors quickly.
2. **Error messages are helpful** - The line/column numbers and code snippets make debugging easier.
3. **Suggestion system is nice** - The "Use 'text' instead of 'string'" type suggestions prevent common mistakes.
4. **MCP tool availability is good** - The `validate_xanoscript` tool was immediately available and functional.
