# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 04:05 PST] - Filter name confusion: `to_integer` vs `to_int`

**What I was trying to do:** Convert a single character (text) to an integer value so I could perform arithmetic on it.

**What the issue was:** I used the filter `to_integer` based on my intuition from other programming languages, but XanoScript uses `to_int` instead. The validation error was:
```
[Line 31, Column 42] Unknown filter function 'to_integer'
```

**Why it was an issue:** Without knowing the exact filter name, I had to search through existing implementations to find the correct syntax. The error message suggested using "int" instead of "integer" for type declarations, but didn't explicitly tell me the filter name is `to_int`.

**Potential solution (if known):** 
- The documentation could include a complete list of available filters with examples
- The error message could suggest `to_int` as the correct filter name
- A filter reference table in the quickstart documentation would be helpful

---

## [2026-02-22 04:06 PST] - Finding examples required grep/search

**What I was trying to do:** Find the correct filter name for text-to-integer conversion.

**What the issue was:** The xanoscript_docs tool didn't return a comprehensive list of filters when I queried the syntax topic. I had to grep through existing exercise files to find examples of `to_int` usage.

**Why it was an issue:** This adds friction to the development workflow. Having to search through existing code to find basic syntax patterns slows down development.

**Potential solution (if known):**
- Include a comprehensive filter reference in the documentation
- Add a `xanoscript_docs({ topic: "filters" })` endpoint that lists all available filters

---
