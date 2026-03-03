# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 16:05 PST] - Run Job Syntax Confusion

**What I was trying to do:** Create a run job that executes multiple test cases and logs their results.

**What the issue was:** I incorrectly assumed `run.job` supported the same structure as `function` with `description` and `stack` blocks. The validation failed with errors:
- "The argument 'description' is not valid in this context"
- "The argument 'stack' is not valid in this context"

**Why it was an issue:** The `run.job` syntax is fundamentally different from `function`. Run jobs use a `main` property to specify which function to call, rather than containing logic directly. This wasn't immediately clear from the quick reference documentation I initially read.

**Potential solution (if known):** The quick reference for `run` could include a minimal complete example showing the `main = { name: "...", input: {...} }` syntax, not just the directory structure. The distinction between `run.job` (requires `main`) and `run.service` (uses optional `pre`) could be highlighted more prominently in quick reference mode.

---

## [2026-03-02 16:08 PST] - File Path Expansion Issue

**What I was trying to do:** Validate files using the `file_paths` parameter with tilde (`~`) expansion for the home directory.

**What the issue was:** The MCP validation tool didn't expand `~/xs/...` to the full path, resulting in "File not found" errors. When I tried to escape the JSON array properly in shell, I got parse errors.

**Why it was an issue:** Using `file_paths='["~/path"]'` failed silently with file not found errors. Switching to the `directory` parameter worked, but it would be nice to validate specific files.

**Potential solution (if known):** Either:
1. Document that `~` is not expanded and full paths are required
2. Add tilde expansion support in the MCP server
3. Provide clearer examples of the shell escaping needed for `file_paths`

---

## [2026-03-02 16:10 PST] - Run Job Cannot Contain Logic Directly

**What I was trying to do:** Put test execution logic (multiple function calls, debug logging) directly in the run.job's stack block.

**What the issue was:** Run jobs don't have a `stack` block at all - they only have a `main` property that references a function. This means I had to create a separate wrapper function (`find_kth_bit_tests`) just to run multiple tests.

**Why it was an issue:** This creates an extra indirection. The natural mental model is "run job = script that runs", but actually "run job = configuration that points to a function". It took an extra documentation lookup to understand this.

**Potential solution (if known):** Consider allowing inline stack blocks in run jobs for simple cases, or document this architectural decision more prominently. The current design enforces separation of concerns (run config vs execution logic), which is good, but could be surprising to new users.

---

## [2026-03-02 16:12 PST] - Missing pow Filter Documentation

**What I was trying to do:** Calculate 2^n using the `pow` filter to determine the length of Sn.

**What the issue was:** I used `2|pow:$input.n` hoping it would work based on general programming knowledge, but I didn't see `pow` explicitly documented in the syntax reference I retrieved.

**Why it was an issue:** I got lucky that `pow` exists, but if it didn't, I would have had to manually compute power (e.g., using a loop). The math filters available aren't clearly listed in the quick reference.

**Potential solution (if known):** Include a list of available math filters/functions in the `syntax/functions` or `syntax` quick reference. Common ones like `pow`, `sqrt`, `abs`, `min`, `max`, `floor`, `ceil`, `round` would be helpful to document.

---
