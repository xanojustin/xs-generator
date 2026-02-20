# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 02:05 PST] - Documentation Could Be More Detailed

**What I was trying to do:** Get specific syntax documentation for XanoScript run jobs and functions

**What the issue was:** The `xanoscript_docs` tool returned high-level overview documentation for all topics (quickstart, functions, run, syntax) instead of detailed syntax documentation. The content was identical/generic across different topic requests.

**Why it was an issue:** While I was able to infer the correct syntax from existing examples in the `~/xs/` directory, I couldn't get detailed reference documentation about specific syntax constructs like:
- Exact syntax for `var.update` vs `var` declarations
- Proper usage of the modulo operator in backtick expressions
- Detailed `run.job` configuration options

**Potential solution:** The MCP could return more detailed, topic-specific documentation rather than the generic overview. For example, `topic: "syntax"` should return detailed syntax reference, not the same README content.

---

## [2026-02-20 02:06 PST] - validate_xanoscript Argument Parsing

**What I was trying to do:** Validate multiple files using the `file_paths` parameter

**What the issue was:** The mcporter CLI argument parsing for `file_paths` array was difficult to get right. The initial attempts with JSON formatting or `--file_paths` flag didn't work as expected.

**Why it was an issue:** I had to switch to using the `directory` parameter instead, which worked fine but wasn't my first choice for targeted file validation.

**Potential solution:** Document clearer examples of how to pass array parameters via mcporter CLI, or support more intuitive syntax like `--file_paths path1 --file_paths path2`.

---

## [2026-02-20 02:07 PST] - Positive: First-Attempt Validation Success

**What I was trying to do:** Validate my XanoScript code

**What worked well:** After studying existing examples in `~/xs/fizzbuzz/` and `~/xs/valid-parentheses/`, I was able to write valid XanoScript that passed validation on the first attempt.

**Why this matters:** The existing exercises served as excellent reference material. The pattern of:
- `function "name" { input {...} stack {...} response = ... }`
- `run.job "Name" { main = { name: "...", input: {...} } }`

Was clear and consistent across examples.

**Feedback:** The learning curve is manageable when good examples are available. The validation tool provides clear error messages when issues exist.
