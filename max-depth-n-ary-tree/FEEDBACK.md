# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 23:31 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Write a conditional check to see if a node's children array was empty: `if ($children|count == 0)`

**What the issue was:** The XanoScript validator rejected this with the error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This syntax rule wasn't immediately obvious from the quick reference documentation. In many other languages, filters/pipes have high precedence and don't require parentheses around the entire filtered expression when comparing.

**Potential solution:** 
- Update the quick reference to include this specific rule about filter expressions in conditionals
- Consider making the error message more helpful by showing the correct syntax: "Try: if (($children|count) == 0)"

---

## [2026-02-27 23:32 PST] - Documentation Discovery

**What I was trying to do:** Find the correct syntax for function definitions, run jobs, and input/output handling

**What the issue was:** I had to make multiple MCP calls to different topics (essentials, functions, run) to piece together the complete picture

**Why it was an issue:** It would be more efficient to have a single "getting started for exercises" topic that covers the common patterns needed for these coding exercises

**Potential solution:**
- Create a "coding-exercise-template" or "exercise-quickstart" topic that combines:
  - Function structure with input/output
  - Run job calling pattern
  - Common patterns for test runners
  - JSON object handling (for tree structures)

---

## [2026-02-27 23:33 PST] - No Issues with MCP Server

**What I was trying to do:** Validate XanoScript code and get documentation

**What the issue was:** None - the MCP server worked well

**Why it was an issue:** N/A - the MCP server responded quickly and provided helpful error messages

**Potential solution:** The validation tool works great! The error messages are clear and include line/column numbers.
