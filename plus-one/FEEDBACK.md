# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 20:33 PST] - Comment Syntax at File Start

**What I was trying to do:** Create XanoScript files with comments at the top explaining what the code does

**What the issue was:** When I added `//` comments at the very beginning of the file (before the `function` or `run.job` declaration), the validator threw errors like:
- `Expecting --> function <-- but found --> '\n' <--`
- `Expecting --> run <-- but found --> '\n' <--`

**Why it was an issue:** This was confusing because the documentation says `//` is the correct comment syntax. The parser seems to have trouble with comments before the construct declaration.

**Potential solution:** Either:
1. Document that comments cannot appear before the construct declaration
2. Fix the parser to allow comments at the start of files
3. Or make the error message clearer (e.g., "Comments not allowed before construct declaration")

**Workaround:** Remove leading comments and only use comments inside the construct blocks (which work fine).

---

## [2026-02-20 20:35 PST] - First Validation Success

**What I was trying to do:** Validate my first XanoScript exercise

**What went well:** After removing the leading comments, both files passed validation on the first attempt. The syntax documentation was clear enough to get the basic structure right.

**Positive observations:**
- The `int[]` array type syntax worked as documented
- The `function.run` pattern in run.job was straightforward
- The `while` loop and `conditional` syntax matched the examples

---
