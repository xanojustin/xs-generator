# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-27 19:10 PST - Validation Tool Parameter Naming

**What I was trying to do:** Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** Initially tried using `files` parameter, then `file_paths` with relative paths, both failed. The error message said "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" but didn't clarify which format was expected for each.

**Why it was an issue:** Had to guess which parameter name was correct and what format the paths should be in (relative vs absolute)

**Potential solution:** 
- Document the exact parameter names and expected formats in the tool description
- The `directory` parameter worked with absolute paths
- Consider supporting relative paths from current working directory

---

## 2025-02-27 19:15 PST - First-Try Validation Success

**What I was trying to do:** Write valid XanoScript code for the raindrops exercise

**What happened:** Both files passed validation on the first attempt

**Key learnings that helped:**
1. Reading the `essentials`, `functions`, and `run` documentation topics first was essential
2. The documentation clearly shows proper syntax for:
   - `function.run` vs `run.job` (different constructs!)
   - Type names (`int`, `text`, not `integer`, `string`)
   - Modulo operator `%` works as expected
   - String concatenation with `~`
   - Conditional blocks with `if` (not `else if`, but `elseif`)

**Why it worked:** Having comprehensive documentation before writing code made all the difference

