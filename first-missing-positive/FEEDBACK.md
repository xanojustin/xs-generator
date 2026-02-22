# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 01:02 PST] - Multi-line comments cause parsing errors

**What I was trying to do:** Create a well-documented XanoScript file with explanatory comments at the top describing the algorithm and approach.

**What the issue was:** Multi-line comment blocks at the beginning of the file caused the parser to fail with errors like:
```
[Line 8, Column 1] Expecting --> function <-- but found --> '
' <--
```

This happened even when using `//` single-line comments on consecutive lines. The parser seemed to be confused by the leading comments.

**Why it was an issue:** Good code documentation is standard practice. Having to strip all comments to make the code valid is counter-intuitive. The error message was also misleading - it suggested looking for type name issues rather than comment problems.

**Potential solution (if known):** 
1. Clarify in documentation that files should start directly with the construct keyword (function, run.job, etc.)
2. Improve parser error messages to detect and report "unexpected content before construct" 
3. Support standard comment formats more robustly

---

## [2026-02-22 01:03 PST] - Path expansion issue with validation tool

**What I was trying to do:** Validate files using the `directory` parameter with `~/xs/first-missing-positive`.

**What the issue was:** The tilde (`~`) character was not expanded to the home directory, resulting in "No .xs files found in directory" error.

**Why it was an issue:** Shell users expect `~` to work as a shorthand for home directory. Having to use absolute paths is less convenient.

**Potential solution (if known):** 
1. Expand `~` to `$HOME` in the validation tool before path resolution
2. Support relative paths from current working directory

---

## [2026-02-22 01:05 PST] - Good validation feedback on success

**What I was trying to do:** Validate that my corrected files were syntactically correct.

**What worked well:** After fixing the comment issue, the validation tool provided clear, positive feedback:
```
Validated 2 file(s): 2 valid, 0 invalid
✅ Valid files:
  /Users/justinalbrecht/xs/first-missing-positive/function/first_missing_positive.xs
  /Users/justinalbrecht/xs/first-missing-positive/run.xs
```

**Why this was helpful:** The clear success message with file paths confirmed exactly which files were validated and that they passed.

---

## General Observation: Documentation Quality

The `xanoscript_docs` tool is excellent - comprehensive, well-organized, and includes practical examples. The quickstart guide with "Common Mistakes" section was particularly helpful. The only gap I noticed was around comment syntax best practices.
