# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 06:33 PST] - No Issues Encountered

**What I was trying to do:** Create a complete XanoScript coding exercise (rotate-string) with a run job and function.

**What the issue was:** No issues encountered. Both the run.xs and function/rotate_string.xs files passed validation on the first attempt.

**Why it was an issue:** N/A - smooth development experience.

**Potential solution (if known):** N/A

---

## General Observations

### Positive Feedback

1. **Documentation is comprehensive:** The `xanoscript_docs` tool provides excellent coverage of XanoScript syntax and patterns. Having quickstart, functions, and run topics made it easy to understand the structure.

2. **Validation works well:** The `validate_xanoscript` tool gave clear, concise feedback (just "Valid" with a checkmark when passing).

3. **Syntax is intuitive:** Coming from other languages, XanoScript's block-based syntax with `input`, `stack`, and `response` sections is easy to reason about.

4. **Type system is clear:** The type names (`text`, `int`, `bool`, `decimal`) are distinct enough to avoid confusion with other languages.

### Suggestions for Improvement

1. **Validation output detail:** While "Valid" is great for success, it might be helpful to have an optional verbose mode that shows what was parsed (e.g., recognized as "run.job", found function name, etc.) for learning purposes.

2. **String concatenation operator:** The `~` operator for string concatenation is unusual (most languages use `+` or `.`). This was called out in the docs, which helped.

3. **Filter syntax:** The requirement for parentheses when using filters in expressions (e.g., `($input.s1|strlen)`) could be more prominently featured in error messages when validation fails.

### Tool-Specific Notes

- The `mcporter` integration worked smoothly for calling MCP tools
- The Xano MCP server responded quickly to validation requests
- Documentation retrieval via `xanoscript_docs` was fast and comprehensive