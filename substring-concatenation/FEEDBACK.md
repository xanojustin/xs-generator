# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 14:35 PST] - File Paths Parameter Parsing Issue

**What I was trying to do:** Validate multiple files by passing a comma-separated list to the `file_paths` parameter of `validate_xanoscript`

**What the issue was:** When using `mcporter call xano.validate_xanoscript file_paths="path1,path2"`, the comma-separated string was being split character by character, resulting in each character being treated as a separate file path. The output showed errors like "File not found: ~", "File not found: /", "File not found: U", etc.

**Why it was an issue:** This made it impossible to validate multiple specific files in a single call using the `file_paths` parameter. The tool was interpreting the comma-separated string incorrectly.

**Potential solution (if known):** 
1. The MCP tool should properly parse comma-separated file paths as an array of strings, not as individual characters
2. Alternatively, document that `file_paths` requires a different format (perhaps JSON array syntax)
3. The `--args` flag with mcporter might work better: `mcporter call xano.validate_xanoscript --args '{"file_paths":["path1","path2"]}'`

**Workaround used:** Used the `directory` parameter instead, which worked correctly: `mcporter call xano.validate_xanoscript directory="/path/to/dir"`

---

## [2026-02-23 14:30 PST] - Tilde (~) Path Expansion Not Supported

**What I was trying to do:** Use `~/xs/` as a shorthand for the home directory path

**What the issue was:** The MCP validation tool does not expand the tilde (`~`) character to the home directory. It treated `~` as a literal character in the path.

**Why it was an issue:** Standard shell behavior is to expand `~` to `$HOME`, but the MCP tool doesn't do this, causing file not found errors.

**Potential solution (if known):** The tool could implement path expansion for `~` to match standard shell behavior, or document that full absolute paths are required.

**Workaround used:** Used the full absolute path `/Users/justinalbrecht/xs/` instead of `~/xs/`

---

## General Observations

### Positive
- The validation tool provides clear error messages with line/column positions when there are syntax errors
- The directory validation mode works well and validates all `.xs` files recursively
- Documentation via `xanoscript_docs` is comprehensive and helpful

### Suggestions
1. Consider adding a `file_path` (singular) parameter for validating a single file, which would be simpler than using `directory` for single-file validation
2. The `file_paths` array parameter behavior with comma-separated strings could be improved or better documented
