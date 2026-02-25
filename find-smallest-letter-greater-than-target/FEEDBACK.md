# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 19:10 PST] - MCP Tool Discovery

**What I was trying to do:** Find the correct MCP tool name for XanoScript documentation

**What the issue was:** The prompt mentioned calling `xanoscript_docs` directly, but the actual tool is namespaced under the `xano` MCP server as `xano.xanoscript_docs`.

**Why it was an issue:** Initial attempts to call `xanoscript_docs` failed because mcporter couldn't find that server. Had to run `mcporter list` to discover the correct server name.

**Potential solution:** The prompt could be updated to mention using `mcporter list` first to discover available MCP servers, or clarify that the tool is accessed via `xano.xanoscript_docs`.

---

## [2025-02-24 19:12 PST] - File Path Expansion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The tool doesn't expand `~` to the home directory. Using `~/xs/...` paths resulted in "File not found" errors.

**Why it was an issue:** Had to convert to absolute paths (`/Users/justinalbrecht/xs/...`) for validation to work.

**Potential solution:** The MCP could support shell-style path expansion (tilde expansion) for better UX, or the documentation could warn about using absolute paths only.

---

## [2025-02-24 19:15 PST] - Documentation Completeness

**What I was trying to do:** Understand the complete structure for run jobs and functions

**What the issue was:** The quick_reference mode provides minimal syntax but doesn't show complete examples of how run.job connects to functions via the `main` block.

**Why it was an issue:** Had to look at existing code examples in the `~/xs/` directory to understand the exact structure of `run.job` with the `main` object containing `name` and `input`.

**Potential solution:** The `run` topic documentation could include a complete minimal example showing the relationship between run.job and the function it calls.

---

## [2025-02-24 19:18 PST] - String Character Comparison

**What I was trying to do:** Compare characters (single-letter strings) in XanoScript

**What the issue was:** Was unsure if XanoScript supports direct string comparison with `>` and `<` operators, or if ASCII values would be compared correctly.

**Why it was an issue:** The problem requires comparing letters alphabetically. I assumed standard string comparison works (which it does in most languages for single characters), but wasn't certain if XanoScript had special handling.

**Potential solution:** The syntax documentation could clarify string comparison behavior - whether it's lexicographic/alphabetical and if single-character comparisons work as expected.

---

## Summary

Overall the MCP worked well. The main friction points were:
1. Discovering the correct tool names/namespacing
2. Path handling (no tilde expansion)
3. Need to reference existing examples for complete structural patterns

The validation tool is excellent - caught no errors because the documentation was sufficient for this relatively straightforward exercise.
