# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 20:35 PST] - Documentation Topic Responses Are Identical

**What I was trying to do:** Get specific documentation about run jobs, functions, and syntax patterns by calling `xanoscript_docs` with different topics.

**What the issue was:** When I called `xanoscript_docs` with topics `quickstart`, `run`, `functions`, and `syntax`, I received the exact same general documentation every time. The content was identical regardless of the topic parameter.

**Why it was an issue:** I couldn't get detailed information about:
- The specific syntax for `run.job` constructs
- Detailed function patterns and examples
- Language syntax specifics (loops, conditionals, variable operations)
- How to properly structure different constructs

I had to rely on examining existing implementations in the `~/xs/` directory to understand the actual patterns, which worked but was less efficient than having proper documentation.

**Potential solution:** The MCP server should return topic-specific documentation when different topics are requested. The documentation index shows many specific topics (run, functions, syntax, types, etc.) but they all returned the same generic reference.

---

## [2025-02-23 20:35 PST] - No Issues with validate_xanoscript

**What I was trying to do:** Validate my XanoScript files using the `validate_xanoscript` tool.

**What happened:** The validation tool worked correctly on the first attempt. Both files passed validation without errors.

**Why this is worth noting:** Unlike some previous exercises where multiple validation cycles were needed, the circular buffer implementation passed immediately. This suggests my understanding of XanoScript patterns has improved through examining existing implementations.

---

## [2025-02-23 20:35 PST] - var.update Pattern Discovery

**What I was trying to do:** Update variable values in loops (like incrementing counters).

**What I discovered:** Through examining existing code, I found that `var.update $varname { value = ... }` is the pattern for updating existing variables, while `var $varname { value = ... }` creates new variables.

**Why it was initially confusing:** This distinction isn't clear in the general documentation. Understanding when to use `var` vs `var.update` is critical for loops and conditional logic.

**Potential solution:** Include clear examples of `var.update` usage in the quickstart documentation, especially for common patterns like:
- Incrementing counters in loops
- Accumulating results
- Modifying state variables
