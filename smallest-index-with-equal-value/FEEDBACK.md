# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 07:31 PST] - Directory path expansion issue

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool with a directory path.

**What the issue was:** When using `directory="~/xs/smallest-index-with-equal-value"`, the MCP returned "No .xs files found in directory". The tilde (`~`) character was not being expanded to the home directory path.

**Why it was an issue:** Had to manually convert `~` to the full absolute path `/Users/justinalbrecht/xs/smallest-index-with-equal-value` for validation to work.

**Potential solution (if known):** The MCP could expand shell shortcuts like `~` to the user's home directory before processing file paths, or the documentation could clarify that absolute paths are required.

---

## [2026-03-02 07:32 PST] - file_paths parameter format confusion

**What I was trying to do:** Validate multiple specific files using the `file_paths` parameter.

**What the issue was:** Tried passing `file_paths="~/xs/smallest-index-with-equal-value/run.xs,~/xs/smallest-index-with-equal-value/function/smallest_index.xs"` as a comma-separated string, but got error: "expected array, received string".

**Why it was an issue:** Wasn't clear from the documentation how to pass an array via CLI. Tried various formats but eventually switched to using the `directory` parameter instead.

**Potential solution (if known):** The CLI could accept comma-separated values for array parameters, or the help text could show an example of the correct array syntax for CLI usage (e.g., `file_paths: "path1,path2"` or using the flag multiple times).

---

## [2026-03-02 07:33 PST] - No syntax errors encountered

**What I was trying to do:** Write XanoScript code for a function and run job.

**What the issue was:** None! Both files passed validation on the first attempt.

**Why it was an issue:** N/A - positive feedback.

**Potential solution (if known):** The documentation provided by `xanoscript_docs` was comprehensive and clear. The examples for function declarations, run jobs, and control flow (foreach, conditional) were sufficient to write correct code without trial and error.

---
