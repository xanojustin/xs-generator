# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 14:32 PST] - Validation Success

**What I was trying to do:** Validate the XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** Initially had trouble figuring out the correct mcporter command-line argument format

**Why it was an issue:** The mcporter CLI expects `key=value` format without spaces or dashes (e.g., `code='...'`), not `--key value` or JSON format

**Potential solution (if known):** Document the expected argument format more clearly. The format `mcporter call xano validate_xanoscript code='...'` works, but `--code` or JSON arguments do not.

---

## [2025-03-03 14:33 PST] - Syntax Validation Passed

**What I was trying to do:** Ensure both run.xs and function/min_add_to_make_valid.xs have valid XanoScript syntax

**What the issue was:** None - both files passed validation on the first attempt

**Why it was an issue:** N/A

**Potential solution (if known):** The examples in the existing exercises (fizzbuzz, valid-parentheses) provided good reference patterns for:
- `run.job` structure with `main = { name: "...", input: { ... } }`
- `function` structure with `input`, `stack`, and `response`
- Using `var $name { value = ... }` for variable declaration
- Using `var.update $name { value = ... }` for updating variables
- Loop structure: `while (condition) { each { ... } }`
- Conditional structure: `conditional { if (...) { ... } elseif (...) { ... } }`
- Filter syntax: `$var|split:""` and `$var|count`

