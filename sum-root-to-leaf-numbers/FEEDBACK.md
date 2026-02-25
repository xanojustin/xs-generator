# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 19:35 PST] - No Issues - First Try Success!

**What I was trying to do:** Create a complete XanoScript exercise for "Sum Root to Leaf Numbers" - a binary tree problem

**What the issue was:** No issues encountered! The code validated successfully on the first attempt.

**Why it was (not) an issue:** N/A - everything worked smoothly

**What went well:**
1. The `xanoscript_docs` tool provided clear, comprehensive documentation on:
   - `run.job` structure with `main` attribute containing `name` and `input`
   - Function structure with `input`, `stack`, and `response` blocks
   - How to use `function.run` to call functions
   - Control flow (while, foreach, conditional)
   - Variable declaration and updates

2. The iterative DFS pattern from the existing `path_sum` exercise was a great reference for:
   - Using a stack with `array.push` and `array.pop`
   - Storing complex state (node + current number) in stack entries
   - Checking for leaf nodes by testing `left` and `right` for null
   - Using `math.add` for accumulating results

3. Validation tool worked perfectly with the `--args` JSON format

**Potential improvements (if any):**
- The cheat sheet documentation was very minimal (just "Documentation version: 2.1.0") - the full docs were excellent though
- Could benefit from more binary tree / graph algorithm examples in the docs

---

## [2025-02-24 19:35 PST] - mcporter syntax confusion

**What I was trying to do:** Call the validate_xanoscript tool with multiple file paths

**What the issue was:** Initially tried `file_paths:='[...]'` syntax which failed. Had to use `--args '{"file_paths": [...]}'` format instead.

**Why it was an issue:** The error message was clear but the syntax wasn't obvious from the tool schema alone. Had to guess the correct mcporter invocation style.

**Potential solution:** Add examples in the xanoscript_docs for common MCP tool calls showing the exact mcporter syntax needed.
