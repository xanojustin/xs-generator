# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 21:05 PST] - Issue 1: run.job syntax documentation gap

**What I was trying to do:** Create a run.job that calls a function with multiple test inputs and logs results

**What the issue was:** I incorrectly assumed run.job had the same structure as a function (with `description`, `input {}`, `stack {}`, `response` blocks). The validation error showed: "The argument 'description' is not valid in this context" and "The argument 'input' is not valid in this context".

**Why it was an issue:** The documentation I initially read (functions topic) made me think run.job was just another construct like function. It took calling the run-specific docs to understand that run.job is a configuration pointing to a function, not an executable block itself.

**Potential solution:** Include a prominent warning/note in the function documentation that run.job has a completely different syntax. The "Quick Reference" table in the main docs lists `run` under "Run job and service configurations" but doesn't clearly indicate the syntax is different from function/task.

---

## [2026-02-22 21:07 PST] - Issue 2: Comments on same line as value cause parse errors

**What I was trying to do:** Add inline comments to document array initialization: `value = [1, 1]  // dp[0] = 1, dp[1] = 1`

**What the issue was:** The parser threw an error at the `/` character of the comment, expecting various tokens but finding `/`. Moving the comment to its own line fixed it.

**Why it was an issue:** Most programming languages allow inline comments after code. XanoScript only supports `//` style comments but apparently they must be on their own line, not at the end of a statement line.

**Potential solution:** Either:
1. Document this clearly in the syntax/quickstart docs with an example showing comments must be on separate lines
2. Or fix the parser to support end-of-line comments

The current docs say "XanoScript only supports `//` for comments" but don't clarify the positioning restriction.

---

## [2026-02-22 21:02 PST] - Issue 3: MCP stdio invocation complexity

**What I was trying to do:** Call the validate_xanoscript tool via mcporter

**What the issue was:** Initially tried `mcporter call xano.validate_xanoscript` but got "Unknown MCP server 'xano'". Had to use `--stdio "npx -y @xano/developer-mcp"` syntax which is more verbose.

**Why it was an issue:** The mcporter `list` command showed `xano` as a server, but calling directly didn't work. The error message didn't suggest using `--stdio` mode.

**Potential solution:** The MCP server registration could be improved, or the error message could suggest trying stdio mode if the server isn't found in the daemon registry.

---

## [2026-02-22 21:00 PST] - Issue 4: Syntax error messages could be more helpful

**What I was trying to do:** Understand why my code was failing validation

**What the issue was:** The error message "Expecting: one of these possible Token sequences... but found: '/'" lists 29 possible tokens which is overwhelming. It includes things like `ExclamationToken`, `MultiLineExpression`, `!int`, `!array` which aren't meaningful to a human reading the error.

**Why it was an issue:** When the issue was simply "comments must be on their own line", the error message made it seem like a much more complex parsing problem.

**Potential solution:** Provide a simpler, more human-readable error message first, then the technical token list as secondary detail. For example: "Comments must be on their own line. Found comment syntax after code on line X."
