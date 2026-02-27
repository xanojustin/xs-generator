# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 14:35 PST] - MCP Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` MCP tool to validate my XanoScript files

**What the issue was:** The tool documentation shows examples with JSON-style parameters, but the actual mcporter CLI requires a different format. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" kept appearing even when I provided those parameters.

**Why it was an issue:** I tried multiple formats:
- `mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'` - Failed
- `mcporter call xano validate_xanoscript {"file_path":"/path/to/file.xs"}` - Failed
- `mcporter call xano validate_xanoscript file_path=/Users/justinalbrecht/xs/.../run.xs` - Worked!

The working format uses `key=value` without quotes around the value, which is different from standard JSON or typical MCP tool calling conventions.

**Potential solution (if known):** The MCP documentation or error messages could be clearer about the expected parameter format. The examples in the tool description show JSON-style but the actual working format is key=value pairs.

---

## [2025-02-27 14:36 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Write a conditional check for array length: `if ($input.sides|count < 3)`

**What the issue was:** The validator rejected this with: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This syntax looks natural and would work in many languages, but XanoScript requires explicit parentheses when combining filters (like `|count`) with comparison operators. The fix was to write: `if (($input.sides|count) < 3)`

Same issue occurred in the while loop condition: `$i <= $n - 3 && !$found` needed to become `($i <= ($n - 3)) && !$found`

**Potential solution (if known):** The error message was actually quite helpful and included the exact line of code. The suggestion about using "int" instead of "integer" was also useful (though I was already using "int"). The parentheses rule makes sense for disambiguation but could be documented more prominently in the essentials guide.

---
