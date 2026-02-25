# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 08:00 PST] - Initial Setup

**What I was trying to do:** Create a new XanoScript coding exercise for "Valid Perfect Square" using binary search

**What the issue was:** The `xanoscript_docs` tool returned the same overview documentation for different topics (quickstart, functions, syntax, run). I needed to get specific syntax details for conditionals, loops, and variable declarations but the docs only returned high-level overviews.

**Why it was an issue:** Without specific syntax examples for constructs like `conditional/if/elseif/else`, `while` loops, and variable declaration patterns, I had to rely on reading existing code examples in the `~/xs/` directory to understand the correct syntax.

**Potential solution (if known):** The MCP should return topic-specific documentation when topics are requested. If the docs don't have detailed topic sections, consider adding them or providing a link to full online documentation.

---

## [2025-02-25 08:00 PST] - Documentation Discovery via Existing Code

**What I was trying to do:** Learn XanoScript syntax patterns for my implementation

**What the issue was:** Had to read existing implementations (`fizzbuzz`, `binary-search`) to understand:
- How to structure `conditional` blocks with `if/elseif/else`
- How to write `while` loops with the `each` block
- How to use backticks for inline expressions vs direct variable comparisons
- How to properly declare and update variables using `var` and `var.update`

**Why it was an issue:** This is inefficient and error-prone. New developers shouldn't need to reverse-engineer syntax from existing code.

**Potential solution (if known):** Provide a "XanoScript Syntax Cheatsheet" topic in the docs that covers:
- Variable declaration and update patterns
- Conditional blocks (if/elseif/else syntax)
- Loop structures (while with each)
- Expression syntax (backticks vs no backticks)
- Response assignment patterns

---

## [2025-02-25 08:05 PST] - MCP Validation Tool Parameter Syntax

**What I was trying to do:** Validate the XanoScript files using the MCP's `validate_xanoscript` tool

**What the issue was:** Initially struggled with the correct parameter syntax for mcporter. The JSON parameter format (`'{"file_paths": [...]}'`) didn't work. Had to use the key=value format (`'file_path=/path/to/file.xs'`).

**Why it was an issue:** This is inconsistent with how many MCP tools accept parameters. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" appeared even when JSON parameters were correctly formatted.

**Potential solution (if known):** Document the expected parameter format more clearly in the tool description, or support both JSON and key=value formats consistently.

---

## [2025-02-25 08:05 PST] - Successful Validation

**What I was trying to do:** Validate the function and run job files

**What the issue was:** None - both files passed validation on first attempt

**Why it was an issue:** N/A - validation was successful

**Potential solution (if known):** The syntax I learned from reading existing files was correct. Key patterns that worked:
- `conditional { if (...) { } elseif (...) { } else { } }` for conditionals
- `while (condition) { each { ... } }` for loops
- `var $name { value = ... }` for variable declaration
- Backticks for inline expressions: `` `$mid * $mid` `` - wait, no, I didn't use backticks in my mid_squared calculation

Actually I used `var $mid_squared { value = $mid * $mid }` which worked.

---
