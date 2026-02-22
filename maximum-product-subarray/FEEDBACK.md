# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-22 15:05 PST] - File Path Handling with Tilde (~)

**What I was trying to do:** Validate XanoScript files by passing file paths to the `validate_xanoscript` tool

**What the issue was:** When using the MCP `validate_xanoscript` tool with `file_paths` parameter containing tilde (`~`) shorthand for home directory (e.g., `~/xs/maximum-product-subarray/run.xs`), the MCP parser incorrectly split the path into individual characters, treating each character as a separate file path. This resulted in errors like "File not found: ~", "File not found: x", "File not found: s", etc.

**Validation command that failed:**
```
mcporter call xano.validate_xanoscript file_paths="~/xs/maximum-product-subarray/run.xs,~/xs/maximum-product-subarray/function/maximum-product-subarray.xs"
```

**Why it was an issue:** The tilde character is standard shell shorthand for the home directory, but the MCP doesn't expand it. Additionally, the way the file_paths array was being parsed caused each character to be treated as a separate entry.

**Workaround used:** Used the `directory` parameter instead of `file_paths` with the full absolute path:
```
mcporter call xano.validate_xanoscript directory="/Users/justinalbrecht/xs/maximum-product-subarray"
```

**Potential solution:** 
1. Document that absolute paths are required (no tilde expansion)
2. Add path expansion support for `~` to resolve to user's home directory
3. If file_paths parsing is failing on commas or formatting, improve the documentation for the expected format

---

## [2025-02-22 15:08 PST] - Initial Documentation Read

**What I was trying to do:** Understand XanoScript syntax for functions and run jobs

**What the issue was:** No direct issues with the MCP, but wanted to note that the quick_reference mode was very helpful for getting the syntax patterns without consuming too much context window.

**Why this was good:** The `mode=quick_reference` option on `xanoscript_docs` provided exactly what was needed - concise syntax patterns without lengthy explanations.

**Suggestion:** Consider making quick_reference the default mode, or document more prominently that this mode exists for AI assistants who need syntax reminders.

---

## [2025-02-22 15:10 PST] - Validation Success

**What I was trying to do:** Validate the XanoScript files I created

**What happened:** Both files passed validation on the first attempt using the `directory` parameter approach.

**Positive feedback:** The validation tool provided clear output showing which files were validated and their status. The error messages for my earlier path issues were verbose but did indicate the problem (even if the character-by-character parsing was unexpected).

**No issues to report on this validation run.**
