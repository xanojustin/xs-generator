# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-23 10:32 PST - MCP Tool Invocation Syntax Unclear

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The documentation shows calling the tool with JSON parameters like `xanoscript_docs({ topic: "run" })`, but the actual `mcporter call` command uses `key=value` syntax instead of JSON. It took several attempts to figure out the correct syntax:
- Tried JSON format: `'{"file_paths": [...]}'` - failed
- Tried `--directory` flag - failed  
- Tried `--params` flag - failed
- Finally worked: `mcporter call xano.validate_xanoscript directory:/path/to/dir`

**Why it was an issue:** The documentation in the XanoScript docs shows function-style calls with JSON objects, but the actual CLI uses a different key=value syntax. This mismatch caused confusion and multiple failed attempts.

**Potential solution:** Update the documentation to show actual mcporter CLI usage examples, or provide both formats (function-style for understanding, CLI-style for actual usage).

---

## 2026-02-23 10:33 PST - No Validation Errors (Success)

**What I was trying to do:** Validate my XanoScript code after writing it

**What the issue was:** No issues! Both files passed validation on the first attempt.

**Why this is worth noting:** After reviewing many existing examples in the `~/xs/` directory, I was able to understand the patterns well enough to write correct XanoScript code. The existing exercises served as good reference material.

**Observations:**
- The `|get:key:default` filter is very useful for safely accessing object properties
- The `|set:key:value` filter for building objects incrementally works well
- Return statements within conditionals require the `return { value = ... }` syntax
- The iterative approach using a stack to simulate recursion works well for tree traversal
