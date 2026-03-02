# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 19:32 PST] - No Issues Encountered

**What I was trying to do:** Create a XanoScript coding exercise for "split-array-largest-sum" using a run job that calls a function with binary search logic.

**What the issue was:** No issues encountered. Both the run.xs and function/split_array_largest_sum.xs files validated successfully on the first attempt.

**Why it was (not) an issue:** The documentation from `xanoscript_docs` was clear and comprehensive. Key helpful points:
- The `run.job` syntax with `main = { name: "...", input: { ... } }` was clearly documented
- The `function` structure with `input`, `stack`, and `response` blocks was well explained
- Common mistakes section helped avoid pitfalls like:
  - Using `elseif` instead of `else if`
  - Using `text` instead of `string` for type names
  - Proper parentheses usage around filters in expressions

**Potential solution (if known):** N/A - everything worked as expected.

---

## [2025-03-01 19:33 PST] - Tool Discovery Note

**What I was trying to do:** Discover available MCP tools and their parameters.

**What the issue was:** Initially wasn't sure how to call `xanoscript_docs` with specific topics.

**Why it was an issue:** Had to use `mcporter list xano-developer-mcp` to discover the tool signatures, then figure out the proper argument format.

**Potential solution (if known):** The help text could include a quick example of calling `xanoscript_docs` with a topic parameter, e.g., `mcporter call --stdio "npx -y @xano/developer-mcp" xanoscript_docs topic=essentials mode=full`
