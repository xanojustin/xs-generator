# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 02:35 PST] - No Issues - First Try Success

**What I was trying to do:** Create a new XanoScript coding exercise for "Best Time to Buy and Sell Stock II" with a function and run job.

**What the issue was:** No issues encountered. Both files passed validation on the first attempt.

**Why it was an issue:** N/A - This was a successful implementation.

**Potential solution (if known):** N/A

---

## [2026-02-24 02:35 PST] - Documentation Query Parameter Format

**What I was trying to do:** Call the `xanoscript_docs` tool to get documentation for functions and run jobs.

**What the issue was:** The documentation tool seemed to return the same index content regardless of the topic parameter. I tried calling with `{"topic": "functions"}` and `{"topic": "run"}` but received similar general index content.

**Why it was an issue:** It was difficult to get specific detailed documentation for the function and run job constructs. I had to rely on reading existing exercise implementations to understand the correct syntax patterns.

**Potential solution (if known):** The MCP could either:
1. Return more detailed topic-specific documentation
2. Or document that the examples in `~/xs/` are the primary reference for syntax patterns

---

## [2026-02-24 02:35 PST] - Validate Tool Parameter Discovery

**What I was trying to do:** Call the `validate_xanoscript` tool with file paths.

**What the issue was:** Initially tried passing `files` as a JSON array which failed. Had to discover the correct parameter name `file_paths` through trial and error with the error message.

**Why it was an issue:** The tool schema/help wasn't immediately accessible through mcporter, requiring iterative debugging.

**Potential solution (if known):** A `mcporter describe <server>.<tool>` command or better error messages indicating the available parameters would help.

---

## General Observations

**What worked well:**
1. Reading existing exercises in `~/xs/` was the most effective way to learn XanoScript syntax
2. The validation tool gave clear pass/fail feedback
3. The folder structure conventions were clear from the documentation

**Patterns learned from existing exercises:**
- Use `var $name { value = ... }` for variable declaration
- Use `var.update $name { value = ... }` for variable updates
- Use `conditional { if (...) {...} elseif (...) {...} else {...} }` for conditionals
- Use `while` loops with manual index counters for array iteration
- Use `$array[$index]` for array element access
- Use `$array|count` for array length
- Use `$array|first` for first element
