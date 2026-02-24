# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 05:34 PST] - validate_xanoscript Parameter Format Confusion

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool

**What the issue was:** The parameter format for `mcporter call` was unclear and caused multiple failed attempts:
1. First tried passing JSON with `file_paths` array - got error "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"
2. Tried `directory` parameter - same error
3. Tried passing JSON via stdin - same error
4. Finally looked at `mcporter list xano` which showed the correct syntax: `file_path: "/path/to/file"`

**Why it was an issue:** The error message didn't clarify the expected parameter format. The docs say to use `file_paths` but that didn't work with JSON format. The colon-separated syntax (`file_path: "/path"`) was not documented in the initial instructions.

**Potential solution (if known):** 
- The `validate_xanoscript` tool should accept standard JSON parameters like `{"file_paths": [...]}` in addition to the colon format
- Error messages could suggest the correct format
- Documentation could include clear examples of the colon syntax for mcporter calls

---

## [2025-02-24 05:35 PST] - File Not Found with Tilde Path

**What I was trying to do:** Validate using tilde path: `~/xs/array-partition/run.xs`

**What the issue was:** Got "File not found" error when using `~/xs/array-partition/run.xs`

**Why it was an issue:** The MCP tool doesn't expand the tilde (`~`) to the home directory. Had to use full absolute path `/Users/justinalbrecht/xs/array-partition/run.xs`.

**Potential solution (if known):** 
- The MCP tool should expand `~` to `$HOME` before resolving paths
- Or document that absolute paths are required

---

## General Observations

### What Worked Well
- Once the correct syntax was found, validation was fast and clear
- The error messages for actual XanoScript syntax errors (though we didn't encounter any) are reportedly helpful
- The `mcporter list xano` command was very useful for discovering the correct parameter format

### XanoScript Syntax Notes
- The existing examples in `~/xs/` were invaluable for understanding the correct patterns
- The `run.job` syntax with `main = { name: ..., input: ... }` was not obvious from the general documentation
- The distinction between `var $x { value = ... }` and `var.update $x { value = ... }` is subtle but important
