# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 01:05 PST] - MCP Tool Array Parameter Parsing

**What I was trying to do:** Validate multiple XanoScript files using the `validate_xanoscript` tool with the `file_paths` parameter.

**What the issue was:** When passing comma-separated file paths via CLI-style arguments (`file_paths=path1,path2`), the MCP server parsed the comma-separated string character-by-character instead of as an array. Each character became a separate "file path" to validate, causing 134 "File not found" errors for individual characters like "U", "s", "e", "r", etc.

**Why it was an issue:** This made it impossible to use the standard CLI argument format for batch validation. The workaround required using JSON format with `--args '{"file_paths":["path1","path2"]}'` which is less intuitive.

**Potential solution:** The MCP tool should either:
1. Properly parse comma-separated values for array-type parameters in CLI mode
2. Document that JSON format is required for array parameters
3. Accept the `directory` parameter as a simpler alternative for batch validation (though the directory parameter also had issues with path expansion)

---

## [2025-02-24 01:06 PST] - Documentation on Run Job Structure

**What I was trying to do:** Understand how to structure a run job that calls a function.

**What the issue was:** The documentation was clear, but I initially wasn't sure if `run.job` could call functions in subdirectories or if they needed to be at the root level. Looking at existing examples clarified this.

**Why it was an issue:** Minor confusion about whether the `main.name` field should include paths like `"function/binary_tree_postorder"` or just `"binary_tree_postorder"`.

**Potential solution:** Add an explicit note in the `run` documentation that function names are resolved by their declared name in the `function "<name>"` block, not by file path. The file location (e.g., `function/name.xs`) is just for organization.

---

## [2025-02-24 01:07 PST] - Array Index Access Documentation

**What I was trying to do:** Access array elements by index (e.g., `$input.nodes[$current]`).

**What the issue was:** The quick reference documentation didn't explicitly show the array index access syntax. I inferred it from existing examples but wasn't 100% certain.

**Why it was an issue:** Array indexing is a fundamental operation, and clear documentation would reduce uncertainty.

**Potential solution:** Add a line to the quickstart or syntax documentation showing array access: `$array[$index]` or `$input.my_array[0]`.

---

## Positive Feedback

**XanoScript syntax was intuitive** - After reading the quickstart and looking at existing examples, writing the post-order traversal was straightforward. The two-stack algorithm translated cleanly to XanoScript.

**Validation tool is helpful** - Despite the CLI parsing issue, the validation tool provides clear feedback. Having it catch syntax errors before deployment is valuable.

**Documentation structure is good** - The ability to request specific topics (`functions`, `run`, `quickstart`) and modes (`quick_reference`, `full`) made it easy to find relevant information without overwhelming context.
