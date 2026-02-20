# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 21:05 PST] - First Attempt Success

**What I was trying to do:** Implement a "find duplicates" coding exercise in XanoScript with a run job calling a function.

**What the issue was:** No issues encountered - the code passed validation on the first attempt.

**Why it was an issue:** N/A - This was a successful implementation.

**Potential solution (if known):** The documentation from `xanoscript_docs` was clear and sufficient for this implementation. The quick_reference mode provided concise syntax examples that were easy to follow.

---

## [2026-02-19 21:05 PST] - MCP Tool Discovery

**What I was trying to do:** Find and use the Xano MCP validation tool.

**What the issue was:** Initially didn't know how to access the MCP tools. Had to read the mcporter skill documentation and use `mcporter list` to discover the xano server was already configured.

**Why it was an issue:** Minor confusion about how to call MCP tools directly. The docs mentioned `xanoscript_docs` as if it were a standalone command, but it needs to be called via `mcporter call xano.xanoscript_docs`.

**Potential solution (if known):** The prompt could clarify that MCP tools are accessed via mcporter CLI when not running in an environment with direct MCP tool access.

---

## [2026-02-19 21:05 PST] - Documentation Clarity

**What I was trying to do:** Understand the correct syntax for function calls and variable declarations.

**What the issue was:** The quick_reference mode documentation was excellent for this purpose. It clearly showed:
- The difference between type names (text vs string, int vs integer)
- How to use filters like `to_text` and `get`
- The correct structure for `function.run` vs `run.job`

**Why it was an issue:** N/A - Documentation was clear and helpful.

**Potential solution (if known):** The `mode=quick_reference` option is very useful for context efficiency. Consider making this the default or more prominently recommended.
