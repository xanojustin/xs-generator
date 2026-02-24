# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 18:05 PST] - MCP Parameter Passing Confusion

**What I was trying to do:** Validate the XanoScript files using the `validate_xanoscript` tool via mcporter

**What the issue was:** I struggled to find the correct syntax for passing the `file_paths` parameter to the MCP tool. I tried multiple approaches that all failed:
- `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` - Error: parameter required
- `mcporter call xano validate_xanoscript --file_paths '...'` - Treated as code, not parameters
- `mcporter call xano validate_xanoscript file_paths '[...]'` - Treated as code

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was confusing because I was clearly passing `file_paths`, but the MCP server wasn't receiving it. I spent several attempts trying different formats.

**Potential solution (if known):** The correct syntax is `mcporter call xano validate_xanoscript --args '{"file_paths": [...]}'`. It would be helpful if:
1. The mcporter help/docs explicitly showed the `--args` flag usage for JSON parameters
2. The error message suggested using `--args` when it detects JSON-like syntax in positional arguments
3. The `mcporter describe` output included an example of the correct call syntax

---

## [2026-02-23 18:08 PST] - Documentation Response Time

**What I was trying to do:** Get detailed XanoScript syntax documentation for run jobs and functions

**What the issue was:** Calling `xanoscript_docs` with topics like `quickstart`, `run`, and `functions` all returned the same general overview documentation rather than specific syntax details. The docs mentioned sections like "Filters (L179-275)" and "Error Handling (L411-477)" but didn't actually include those detailed sections in the response.

**Why it was an issue:** I had to rely on existing code examples in the `~/xs/` directory to understand the correct syntax for constructs like `run.job` and `function` blocks, rather than having comprehensive reference documentation.

**Potential solution (if known):** The documentation could be split into more granular topics or the MCP could support line-range queries to retrieve specific sections mentioned in the overview.

---

## [2026-02-23 18:10 PST] - Overall Success

**Positive feedback:** Once I figured out the `--args` syntax, the validation tool worked perfectly and gave clear, helpful error messages. The initial implementation passed validation on the first try, which suggests the existing code examples and general documentation were sufficient to understand the XanoScript patterns.
