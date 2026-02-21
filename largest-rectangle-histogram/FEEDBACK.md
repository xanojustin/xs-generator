# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 15:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Write XanoScript code that uses filters combined with comparison operators, specifically checking if a stack is empty using `$stack|count == 0` and accessing array elements with `$stack|last`.

**What the issue was:** The XanoScript validator rejected expressions like `$stack|count == 0` with the error: "An expression should be wrapped in parentheses when combining filters and tests." I had to wrap each filter expression in parentheses: `(($stack|count) == 0)`.

**Why it was an issue:** This syntax requirement wasn't immediately obvious from reading other examples. The error message was helpful in pointing to the solution, but it required 4 separate fixes across the file before validation passed. The pattern of needing double parentheses `((...))` around filter expressions in comparisons feels verbose compared to other languages.

**Potential solution (if known):** 
- Consider allowing implicit grouping for simple filter+comparison patterns like `$stack|count == 0`
- Or improve documentation to highlight this common pattern more prominently in the quickstart guide
- The existing "Common Mistakes" section in quickstart could include this case

---

## [2026-02-21 15:30 PST] - Documentation Topics Not Returning Full Content

**What I was trying to do:** Get detailed XanoScript documentation on specific topics like `quickstart`, `functions`, and `run` to understand syntax patterns before writing code.

**What the issue was:** When calling `xanoscript_docs` with topics like `quickstart`, `functions`, or `run`, the MCP returned the same general documentation overview rather than topic-specific detailed content. Multiple topic queries returned nearly identical content.

**Why it was an issue:** I expected topic-specific documentation to provide focused examples and patterns for the construct I was building (functions and run jobs), but instead got the same general reference each time. I had to rely on examining existing code examples in the `~/xs/` directory to understand the patterns.

**Potential solution (if known):**
- Ensure topic-specific queries return targeted content for that topic
- Or document that the general README is the primary reference and provide more standalone example files
- The `mode='quick_reference'` option could return more concise, syntax-focused examples

---

## [2026-02-21 15:28 PST] - Run Job Syntax Discovery

**What I was trying to do:** Understand the correct syntax for `run.job` constructs to create the entry point file.

**What the issue was:** The general documentation lists `run.job` as a construct but doesn't provide a clear syntax example for how to call a function from within a run job. I had to inspect existing implementations like `~/xs/two-sum/run.xs` and `~/xs/fizzbuzz/run.xs` to understand the pattern.

**Why it was an issue:** The `run.job` syntax with the `main = { name: "..." input: {...} }` structure wasn't documented in the accessible topics. Without existing examples to copy from, I would have been guessing at the correct structure.

**Potential solution (if known):**
- Include a complete `run.job` example in the quickstart or functions documentation
- Document the `main` block structure and how `name` maps to function names
- Show how `input` parameters are passed to the target function

---

## Overall Assessment

The Xano MCP validation tool works well and provides helpful error messages with line/column positions. The main friction points were:

1. **Documentation depth** - Topic-specific queries could return more targeted content
2. **Syntax examples** - More complete examples for each construct type would reduce reliance on inspecting existing code
3. **Filter expression syntax** - The parentheses requirement for filter+comparison combinations could be more prominently documented

The validation feedback was excellent - clear error messages with exact locations made fixing issues straightforward.
