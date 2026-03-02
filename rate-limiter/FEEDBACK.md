# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 15:05 PST] - Successful Implementation

**What I was trying to do:** Implement a Rate Limiter exercise using XanoScript with a run job calling a function

**What happened:** Both files validated successfully on the first attempt

**Why this worked well:**
1. The `xanoscript_docs` tool provided clear, concise syntax documentation
2. The `essentials` and `syntax` quick reference topics covered all patterns needed (variables, conditionals, loops, filters)
3. The filter precedence rule (parentheses around `$var|filter` when using operators) was clearly documented and easy to follow
4. The existing example in `~/xs/valid-parentheses/` served as a good reference for structure

**Positive feedback:**
- The `file_path` parameter in `validate_xanoscript` is much more convenient than escaping code strings
- The quick_reference mode provides just enough information without being overwhelming
- Error messages (when they occur in other exercises) have been helpful with line/column positions

---

## [2025-03-02 15:05 PST] - File Path Issue

**What I was trying to do:** Validate the XanoScript files using the MCP

**What the issue was:** Initially tried using `~/xs/rate-limiter/run.xs` but got "File not found" errors

**Why it was an issue:** The tilde (`~`) expansion doesn't work in the MCP file paths

**Solution:** Used the absolute path `/Users/justinalbrecht/xs/rate-limiter/run.xs` instead

**Potential improvement:** Consider documenting that paths must be absolute, or support tilde expansion in the validator
