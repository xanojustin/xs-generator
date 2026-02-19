# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 16:42 PST] - Documentation Discovery

**What I was trying to do:** Find the correct XanoScript syntax for writing a function

**What the issue was:** I needed to discover the Xano MCP tools and the correct syntax. Initially, I didn't know where to find the XanoScript documentation.

**Why it was an issue:** The task required me to call `xanoscript_docs` before writing any code, but I didn't immediately know how to access the MCP tools.

**Potential solution (if known):** The mcporter skill helped me discover the available tools. Consider adding a brief "getting started" hint in the exercise template about using `mcporter list` to discover MCP tools.

---

## [2025-02-18 16:45 PST] - No Syntax Issues Encountered

**What I was trying to do:** Write the FizzBuzz function

**What the issue was:** None - the code validated on the first attempt

**Why it was an issue:** N/A - success case

**Potential solution (if known):** The documentation was clear enough that I could write valid XanoScript on the first try. Key learnings:
- Use `text[]` for array types (not `array` or `list`)
- Use `int` not `integer`
- While loops have a specific structure with `each` block inside
- Variables are declared with `var $name { value = ... }`
- String concatenation uses `~` operator
- The `to_text` filter converts numbers to strings
- Arrays use `|push:` filter to append items

---
