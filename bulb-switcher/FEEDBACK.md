# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 02:05 PST] - MCP Tool Parameter Naming Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` MCP tool

**What the issue was:** The tool description says it accepts parameters like `file_path`, `file_paths`, `directory`, or `code`, but I kept getting the error:
```
Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required
```

Even when I passed these parameters in JSON format like `'{"file_path": "/path/to/file"}'`, the tool rejected them.

**Why it was an issue:** I couldn't figure out the correct way to call the tool. The error message suggested the parameters were recognized but not being accepted.

**Potential solution (if known):** The correct syntax uses the tool-specific call format `mcporter call xano.validate_xanoscript file_path="/path/to/file"` instead of the generic `mcporter call xano validate_xanoscript` format. The MCP tool name is `xano.validate_xanoscript`, not `xano` with `validate_xanoscript` as a subcommand. This was unclear from the initial documentation.

---

## [2026-03-01 02:08 PST] - Documentation Discovery

**What I was trying to do:** Get specific syntax documentation for XanoScript to understand available filters like `sqrt`

**What the issue was:** Calling `xanoscript_docs` with topics like `essentials`, `functions`, and `run` all returned the same general overview documentation instead of specific syntax details.

**Why it was an issue:** I couldn't find specific documentation about math filters like `sqrt`, `floor`, etc. I had to guess that they existed based on common patterns.

**Potential solution (if known):** Better topic segmentation or a searchable syntax reference that lists all available filters by category (math, string, array, etc.).

---

## [2026-03-01 02:10 PST] - Run Job Syntax

**What I was trying to do:** Create a run job that calls a function

**What the issue was:** The exercise instructions mention using `function.run` to call the solution function, but all existing examples in the `~/xs/` directory use the `main = { name: "function_name", input: { ... } }` syntax inside `run.job` instead.

**Why it was an issue:** The discrepancy between the instructions (`function.run`) and the actual pattern used in existing exercises (`main = { name: ..., input: ... }`) was confusing.

**Potential solution (if known):** Update the exercise instructions to match the actual pattern used in the codebase, or clarify when each syntax should be used.

---

## Overall Notes

The validation tool worked well once I figured out the correct calling convention. The XanoScript syntax was intuitive enough that I could write valid code on the first attempt, though having a comprehensive filter/function reference would be helpful.
