# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 05:33 PST] - validate_xanoscript Tool Error

**What I was trying to do:** Validate the XanoScript files (`run.xs` and `function/maximum_depth_binary_tree.xs`) using the MCP `validate_xanoscript` tool.

**What the issue was:** The validation tool returned an error: `source.match is not a function`

**Why it was an issue:** This prevented me from validating my code syntax before committing. I had to rely on pattern matching from existing exercises instead of getting real-time validation feedback.

**Steps taken:**
1. Attempted validation with `file_paths` array parameter - failed
2. Attempted validation with `file_path` single file parameter - failed
3. Attempted validation with `directory` parameter - failed

**Potential solution:** The MCP server may have a bug in the validation logic when processing file paths. The error suggests a JavaScript string method `.match()` is being called on something that isn't a string (possibly undefined or null).

---

## [2026-02-21 05:30 PST] - xanoscript_docs Topic Parameter Error

**What I was trying to do:** Retrieve specific XanoScript documentation topics (quickstart, functions, run) to understand syntax patterns.

**What the issue was:** The `xanoscript_docs` tool returned error: `p.split is not a function` when called with `topic` parameter.

**Why it was an issue:** I couldn't get specific topic documentation, only the general README worked (when called without parameters).

**What worked:** Calling `xanoscript_docs` without any parameters returned the general README documentation successfully.

**Potential solution:** The topic parameter handling in the MCP may have a bug where it's trying to call `.split()` on an undefined value when processing the topic parameter.

---

## General Observations

**Positive:**
- The MCP server connects and responds quickly
- The general `xanoscript_docs` call (without parameters) works and provides useful overview documentation
- Tool schema introspection works (`mcporter list xano --schema`)

**Issues:**
- Specific topic queries for documentation fail
- File validation fails regardless of input method (file_path, file_paths, directory)
- The `2>&1` stderr redirection in the shell produces a strange "command not found: 1" error before the actual output

**Suggested improvements:**
1. Fix the `.split()` error in `xanoscript_docs` when topic parameter is provided
2. Fix the `.match()` error in `validate_xanoscript`
3. Add more detailed error messages that indicate which file/line caused validation failures
