# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 01:37 PST] - Parameter passing confusion with mcporter

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** Initially struggled with the correct parameter format for `mcporter call`. The tool description shows JSON-like parameter format (e.g., `{"file_path": "..."}`) but mcporter actually requires `key=value` format.

**Why it was an issue:** Spent several attempts trying different formats:
- JSON format: `'{"file_path": "..."}'` - didn't work
- Named with colons: `'file_path: "/path"'` - didn't work  
- Finally worked: `file_path=/path/to/file`

**Potential solution:** The tool description should clarify that mcporter uses `key=value` format, not JSON. Or update the examples to show the correct format.

---

## [2026-03-02 01:38 PST] - File path resolution issues

**What I was trying to do:** Validate files using relative paths or `~` home directory expansion

**What the issue was:** The `file_path` parameter doesn't expand `~` or relative paths. `~/xs/contiguous-array/run.xs` and relative paths failed with "File not found" errors.

**Why it was an issue:** Had to use the full absolute path `/Users/justinalbrecht/xs/contiguous-array/run.xs` for validation to work.

**Potential solution:** The MCP should expand `~` to the home directory and support relative paths from the current working directory.

---

## [2026-03-02 01:35 PST] - JSON escaping issues with code parameter

**What I was trying to do:** Pass XanoScript code directly via the `code` parameter for validation

**What the issue was:** When passing multi-line code with special characters through shell, the code gets mangled (newlines stripped, quotes escaped incorrectly).

**Why it was an issue:** The error message showed the code was compressed into a single line with no newlines: `// Run job... // Finds... run.job...`

**Potential solution:** Either document that `file_path` is preferred over `code`, or provide guidance on proper shell escaping for the `code` parameter.

---

## Overall Assessment

The `validate_xanoscript` tool works well once you figure out the correct parameter format. The validation is fast and helpful. The main friction points are:

1. Parameter format mismatch between documentation and actual usage
2. Lack of path expansion (no `~` or relative paths)
3. No examples showing the correct mcporter call syntax

The XanoScript syntax itself was straightforward once I reviewed existing examples in the `~/xs/` folder.
