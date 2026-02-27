# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 00:32 PST] - Successful First Validation

**What I was trying to do:** Create a XanoScript coding exercise for the "Subsets II" problem

**What the issue was:** No issues! Both the run.xs and function/subsets_ii.xs files passed validation on the first attempt.

**Why it was an issue:** N/A - Everything worked as expected

**Potential solution (if known):** N/A

---

## [2026-02-27 00:31 PST] - MCP Parameter Discovery

**What I was trying to do:** Call the `validate_xanoscript` tool with the correct parameters

**What the issue was:** Initially tried using `files` parameter but the correct parameter name is `file_paths`. Also needed to use absolute paths for the validation to work.

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was confusing when I thought I was passing `file_paths`. The issue was the parameter name format in the mcporter CLI.

**Potential solution (if known):** The MCP server could provide more helpful error messages when parameter names don't match, suggesting the correct parameter names. Also, having relative path support would be more convenient.

---
