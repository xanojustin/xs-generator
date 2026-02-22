# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 18:05 PST] - JSON Parameter Passing Syntax Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with file paths

**What the issue was:** The mcporter CLI expects parameters in `key:value` format, 
not JSON format. I initially tried:
- `mcporter call xano --tool validate_xanoscript '{"file_path": "/path/to/file"}'`

This resulted in the error: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** The documentation and tool description show JSON examples like:
`file_path: "/path/to/file.xs"` but the CLI actually requires the syntax:
`mcporter call xano --tool validate_xanoscript file_path:/path/to/file.xs`

**Potential solution:** The tool description in the MCP could clarify the expected CLI 
syntax, or the mcporter CLI could accept JSON format with `--args` flag as documented 
in the help text.

---

## [2025-02-21 18:10 PST] - validate_xanoscript Works Well

**What I was trying to do:** Validate XanoScript files for syntax errors

**What the issue was:** None - the tool worked perfectly once the correct syntax was used.

**Why it was good:** Both files passed validation immediately, indicating the XanoScript 
syntax I learned from existing examples was correct.

**Potential improvement:** Would be helpful if the validation tool also checked for 
common logic errors or provided warnings (e.g., unused variables, potential infinite loops).

---

## [2025-02-21 18:12 PST] - Lack of Specific Function/Run Job Documentation

**What I was trying to do:** Find detailed documentation on the `function` and `run.job` constructs

**What the issue was:** The `xanoscript_docs` tool with topics `functions` and `run` 
returned the general README/overview instead of specific syntax documentation for:
- How to structure a `function` block (input, stack, response)
- How to structure a `run.job` block (main, name, input)
- Available operations within the stack block
- How loops, conditionals, and variable declarations work

**Why it was an issue:** I had to rely on reading existing implementations in the `~/xs/` 
folder to understand the correct syntax for:
- `var $name { value = ... }` for variable declaration
- `while (condition) { each { ... } }` for loops
- `conditional { if (condition) { ... } }` for conditionals
- `response = $var` for output

**Potential solution:** 
1. Add specific documentation topics for each construct type (function, run.job, query, etc.)
2. Include syntax examples for common patterns (loops, conditionals, variable operations)
3. Document the available filters and their usage (e.g., `|to_text`, `|merge`, `|split`)

---

## [2025-02-21 18:15 PST] - Modulo Operator in Conditionals

**What I was trying to do:** Use the modulo operator in an if condition

**What the issue was:** Uncertainty about whether backticks are required for expressions 
like `$i % 15 == 0` in conditional statements.

**Why it was an issue:** I saw in existing code (fizzbuzz) that backticks are used:
```xs
if (`$i % 15 == 0`) { ... }
```

But the documentation doesn't clearly explain when backticks are required vs optional.

**Potential solution:** Document the expression evaluation rules - when expressions need 
to be wrapped in backticks vs when they can be written directly.
