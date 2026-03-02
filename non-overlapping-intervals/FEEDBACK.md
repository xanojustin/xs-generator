# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 09:00 PST] - Initial Setup

**What I was trying to do:** Create a new XanoScript coding exercise for the non-overlapping-intervals problem

**What the issue was:** Had to discover the correct Xano MCP tools and XanoScript syntax patterns

**Why it was an issue:** The documentation from `xanoscript_docs` is generic and doesn't show the actual patterns used in exercises. Had to examine existing implementations to understand:
- How `run.job` calls functions via `main = { name: "...", input: {...} }`
- How to use `var.update` vs `math.add` for updating variables
- How to access object properties in arrays (`$sorted_intervals[$i]`)

**Potential solution (if known):** Provide more specific documentation for run jobs and function invocation patterns

---
