# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 23:32 PST] - validate_xanoscript file_paths parameter parsing

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated values.

**What the issue was:** The MCP tool parsed the comma-separated file paths as individual characters instead of as separate file paths. When I passed:
```
file_paths="/Users/justinalbrecht/xs/subarray-sum-equals-k/run.xs,/Users/justinalbrecht/xs/subarray-sum-equals-k/function/subarray_sum.xs"
```

The tool reported errors like:
```
File not found: U
File not found: s
File not found: e
...
File not found: ,
...
```

It seems the parameter was split by character rather than by comma.

**Why it was an issue:** This prevented batch validation of multiple files, forcing me to call the tool twice (once per file) which is less efficient.

**Potential solution:** The MCP should properly parse array-type parameters when passed via CLI. The `file_paths` parameter is defined as an array of strings in the schema, but the CLI parsing appears to be treating the input as a single string and then splitting it incorrectly.

**Workaround:** Use `file_path` parameter for single files or `directory` parameter for batch validation of entire directories.

---

## [2026-02-20 23:33 PST] - Documentation was clear and helpful

**What I was trying to do:** Write XanoScript code for a run job and function.

**What went well:** The `xanoscript_docs` tool with `mode="quick_reference"` provided exactly the syntax patterns I needed. The documentation was clear about:
- Function structure with `input`, `stack`, and `response`
- Run job structure with `main = { name: ..., input: ... }`
- Variable access rules (`$input.field` for inputs, `$var.field` or just `$field` for stack variables)
- Type names (int, text, bool, int[], etc.)
- Filter syntax and the need for parentheses when using filters with operators

**Why it helped:** The quick reference mode was concise enough to not overwhelm context while still providing all necessary syntax details. The examples showing correct vs incorrect patterns (especially for input variable access) prevented common mistakes.

---
