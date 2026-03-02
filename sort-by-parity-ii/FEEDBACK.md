# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 10:00 PST] - Successful First-Time Validation

**What I was trying to do:** Create a XanoScript coding exercise (Sort Array By Parity II) with a run job and function.

**What the issue was:** No issues encountered! Both the run.xs and function/sort_by_parity_ii.xs files passed validation on the first attempt.

**Why it was an issue:** N/A - everything worked smoothly.

**Potential solution (if known):** N/A

---

## [2025-03-02 10:00 PST] - Xano MCP Tool Parameter Format

**What I was trying to do:** Validate multiple files using the `file_paths` parameter of the `validate_xanoscript` tool.

**What the issue was:** The initial attempt with comma-separated string failed: `"file_paths: Invalid input: expected array, received string"`. I had to switch to using the `directory` parameter instead.

**Why it was an issue:** The expected format for array parameters wasn't clear from the initial tool description. The mcporter CLI syntax for passing arrays could be better documented.

**Potential solution (if known):** Consider updating the tool description with clear examples of how to pass array parameters via mcporter CLI, or support comma-separated strings as a fallback.

---

## [2025-03-02 10:00 PST] - Documentation Clarity

**What I was trying to do:** Understand XanoScript syntax for the exercise.

**What the issue was:** No issues! The `xanoscript_docs` tool with topics "essentials", "functions", and "run" provided all the necessary information to write correct XanoScript code.

**Why it was an issue:** N/A - documentation was comprehensive and helpful.

**Notes:**
- The distinction between `elseif` (correct) and `else if` (incorrect) was clearly documented
- The `run.job` structure with `main = { name: ..., input: ... }` was well explained
- The `function` structure with `input`, `stack`, and `response` was clear
- Type names (`int[]`, `text`, `bool`) were well documented
