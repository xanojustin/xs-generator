# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 16:02 PST] - MCP CLI Parsing Issue with Multiple File Paths

**What I was trying to do:** Validate multiple XanoScript files in a single call using the `file_paths` parameter with comma-separated values as shown in the documentation example: `file_paths: ["apis/users/get.xs", "apis/users/create.xs"]`

**What the issue was:** When using the mcporter CLI with comma-separated file paths, the parser treated each character after the comma as a separate file path argument. The command:
```
mcporter call xano.validate_xanoscript file_paths=/Users/justinalbrecht/xs/implement-stack-using-queues/run.xs,/Users/justinalbrecht/xs/implement-stack-using-queues/function/stack_using_queues.xs
```

Resulted in errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

Each character of the second path was being treated as a separate file path.

**Why it was an issue:** This prevented batch validation of multiple files in a single call, requiring me to make separate validation calls for each file, which is inefficient.

**Potential solution (if known):** 
- The MCP tool likely expects a JSON array format for the file_paths parameter
- The mcporter CLI may need special handling for array parameters
- Documentation could clarify the correct syntax for passing array parameters via CLI
- Workaround: Use `directory` parameter with a pattern instead, or call validation for each file individually

---

## [2026-02-23 16:03 PST] - XanoScript Documentation was Clear and Helpful

**What I was trying to do:** Write XanoScript code for a stack implementation using queues

**What went well:** The XanoScript documentation from `xanoscript_docs` was clear and provided:
- Clear examples of function structure
- Variable declaration syntax
- Conditional blocks and while loops
- Proper input/output patterns
- Filter usage with parentheses requirements

**Positive feedback:** The quick_reference mode was efficient for getting syntax patterns without overwhelming context usage. The existing examples in ~/xs/ were also helpful for understanding the expected patterns.

---

## Summary

Overall experience was positive. The main issue was with the MCP CLI argument parsing for array parameters. The XanoScript language itself was straightforward to write after consulting the documentation, and both files passed validation on the first attempt.
