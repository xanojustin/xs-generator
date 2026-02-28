# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 02:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Write a precondition to validate that an input array has at least 2 elements using `$input.nums|count >= 2`.

**What the issue was:** The validation failed with: `An expression should be wrapped in parentheses when combining filters and tests`. The syntax `$input.nums|count >= 2` was rejected even though it's intuitively clear.

**Why it was an issue:** This is a subtle syntax requirement that wasn't immediately obvious from the documentation. In many other languages, filter/pipe operations chain naturally without extra parentheses for comparisons.

**Potential solution (if known):** The error message was helpful and pointed exactly to the problem. Perhaps the documentation could include a prominent note about "when combining filters with operators, wrap the filter in parentheses" or show this pattern in the essentials examples.

---

## [2026-02-28 02:36 PST] - $index Variable in foreach Loops

**What I was trying to do:** Access the current index within a foreach loop to skip the first element.

**What the issue was:** I assumed `$index` would be available automatically in foreach loops based on common patterns in other languages, but I wasn't 100% sure if XanoScript provides it.

**Why it was an issue:** The documentation shows `each as $item` but doesn't clearly document whether `$index` is automatically available as a reserved variable in foreach contexts, or if it needs to be accessed differently.

**Potential solution (if known):** The documentation could clarify the available implicit variables in different contexts (foreach, each, for, while). If `$index` is indeed available, documenting it in the essentials/syntax sections would help. If it's not available, showing the recommended pattern for accessing indices would be useful.

---

## [2026-02-28 02:37 PST] - Overall MCP Experience

**What I was trying to do:** Create a complete XanoScript exercise with validation.

**What went well:**
- The `xanoscript_docs` tool worked well for retrieving documentation
- The `validate_xanoscript` tool provided clear, actionable error messages
- The quick_reference mode was concise and useful
- The validation correctly identified the syntax issue with precise line/column info

**General feedback:**
- The documentation structure is good with quick_reference vs full modes
- The error messages are helpful and include suggestions
- It would be nice to have a "common patterns" or "idioms" section in the docs showing frequently-used code patterns like:
  - Iterating with index
  - Common precondition patterns
  - Min/max tracking loops (like this exercise)
