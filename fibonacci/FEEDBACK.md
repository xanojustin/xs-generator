# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 21:05 PST] - Validation parameter format confusion

**What I was trying to do:** Validate the XanoScript file using the MCP's `validate_xanoscript` tool

**What the issue was:** The MCP tool expects parameters in `key=value` format (e.g., `file_path=/path/to/file.xs`), not JSON format. I initially tried passing JSON parameters like `'{"file_paths": [...]}'` and `'{"file_path": "..."}'` but the tool kept responding with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** The error message suggests JSON-style parameters are expected, but the mcporter CLI actually uses key=value syntax. This mismatch between the error message hint and actual required format was confusing.

**Potential solution:** Either:
1. Update the error message to suggest using `key=value` format for mcporter CLI users
2. Support both JSON and key=value formats
3. Document the expected parameter format in the MCP tool description

---

## [2026-02-18 21:06 PST] - Limited documentation on function structure

**What I was trying to do:** Understand the exact XanoScript function syntax for run jobs

**What the issue was:** The `xanoscript_docs` tool returned the same general documentation for both `functions` and `quickstart` topics, which didn't provide specific syntax details for function definitions like input blocks, stack blocks, and response assignment.

**Why it was an issue:** I had to examine existing implementations (`fizzbuzz`, `factorial`) to understand the proper structure instead of relying on documentation. This is a common pattern - learning by example rather than specification.

**Potential solution:** 
1. Add a specific topic like `xanoscript_docs({ topic: "function-syntax" })` that shows complete function syntax with all available options
2. Include more code examples in the `functions` documentation topic

---

## [2026-02-18 21:07 PST] - Validation passed on first attempt

**What I was trying to do:** Validate the initial fibonacci implementation

**What the issue was:** None - validation passed on first attempt!

**Why this is notable:** After examining several existing implementations, the function structure was clear enough to write valid code without iterative fixes. The existing exercises serve as good reference material.

**Observation:** The validation tool works well and provides clear pass/fail feedback. No issues encountered with this step.
