# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 16:05 PST] - Successful First-Pass Validation

**What I was trying to do:** Create a new XanoScript coding exercise for "Longest Harmonious Subsequence" following the established pattern of run job + function structure.

**What happened:** Both files (`run.xs` and `function/longest_harmonious_subsequence.xs`) passed validation on the first attempt without any errors.

**Why this is notable:** This was a relatively smooth experience. The Xano MCP validation tool worked correctly and provided clear, concise output showing 2/2 files valid.

**Positive observations:**
- The `xanoscript_docs` with `mode="quick_reference"` provided excellent guidance on type names (`int`, `text`, `int[]` vs `integer`, `string`, `array`)
- The pattern of using `function "name" { input { } stack { } response = ... }` was well-documented
- The validation tool's JSON output is clean and easy to parse
- Having existing exercises in `~/xs/` to use as reference was extremely helpful

---

## [2026-02-26 16:03 PST] - Documentation Discovery Pattern

**What I was trying to do:** Learn XanoScript syntax for functions, specifically how to declare variables, use conditionals, and iterate over arrays.

**What the issue was:** Initially unsure about the exact syntax for:
1. Variable declaration (`var $name { value = ... }`)
2. Updating variables (`var.update $name { value = ... }` vs `var $name { value = ... }` for reassignment)
3. Foreach loop structure
4. Object/map operations (`|has:`, `|get:`, `|set:`)

**Why it was an issue:** The quick_reference mode gives a high-level overview but doesn't show detailed syntax patterns for specific operations like filter usage or conditional blocks.

**Potential solution (if known):** The documentation is actually well-organized with the topic-based approach. The workflow of:
1. `xanoscript_docs({ mode: "quick_reference" })` for overview
2. `xanoscript_docs({ topic: "functions" })` for detailed function syntax
3. `xanoscript_docs({ topic: "syntax" })` for expressions and operators

...works well, but could benefit from a "cookbook" or "patterns" topic that shows common code patterns (hash maps, counting, finding max/min, etc.) in one place.

---

## Summary

Overall, the Xano MCP server and XanoScript documentation provided a good developer experience for this exercise. The validation tool was fast and accurate. The main improvement suggestion would be a "Common Patterns" or "Cookbook" topic in the documentation showing frequently used algorithms (frequency counting, two-pointer patterns, etc.) in XanoScript syntax.