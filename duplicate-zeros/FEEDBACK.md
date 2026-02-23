# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 07:35 PST] - CLI Argument Parsing Issue with Comma-Separated Paths

**What I was trying to do:** Validate multiple `.xs` files using the `validate_xanoscript` tool with `file_paths` parameter.

**What the issue was:** When using `file_paths=~/xs/duplicate-zeros/run.xs,~/xs/duplicate-zeros/function/duplicate_zeros.xs`, the MCP CLI parser treated each character after the comma as a separate file path. This resulted in 76 "File not found" errors for individual characters like "x", "s", "/", "d", "u", "p", etc.

**Why it was an issue:** The comma-separated list format documented in the MCP schema doesn't work correctly via the mcporter CLI. The parsing logic appears to be splitting incorrectly.

**Workaround used:** Used the `directory` parameter instead with the full path `/Users/justinalbrecht/xs/duplicate-zeros`, which worked perfectly and validated both files.

**Potential solution:** The MCP server or mcporter CLI should properly handle comma-separated file paths, or the documentation should be updated to recommend using `directory` for multiple files.

---

## [2026-02-23 07:35 PST] - Documentation was Clear and Helpful

**What I was trying to do:** Write correct XanoScript syntax for functions and run jobs.

**What worked well:** The `xanoscript_docs` tool with `mode=quick_reference` provided concise, actionable syntax examples. The function and run documentation clearly showed:
- The exact structure for `function "name" { input { } stack { } response = $var }`
- How to use `function.run` with input parameters
- The `run.job` structure with `main = { name: "...", input: { ... } }`

**Why it helped:** The quick reference format was efficient for context usage while still providing the essential patterns needed to write valid code.

**Potential improvement:** Consider adding an example of array indexing syntax (`$arr[$index]`) to the syntax quick reference, as this was needed for the duplicate zeros algorithm but wasn't explicitly documented in the quick reference.
