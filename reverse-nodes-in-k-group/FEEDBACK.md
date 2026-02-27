# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 22:35 PST] - Successful Implementation

**What I was trying to do:** Create a complete XanoScript coding exercise (reverse-nodes-in-k-group) with a run job and function

**What the issue was:** No issues encountered - both files passed validation on first attempt

**Why it was an issue:** N/A

**Potential solution (if known):** The documentation from `xanoscript_docs` was clear enough to write valid code on the first try

---

## [2026-02-26 22:30 PST] - Documentation Discovery

**What I was trying to do:** Find the correct XanoScript syntax for functions and run jobs

**What the issue was:** Initially wasn't sure how to access the Xano MCP tools

**Why it was an issue:** Had to read the SKILL.md for mcporter to understand how to call MCP tools via `mcporter call`

**Potential solution (if known):** Consider adding a quick reference in the exercise generator prompt about using `mcporter call xano.<tool_name>` to access the Xano MCP

---

## General Observations

### What Worked Well
1. The `xanoscript_docs` tool with `topic=essentials` provided the critical syntax rules (e.g., `elseif` not `else if`, `text` not `string`)
2. The `topic=functions` documentation clearly explained function structure and calling conventions
3. The `topic=run` documentation showed exactly how to structure run jobs
4. The validation tool provided immediate feedback

### Suggestions for Improvement
1. **MCP Discovery:** Make it clearer in the prompt that the Xano MCP is already configured and accessible via `mcporter call xano.<tool>`
2. **Type Reference:** A quick reference card for type conversions (text vs string, int vs integer, etc.) would be helpful
3. **Linked List Pattern:** Since several exercises use linked lists, documenting the standard linked list representation (array of nodes with `val` and `next` indices) in the essentials would help

