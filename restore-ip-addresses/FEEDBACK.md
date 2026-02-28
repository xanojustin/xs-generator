# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 10:00 PST] - Initial Setup

**What I was trying to do:** Create a new XanoScript coding exercise for "Restore IP Addresses" using iterative backtracking

**What the issue was:** N/A - Initial implementation, no issues yet

**Why it was an issue:** N/A

**Potential solution (if known):** N/A

---

## [2026-02-28 10:05 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Validate the XanoScript code using the `validate_xanoscript` tool

**What the issue was:** 
```
1. [Line 25, Column 27] An expression should be wrapped in parentheses when combining filters and tests

Code at line 25:
  while ($stack|count > 0) {
```

**Why it was an issue:** I was unaware that filter expressions combined with comparison operators must be wrapped in parentheses. I wrote `while ($stack|count > 0)` but it needed to be `while (($stack|count) > 0)`.

**Potential solution (if known):** This is a subtle syntax rule that could be highlighted more prominently in the essentials documentation. The error message was clear and helpful, but it would be nice to have this pattern shown in the common mistakes section with a before/after example.

---

## [2026-02-28 10:06 PST] - MCP Tool Parameter Format

**What I was trying to do:** Call the validation tool with multiple file paths using `file_paths` parameter

**What the issue was:** 
```
Invalid arguments: file_paths: Invalid input: expected array, received string
```

I tried: `file_paths="~/xs/restore-ip-addresses/run.xs,~/xs/restore-ip-addresses/function/restore_ip_addresses.xs"`

**Why it was an issue:** The parameter expects an actual JSON array, not a comma-separated string. I switched to using the `directory` parameter instead which worked fine.

**Potential solution (if known):** The CLI help could show an example of the array format expected. Something like:
```
mcporter call xano.validate_xanoscript file_paths='["path1.xs", "path2.xs"]'
```

Or better yet, support comma-separated strings as a convenience since that's how many CLI tools work.

---

## Overall Assessment

The MCP server worked well once I understood the syntax requirements:

**Strengths:**
- Validation error messages are clear and include line/column numbers
- The suggestion hint about `text` vs `string` is helpful
- The directory validation is convenient for batch checking

**Areas for improvement:**
- The parentheses requirement for filter expressions in comparisons could be more prominently documented
- CLI parameter array syntax could be better documented with examples
- Consider adding a "quick start" example that shows the most common validation patterns

**Time to complete:** ~10 minutes from start to finish (excluding research time)

