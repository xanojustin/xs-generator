# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 10:05 PST] - MCP validate_xanoscript parameter passing confusion

**What I was trying to do:** Validate my XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** The mcporter command syntax for passing parameters was unclear. I initially tried:
- JSON format: `'{"file_path": "/path/to/file"}'` - this gave error "expected array, received string"
- Double-dash format: `--file_path "/path/to/file"` - this treated the argument as code to validate
- Various quote/escape combinations

The correct syntax turned out to be: `mcporter call xano validate_xanoscript file_path="/path/to/file.xs"`

**Why it was an issue:** The error messages were confusing because when using `--file_path`, the tool interpreted it as XanoScript code to validate rather than a parameter. The error "Expecting --> function <-- but found --> '-' <--" was misleading since it was complaining about the `--` in the command line argument.

**Potential solution (if known):** 
- Better documentation or examples in the `mcporter list <server>` output showing the correct `key=value` syntax
- The error message could detect when a user passes what looks like a command-line flag (starting with `-`) and suggest the correct syntax
- Add a note in the tool description about the `key=value` parameter format vs `--key` format

---

## [2025-03-01 10:08 PST] - No documentation on run.job syntax

**What I was trying to do:** Find documentation on the `run.job` construct syntax for the run.xs entry point

**What the issue was:** Calling `xanoscript_docs({ topic: "run" })` returned only the generic documentation index, not specific run job syntax. I had to infer the correct syntax by looking at existing implementations in the ~/xs/ directory.

**Why it was an issue:** Without existing examples, I wouldn't have known that:
- The construct is `run.job "Name" { ... }`
- It uses `main = { name: "function_name", input: { ... } }` syntax
- The input uses colon notation (`key: value`) rather than equals (`key = value`)

**Potential solution (if known):**
- Add specific documentation for the `run` topic with run.job syntax examples
- Include the run.job construct in the quick reference table
- Document the difference between `input: { }` (colon, in run.job) and `input { }` (no colon, in function)

