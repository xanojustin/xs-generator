# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 13:20 PST] - Input Filters Syntax Confusion

**What I was trying to do:**
Create a function with input parameters that have filters applied (trim, lowercase, etc.)

**What the issue was:**
I initially wrote the filters as an array: `filters = ["trim", "to_lower"]` based on my incorrect assumption of XanoScript syntax. The validator returned errors:
- "The argument 'filters' is not valid in this context"
- "Expecting: Expected a null but found '['"

**Why it was an issue:**
This blocked validation and I had to re-read the documentation to understand the correct syntax. The error message about "Expected a null but found '['" was confusing - it didn't clearly indicate that filters use a pipe-delimited string format.

**Potential solution:**
A more helpful error message would be: "Filters must use pipe-delimited format: filters=trim|lower". Also, the quick reference could show a clearer example of input with filters.

---

## [2026-02-15 13:25 PST] - Filter + Comparison Expression Parentheses

**What I was trying to do:**
Validate that the subreddit input is not empty using: `$input.subreddit|count > 0`

**What the issue was:**
The validator error said: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:**
While the error message was somewhat clear, I had to guess the exact syntax. I wasn't sure if I needed `($input.subreddit|count > 0)` or `(($input.subreddit)|count > 0)` or something else.

**Potential solution:**
The error message could include the suggested fix: "Wrap the filtered expression in parentheses: ($input.subreddit|count) > 0"

---

## [2026-02-15 13:15 PST] - Documentation Discovery Time

**What I was trying to do:**
Understand the correct syntax for writing a run.job and function

**What the issue was:**
I had to make multiple calls to `xanoscript_docs` with different topics (run, quickstart, syntax, types, functions) to gather all the information needed. Each call returned different pieces of the puzzle.

**Why it was an issue:**
It took several iterations to find all the relevant documentation. The "run" topic gave me the job structure, but I needed "types" for input syntax, "functions" for function structure, and "syntax" for operators.

**Potential solution:**
Consider adding a "complete_example" or "tutorial" topic that shows a full working example with all components (run.job + function + inputs + API calls) in one place. This would be especially helpful for AI assistants trying to generate correct code quickly.

---

## [2026-02-15 13:30 PST] - No Default Filter Available

**What I was trying to do:**
Set default values for optional inputs in a clean way

**What the issue was:**
I tried to use a `default` filter like in other template languages: `$input.sort_by|default:"hot"`

**Why it was an issue:**
The documentation mentions "There is no `default` filter. Use conditional blocks or `first_notnull`/`first_notempty` instead." This requires more verbose code - I had to write a full conditional block to set defaults.

**Potential solution:**
Consider adding a `default` filter as it's a very common pattern in other languages (Liquid, Twig, Jinja2, etc.). It would make the code more concise: `var $sort { value = $input.sort_by|default:"hot" }`

---

## Overall Experience

**What worked well:**
- The `validate_xanoscript` tool was fast and helpful
- The documentation is comprehensive once you find the right topic
- The syntax is logical and consistent
- Error messages include line/column numbers which is great for debugging

**Areas for improvement:**
1. A single "getting_started" or "tutorial" topic with a complete working example
2. More helpful error messages that suggest the correct syntax
3. A `default` filter for cleaner default value handling
4. Maybe a topic index/listing to help discover what documentation is available

The MCP server itself worked reliably and the documentation was accurate. The main friction was in discovering the correct syntax patterns across multiple documentation calls.