# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 11:32 PST] - foreach Syntax Uncertainty

**What I was trying to do:** Write a function that iterates over an array to build a running sum.

**What the issue was:** I initially wrote `foreach ($input.nums as $num)` which is the standard syntax in many languages (PHP, JavaScript, etc.). However, XanoScript uses a different pattern where the variable binding happens in the `each` block with `each as $num`.

**Why it was an issue:** This blocked compilation and required a validation round-trip to discover the error. The error message was helpful but I had to find an existing example to understand the correct pattern.

**Potential solution (if known):** 
- The quickstart docs mention `while` loops but don't show the `foreach` pattern prominently
- A dedicated "Array Iteration" or "Loop Patterns" section in the quick_reference would help
- Example: `foreach ($array) { each as $item { ... } }`

---

## [2025-02-24 11:33 PST] - MCP Tool Response Format

**What I was trying to do:** Parse the validation results programmatically to update CHANGES.md automatically.

**What the issue was:** The `validate_xanoscript` tool returns results as text within a JSON `content` array. This makes it harder to programmatically extract file-level pass/fail status without parsing the human-readable text.

**Why it was an issue:** For automated workflows (like this exercise generator), structured JSON with file-level status would be more useful than text that needs regex parsing.

**Potential solution (if known):** 
- Add an `output_format` parameter that can return `json` with structured results like:
```json
{
  "files": [
    {"path": "...", "valid": true},
    {"path": "...", "valid": false, "errors": [...]}
  ]
}
```

---

## [2025-02-24 11:35 PST] - Documentation Search for Patterns

**What I was trying to do:** Find the correct foreach syntax after the validation error.

**What the issue was:** The quick_reference for syntax doesn't include the foreach/each pattern. I had to grep through existing exercise files to find examples.

**Why it was an issue:** It's inefficient to search through dozens of files when a documentation lookup should suffice. The foreach pattern is common enough that it should be documented.

**Potential solution (if known):** 
- Add a "Loop Patterns" subsection to the syntax quick_reference covering:
  - `while` loops
  - `foreach` loops  
  - `each` blocks
  - Array iteration patterns

---
