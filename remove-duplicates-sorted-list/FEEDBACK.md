# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 08:35 PST] - xanoscript_docs tool error

**What I was trying to do:** Retrieve XanoScript documentation using the `xanoscript_docs` tool without parameters

**What the issue was:** The tool returned error: "Error reading XanoScript documentation: p.split is not a function"

**Why it was an issue:** I needed to get the README/overview documentation before starting, but the tool failed when called without parameters

**Potential solution (if known):** The tool should handle being called without parameters gracefully, or the documentation should specify that at least one parameter (like `topic=readme`) is required

**Workaround:** I used `topic=functions mode=quick_reference` and other specific topic calls instead

---

## [2026-02-22 08:37 PST] - validate_xanoscript file_paths parameter parsing issue

**What I was trying to do:** Validate multiple files using the `file_paths` array parameter

**What the issue was:** When passing a comma-separated string like `"/path/to/file1.xs,/path/to/file2.xs"`, the tool parsed each character as a separate file path, resulting in errors like "File not found: U", "File not found: s", "File not found: e", etc.

**Why it was an issue:** I wanted to batch validate all files at once, but the array parsing doesn't work as expected with mcporter's command-line interface

**Potential solution (if known):** The MCP tool should properly parse JSON arrays passed from mcporter, or the mcporter documentation should show the correct syntax for passing array parameters

**Workaround:** I validated each file individually using `file_path` parameter instead of `file_paths`

---

## [2026-02-22 08:38 PST] - validate_xanoscript directory path expansion issue

**What I was trying to do:** Validate all .xs files in the exercise directory using the `directory` parameter with `~/xs/remove-duplicates-sorted-list`

**What the issue was:** The tool returned "No .xs files found in directory: ~/xs/remove-duplicates-sorted-list" - the tilde (~) path expansion didn't work

**Why it was an issue:** Common shell conventions like `~` for home directory should be supported, or the error should be clearer about using absolute paths

**Potential solution (if known):** Either support shell-style path expansion in the MCP tool, or document that absolute paths are required

**Workaround:** Used absolute paths starting with `/Users/justinalbrecht/`

---

## General Observations

1. **Documentation is helpful:** Once I got the quick_reference docs, the XanoScript syntax was clear and consistent

2. **Pattern consistency:** The existing exercises in ~/xs/ were excellent reference material for understanding the linked list representation and coding patterns

3. **Type system is strict:** The distinction between `int`, `int?`, `int[]` etc. is well-documented and the validation catches type issues effectively

4. **Filter syntax:** The requirement for parentheses when using filters with operators (e.g., `($arr|count) == 0`) is important and well-documented in the quickstart

