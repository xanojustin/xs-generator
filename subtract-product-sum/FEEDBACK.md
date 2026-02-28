# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 04:05 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that calls a function with test inputs and logs results

**What the issue was:** I initially wrote `run.job {` followed by a `stack` block containing the test logic, similar to how `function` blocks work. However, this resulted in a syntax error: `Expecting: one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'`

**Why it was an issue:** The error message was cryptic and didn't clearly indicate that `run.job` requires a name string (e.g., `run.job "My Job Name"`) and uses a `main` property to specify which function to call, rather than having an inline `stack` block.

**Potential solution (if known):** 
1. Improve the parser error message to suggest the correct syntax: `run.job "Name" { main = { name: "function_name" } }`
2. Add documentation examples that explicitly show the minimal `run.job` syntax
3. Consider allowing an inline `stack` block for simple test jobs (though this would be a language feature change)

---

## [2026-02-28 04:08 PST] - Documentation discovery was smooth

**What I was trying to do:** Learn XanoScript syntax for functions and run jobs

**What the issue was:** No issues - the `xanoscript_docs` tool worked well and provided clear documentation

**Why it was an issue:** N/A - this was a positive experience

**Potential solution (if known):** The `quick_reference` mode was perfect for getting just enough context to write code efficiently. The examples in the `run` topic documentation were especially helpful once I found them.

---

## [2026-02-28 04:10 PST] - Validation tool file_paths parameter format

**What I was trying to do:** Validate multiple files at once using the `validate_xanoscript` tool

**What the issue was:** Initially tried passing `file_paths` as a comma-separated string via CLI, but the tool expects a JSON array. The error was: `Invalid arguments: file_paths: Invalid input: expected array, received string`

**Why it was an issue:** Had to switch to using `--args` with JSON format instead of the simpler CLI syntax

**Potential solution (if known):** 
1. Accept comma-separated file paths as a string and parse internally
2. Improve the CLI help text to show examples of the JSON array format
3. Allow multiple `--file-path` flags that get collected into an array
