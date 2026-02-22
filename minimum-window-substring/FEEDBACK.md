# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 19:32 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Write a conditional that checks if a string is empty or if one string is longer than another, using the `strlen` filter.

**What the issue was:** The validator rejected this code:
```xs
if ($input.t|strlen == 0 || $input.t|strlen > $input.s|strlen) {
```

The error was: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This syntax rule is not intuitive. Coming from other languages, filters like `|strlen` feel like they should bind tightly to the expression before them, so `($input.t|strlen)` shouldn't need parentheses. The error message was also confusing because it appeared twice on the same line/column.

**Potential solution (if known):** 
- The documentation could explicitly show examples of combining filters with comparison operators
- The error message could show the corrected code suggestion
- Consider making the filter binding tighter so parentheses aren't required in common cases

---

## [2026-02-21 19:35 PST] - Documentation Topics Mismatch

**What I was trying to do:** Call `xanoscript_docs` with topic="quick_reference" as suggested in the cheatsheet output.

**What the issue was:** The MCP returned an error: "Unknown topic 'quick_reference'" and listed available topics. The cheatsheet mentions using `mode='quick_reference'` but this doesn't work as a topic parameter.

**Why it was an issue:** The cheatsheet documentation says:
> "For detailed documentation, use `xanoscript_docs({ topic: "quickstart" })` - Common patterns and mistakes"

But it also mentions quick_reference mode which doesn't exist as a topic.

**Potential solution (if known):** 
- Update the cheatsheet to remove the `quick_reference` mode reference or clarify it's not a topic
- Make the cheatsheet's "Related" section more accurate

---

## [2026-02-21 19:40 PST] - Positive Feedback: Documentation Structure

**What went well:** Once I figured out the correct topics, the `cheatsheet`, `functions`, and `run` documentation was actually very helpful. The code examples were clear and complete.

**Notable strengths:**
- The `run.job` vs `run.service` distinction was clearly explained
- Function input/output syntax with all the variations (nullable, optional, defaults) was well documented
- The examples showed realistic patterns like foreach loops with conditionals inside

---
