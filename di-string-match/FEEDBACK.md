# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 14:05 PST] - Successful First-Pass Validation

**What I was trying to do:** Create a new XanoScript coding exercise (DI String Match) following the run.job + function architecture pattern.

**What the issue was:** No issues encountered! The code passed validation on the first attempt.

**Why it was a pleasant surprise:** After reading the documentation thoroughly and following the established patterns from previous exercises, the implementation worked without any syntax errors. The two-pointer greedy algorithm translated cleanly to XanoScript.

**Observations:**
- The `while` loop inside `stack` worked as expected for iterating through the pattern
- The `|append` filter for arrays functioned correctly
- The `|substr` filter for extracting characters worked as documented
- Variable updates using `var.update` worked properly within the loop

---

## [2026-03-01 14:00 PST] - Documentation Quality

**What I was trying to do:** Learn XanoScript syntax to write the exercise.

**What the experience was:** The documentation via `xanoscript_docs` was comprehensive and well-structured. The essentials topic covered all the patterns needed:
- Variable declaration (`var $name { value = ... }`)
- While loops inside stack blocks
- Conditionals with proper `elseif` syntax
- Array operations with filters

**Positive feedback:** The examples in the documentation were directly applicable. The distinction between block properties (using `=`, no commas) and object literals (using `:`, with commas) was clearly explained and helped avoid common mistakes.

---

## [2026-03-01 14:02 PST] - MCP Tool Experience

**What I was trying to do:** Call the Xano MCP to get documentation and validate code.

**What worked well:**
- `mcporter call xano.xanoscript_docs` returned comprehensive documentation
- `mcporter call xano.validate_xanoscript` successfully validated multiple files at once
- The error messages (when seen in other exercises) have been helpful with line numbers

**Minor observation:** The `zsh:1: command not found: 1` message appears in stderr but doesn't affect functionality - the JSON output is still returned correctly.
