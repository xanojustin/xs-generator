# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 17:35 PST] - Successful First-Try Validation

**What I was trying to do:** Create a complete XanoScript exercise with a run job and function for the "Count Number of Teams" problem.

**What the issue was:** No issues encountered - both files passed validation on the first attempt.

**Why it was an issue:** N/A - This is positive feedback that the documentation was clear enough to write correct XanoScript on the first try.

**What worked well:**
1. The `xanoscript_docs` tool provided comprehensive documentation
2. The examples in the "functions" and "run" topics were clear and applicable
3. The essentials guide helped avoid common mistakes (like using `elseif` not `else if`)
4. The validation tool gave clear feedback with checkmarks

**Potential improvements:**
1. The documentation mentions `get:` filter for arrays but doesn't clearly specify that the index needs to be converted to text with `to_text` filter. I inferred this from the pattern `($j|to_text)` being used in string contexts.
2. It would be helpful to have a "Common Array Operations" section in the essentials documentation since array indexing is a frequent operation.

---

## [2026-03-03 17:30 PST] - MCP Tool Discovery

**What I was trying to do:** Find and use the Xano MCP to validate XanoScript code.

**What the issue was:** Initially unclear which MCP tool to call for documentation vs validation.

**Why it was an issue:** Had to explore the available tools to understand the workflow.

**Potential solution:** A quick-start guide in the exercise prompt would be helpful, e.g.:
1. `mcporter call xano.xanoscript_docs topic="functions"` for docs
2. `mcporter call xano.validate_xanoscript file_path="..."` for validation
