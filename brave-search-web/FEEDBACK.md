# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 11:45 PST] - Optional Chaining and Nullish Coalescing Not Supported

**What I was trying to do:**
Write a clean, modern function to process Brave Search API results, extracting nested data like `$search_data.web?.results ?? []`

**What the issue was:**
I used JavaScript-style optional chaining (`?.`) and nullish coalescing (`??`) operators which are not valid in XanoScript. The validator returned:
```
[Line 46, Column 53] Expecting: one of these possible Token sequences: ... but found: '.'
```

**Why it was an issue:**
These operators are common in modern JavaScript/TypeScript and are very convenient for handling nested API responses. Not having them means writing verbose conditional blocks with `get` filters to safely access nested properties.

**Potential solution (if known):**
Either:
1. Add support for `?.` and `??` operators to XanoScript (would be a significant syntax enhancement)
2. Document clearly in the quickstart/common mistakes section that these operators are NOT supported
3. Provide a helper function or filter for safe nested property access

---

## [2026-02-17 11:50 PST] - Unclear How to Build Arrays Iteratively

**What I was trying to do:**
Map/transform an array of search results into a new formatted array

**What the issue was:**
I initially tried using the `map` filter with an object literal, but couldn't find clear documentation on the correct syntax for transforming objects within a map. I ended up using a `foreach` loop with `push` filter to build the array incrementally.

**Why it was an issue:**
The documentation mentions the `map` filter but doesn't show complex examples of object transformation. I wasn't sure if I could use `$$` to reference the current item within an object literal inside a map.

**Potential solution (if known):**
Add more comprehensive examples to the quickstart showing:
- How to map an array of objects to a different shape
- How to handle nested property access within maps
- Best practices for array transformation (map filter vs foreach loops)

---

## [2026-02-17 11:55 PST] - Filter Syntax for Parenthesized Expressions

**What I was trying to do:**
Concatenate filtered values in string expressions

**What the issue was:**
Remembering to wrap filter expressions in parentheses when using them in string concatenation or comparisons. I initially wrote `$web_results|count` without parentheses in some contexts.

**Why it was an issue:**
While the quickstart does mention this, it's easy to forget. The error messages when you get it wrong aren't always clear about the actual problem.

**Potential solution (if known):**
The quickstart already covers this well - perhaps the linter could provide a more helpful error message suggesting parentheses when it detects a filter in an expression context.

---

## [2026-02-17 12:00 PST] - Get Filter Default Values

**What I was trying to do:**
Safely access nested object properties with fallbacks

**What the issue was:**
I had to experiment to confirm the correct syntax for the `get` filter with default values. The docs show `$obj|get:"key":"default"` but I wasn't sure if null vs empty string handling worked as expected.

**Why it was an issue:**
API responses often have missing or null fields, and safe property access is critical. The `get` filter works well but more examples would help.

**Potential solution (if known):**
Add a section to the quickstart specifically about "Safe Property Access" showing:
- Using `get` with defaults
- Handling null vs empty string vs missing key
- Checking if a key exists before accessing

---

## [2026-02-17 12:05 PST] - Variable Update Pattern Not Intuitive

**What I was trying to do:**
Append items to an array inside a foreach loop

**What the issue was:**
The `var.update` syntax requires referencing the variable name twice - once as the target and once to get the current value for the expression. This feels clunky:
```
var.update $formatted_results { value = $formatted_results|push:$formatted_item }
```

**Why it was an issue:**
It's verbose and easy to make mistakes. I had to re-read the documentation to remember the pattern.

**Potential solution (if known):**
Consider a shorter syntax like:
```
var.update $formatted_results { value = $value|push:$formatted_item }
// where $value automatically refers to the variable being updated
```
Or document this pattern more prominently with a "Building Arrays" example.

---

## General Observations

### What's Working Well
- The MCP validation tool is fast and helpful
- Error messages include line and column numbers
- The documentation structure is good with topic-based organization
- The quickstart's "Common Mistakes" section is very valuable

### Suggestions for Documentation
1. **More complete API integration examples** - Show full patterns for common APIs
2. **Filter reference with all options** - A complete list of all available filters
3. **Object manipulation patterns** - Deep dive on working with nested objects
4. **JSON response handling** - Best practices for API response parsing

### MCP Tool Feedback
- The `xanoscript_docs` tool works well but sometimes returns very long responses
- A `mode=compact` option for quick syntax lookup would be useful
- The `validate_xanoscript` tool is excellent - fast and accurate
