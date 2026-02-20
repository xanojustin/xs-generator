# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 11:05 PST] - file_paths parameter parsing issue

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated paths.

**What the issue was:** The command `mcporter call xano.validate_xanoscript file_paths=/path1,/path2` parsed the comma-separated string as individual character arguments, resulting in errors like "File not found: U", "File not found: s", etc. (each character of the path was treated as a separate file).

**Why it was an issue:** Could not batch validate multiple specific files in a single call.

**Workaround found:** Using the `directory` parameter with a glob pattern worked fine: `directory=/Users/justinalbrecht/xs/jump-game`

**Potential solution:** The MCP should either:
1. Properly parse comma-separated values in the `file_paths` parameter
2. Accept JSON array format for complex parameters
3. Document that `file_paths` should use a different delimiter or format

---

## [2026-02-20 11:08 PST] - Filter expression parentheses requirement unclear

**What I was trying to do:** Write a conditional check using a filter combined with a comparison: `$input.nums|count <= 1`

**What the issue was:** The validator rejected this with "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The documentation in `quick_reference` mode doesn't clearly state this requirement. I had to guess that `($input.nums|count)` would work.

**Potential solution:** 
1. Add a clear example in the quickstart/quick_reference showing filter + comparison syntax
2. The error message could suggest the exact fix: "Try: `($input.nums|count) <= 1`"

---
