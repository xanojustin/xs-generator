# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-27 11:05 PST - Validation Parameter Naming

**What I was trying to do:** Validate the XanoScript files using the MCP tool

**What the issue was:** The `validate_xanoscript` tool expects `file_path` (or `file_paths`, `directory`, `code`) as the parameter name, but the common pattern in many MCP tools is to use just `file`. I initially tried `file="..."` which failed.

**Why it was an issue:** Had to try multiple times to discover the correct parameter name. The error message was clear (`"One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"`) but required an extra attempt.

**Potential solution:** Consider also accepting `file` as an alias for `file_path`, or document the parameter names more prominently.

---

## 2025-02-27 11:06 PST - Relative vs Absolute Paths

**What I was trying to do:** Validate files using a relative path from the current directory

**What the issue was:** When running from within `~/xs/longest-common-substring/`, using `file_path="function/longest_common_substring.xs"` failed with "File not found". Using the absolute path worked.

**Why it was an issue:** It's natural to use relative paths when working in a project directory. Having to use absolute paths is less convenient.

**Potential solution:** Support relative paths from the current working directory, or document that absolute paths are required.

---

## 2025-02-27 11:07 PST - Overall Positive Experience

**What went well:**
1. The `xanoscript_docs` tool worked excellently - provided comprehensive, well-organized documentation
2. After reading the docs, I was able to write valid XanoScript code on the first attempt
3. The validation tool gave clear, immediate feedback
4. The syntax for `run.job` calling a function was clearly documented

**No other issues encountered** - the documentation was sufficient to write the exercise correctly.

---
