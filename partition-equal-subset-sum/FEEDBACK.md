# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 07:35 PST] - MCP Tool Parameter Syntax Documentation

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The documentation shows parameter formats like `file_path?: string` but doesn't clearly show the CLI syntax for passing parameters. I tried multiple formats:
- `mcporter call xano validate_xanoscript '{"file_path": "/path/to/file"}'`
- `mcporter call xano validate_xanoscript --file_path=/path/to/file`
- `mcporter call xano validate_xanoscript file_path=/path/to/file` (this worked!)

**Why it was an issue:** Wasted time trying different JSON formats and flag formats before finding the correct `key=value` syntax

**Potential solution:** Add a clear example in the tool description showing the correct CLI syntax: `mcporter call xano.validate_xanoscript file_path="/path/to/file.xs"`

---

## [2026-02-24 07:38 PST] - Successful First-Time Validation

**What I was trying to do:** Write a complete XanoScript function and run job for the Partition Equal Subset Sum problem

**What happened:** Both files validated successfully on the first attempt!

**What worked well:**
1. The existing examples in `~/xs/` were excellent references
2. The documentation from `xanoscript_docs` provided clear syntax patterns
3. The error messages from the validation tool are clear and helpful
4. The type system (int[], bool, etc.) is intuitive

**Key patterns that helped:**
- Looking at existing exercises like `valid-parentheses` and `two-sum` for structure
- Understanding the `var $name { value = ... }` pattern for variable declaration
- The `conditional { if (...) { ... } }` syntax for conditionals
- Using `var.update $name { value = ... }` for updating variables
- The `return { value = ... }` pattern for early returns

---

## Overall Feedback

The Xano MCP is working well! The main friction point was understanding the CLI parameter syntax. Once that was figured out, the validation tool worked perfectly and the code was correct on the first attempt.

The existing exercise examples in the `~/xs/` directory are extremely helpful for understanding the expected patterns and structure.
