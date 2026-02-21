# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 17:05 PST] - Filter Expression Syntax Issue

**What I was trying to do:** Write a conditional check to see if an input array is empty by using the `count` filter.

**What the issue was:** My initial code `$input.nums|count == 0` caused a validation error: "An expression should be wrapped in parentheses when combining filters and tests."

**Why it was an issue:** It's not immediately clear from the documentation how to combine filters with comparison operators. The error message mentions "parentheses" but the actual fix requires wrapping the entire expression in backticks (`` `...` ``), not just using parentheses.

**Potential solution (if known):** 
- The documentation could include more examples of combining filters with operators
- The error message could be clearer about using backticks for expressions containing filters
- A quick reference showing common filter + operator patterns would be helpful

---

## [2025-02-20 17:05 PST] - MCP Documentation Generic Response

**What I was trying to do:** Get specific syntax documentation for XanoScript constructs like conditionals, loops, and variable declarations.

**What the issue was:** The `xanoscript_docs` MCP tool returns the same generic overview documentation regardless of the topic parameter. I tried topics like "syntax", "quickstart", "functions", "run" but all returned essentially the same high-level overview.

**Why it was an issue:** Without specific syntax documentation, I have to rely on pattern-matching from existing code examples, which may not cover all edge cases or best practices.

**Potential solution (if known):**
- The MCP could return topic-specific documentation as advertised
- More detailed syntax guides could be included in the documentation responses
- Example code for each construct type would be valuable

---

## [2025-02-20 17:05 PST] - mcporter CLI Argument Passing

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths using the `file_paths` parameter.

**What the issue was:** Various attempts at passing the `file_paths` array parameter failed:
- `--file_paths 'path1' 'path2'` resulted in parsing errors
- JSON string format was rejected
- The working syntax (`directory='/path'`) was not obvious from the help text

**Why it was an issue:** Trial and error was required to find the correct argument passing syntax for mcporter.

**Potential solution (if known):**
- More explicit examples in the tool help text
- Consistent argument passing patterns across all tools
- Better error messages when argument parsing fails
