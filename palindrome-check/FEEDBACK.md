# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 09:15 PST] - MCP Tool Parameter Parsing Issue

**What I was trying to do:** Validate multiple XanoScript files at once using the `validate_xanoscript` tool with the `file_paths` parameter.

**What the issue was:** The `file_paths` parameter expects an array of strings, but passing comma-separated values via the mcporter CLI caused parsing issues. The tool interpreted each character of the path as a separate file, resulting in errors like "File not found: U", "File not found: s", "File not found: e", etc. (splitting "/Users/justinalbrecht/xs/..." into individual characters).

Command that failed:
```
mcporter call xano.validate_xanoscript file_paths="/Users/justinalbrecht/xs/palindrome-check/run.xs,/Users/justinalbrecht/xs/palindrome-check/function/check_palindrome.xs"
```

**Why it was an issue:** This prevented batch validation of multiple files, requiring individual validation calls instead which is less efficient.

**Potential solution (if known):** 
1. The MCP tool should properly parse comma-separated string values into arrays
2. Or document the correct CLI syntax for passing arrays (e.g., using `--args` JSON format instead)
3. Alternative approach worked: using `file_path` parameter for single files, or using `--args '{"file_paths": ["path1", "path2"]}'` syntax

**Workaround used:** Validated files individually using `file_path` parameter instead of `file_paths`.

---

## [2025-02-19 09:16 PST] - Documentation Discovery Positive Feedback

**What I was trying to do:** Learn XanoScript syntax from scratch since my training data doesn't include it.

**What worked well:** The `xanoscript_docs` tool with `mode=quick_reference` provided exactly what I needed — concise, practical syntax examples without overwhelming detail. The cheat sheet topic was particularly helpful for common patterns.

**Positive observations:**
1. The documentation clearly highlights common mistakes (e.g., using `boolean` instead of `bool`, `string` instead of `text`)
2. The reserved variables list prevented naming conflicts
3. The type alias table ("Use This | Not This") was immediately actionable
4. Having both `quick_reference` and `full` modes allows choosing context efficiency vs completeness

**Suggestion:** Consider adding a "common filter combinations" section to the cheat sheet (e.g., `|trim|to_lower` for normalized text comparison).

---

## [2025-02-19 09:17 PST] - First-Pass Validation Success

**What I was trying to do:** Write valid XanoScript code based on documentation alone.

**What happened:** Both files passed validation on the first attempt without any errors.

**Why this matters:** The documentation quality is high enough that an AI with no prior XanoScript knowledge can write syntactically correct code on the first try. This suggests:
1. The quickstart and cheat sheet documentation is well-structured
2. The examples are clear and copy-pasteable
3. The "common mistakes" sections prevented typical errors

**No issues to report here — just positive feedback that the docs work as intended.**
