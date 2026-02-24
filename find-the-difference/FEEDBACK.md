# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 04:35 PST] - No Issues Encountered

**What I was trying to do:** Create a XanoScript coding exercise for "find-the-difference" problem - a function that finds the extra character added to a shuffled string.

**What the issue was:** No issues encountered. Both files passed validation on the first attempt.

**Why it was an issue:** N/A

**Potential solution (if known):** N/A

---

## General Observations

**What worked well:**
1. The `xanoscript_docs` tool provided excellent documentation with clear examples
2. The `validate_xanoscript` tool gave quick, clear feedback
3. The syntax patterns in the quickstart guide were very helpful for avoiding common mistakes
4. The distinction between `run.job` and `function` constructs was well documented

**Key patterns that helped:**
- Using `xanoscript_docs topic=quickstart` first to understand common patterns
- Using `xanoscript_docs topic=functions` for function structure
- Using `xanoscript_docs topic=run` for run job structure
- The examples showing proper variable access (`$input.field` vs `$var.field`)

**Documentation quality:**
- The docs clearly explained the difference between `text` (not `string`), `int` (not `integer`), etc.
- The common mistakes section in quickstart was particularly valuable
- Having the `// ❌ Wrong` and `// ✅ Correct` patterns made it easy to avoid errors
