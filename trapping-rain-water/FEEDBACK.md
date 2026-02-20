# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 09:35 PST] - Math Operation Naming

**What I was trying to do:** Create a trapping rain water function that decrements a pointer variable

**What the issue was:** Used `math.subtract` instead of `math.sub`

**Why it was an issue:** The XanoScript parser rejected `math.subtract` with error: "Expecting: one of these possible Token sequences: [add], [div], [mod], [mul], [sub] but found: 'subtract'"

**Potential solution (if known):** The documentation mentions `math.add` but doesn't clearly list all math operations. Would be helpful to have a complete reference of math operations (add, sub, mul, div, mod, etc.) in the functions or quickstart documentation.

**Workaround:** Changed `math.subtract` to `math.sub` and validation passed.

---

## [2025-02-20 09:30 PST] - MCP Argument Parsing

**What I was trying to do:** Validate multiple files using the validate_xanoscript tool

**What the issue was:** Initially tried using `file_paths` parameter with space-separated values, but mcporter interpreted the path string as individual characters

**Why it was an issue:** The command `mcporter call xano.validate_xanoscript file_paths="path1" file_paths="path2"` split the path into individual characters and tried to validate each character as a file

**Potential solution (if known):** Using `--args '{"file_paths": ["path1", "path2"]}'` JSON format works correctly. This could be documented more clearly in the MCP tool usage examples.

**Workaround:** Used JSON args format: `--args '{"file_paths": ["/path/to/file1.xs", "/path/to/file2.xs"]}'`

