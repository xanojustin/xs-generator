# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 08:05 PST] - File Path Validation Issue

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated paths.

**What the issue was:** The MCP tool appears to split the comma-separated string and treat each character after the comma as a separate file path. The command:
```
mcporter call xano.validate_xanoscript file_paths=/path/to/file1.xs,/path/to/file2.xs
```
Resulted in errors like "File not found: U", "File not found: s", "File not found: e", etc. - treating each character after the comma as a separate filename.

**Why it was an issue:** I had to validate files individually with separate calls instead of batch validating them.

**Potential solution (if known):** The MCP should either:
1. Properly parse the array format from the CLI
2. Use a different delimiter that doesn't conflict with path characters
3. Document the correct way to pass multiple file paths

**Workaround:** Call validation for each file individually using `file_path` (singular) parameter.

---

## [2026-02-26 08:08 PST] - Run Job Documentation Confusion

**What I was trying to do:** Create a run.job that calls multiple functions with debug logging.

**What the issue was:** The quick reference documentation for `run.job` was minimal and didn't clearly show the correct syntax. I initially wrote:
```xs
run.job "name" {
  description = "..."
  // function.run calls here...
}
```

But the actual syntax requires:
```xs
run.job "name" {
  main = {
    name: "function_name"
    input: { key: value }
  }
}
```

**Why it was an issue:** The run.job can only call ONE main function directly. To run multiple test cases with logging, I had to create a separate test_runner function that contains the multiple function.run calls, then have run.job call that test_runner function.

**Potential solution (if known):** The quick_reference mode for the `run` topic could include a complete minimal example showing the `main = { name: ..., input: ... }` syntax.

---

## [2026-02-26 08:10 PST] - Positive Experience

**What was working well:** Once I found the full documentation (using `mode=full`), the examples were very clear and helpful. The validation errors were specific and pointed to exact line/column numbers with helpful messages.

**What I appreciated:** 
- The `validate_xanoscript` tool gives precise error locations
- The full documentation includes complete working examples
- The syntax for functions with input/output is intuitive once learned
