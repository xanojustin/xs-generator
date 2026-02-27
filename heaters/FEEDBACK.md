# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 06:05 PST] - Inline comment parsing issue

**What I was trying to do:** Add an inline comment after a variable value assignment to document that 2147483647 represents the maximum integer value.

**What the issue was:** The parser failed with error "but found: '/'" when encountering an inline comment `// Max int` on the same line as code:
```xs
value = 2147483647  // Max int
```

**Why it was an issue:** This is unexpected because the documentation states "XanoScript only supports `//` for comments" which implies they should work. The error suggests either:
1. Comments must be on their own line (not inline with code)
2. There's a specific syntax requirement for inline comments that wasn't clear

**Potential solution:** 
- Clarify in documentation whether inline comments are supported
- If not supported, explicitly state "comments must be on their own line"
- If supported, provide examples of valid inline comment syntax

---

## [2025-02-27 06:06 PST] - mcporter argument parsing confusion

**What I was trying to do:** Validate multiple files using the validate_xanoscript tool with JSON parameters.

**What the issue was:** Initially tried using JSON format like `'{"file_paths": [...]}'` but the mcporter CLI interpreted the JSON as arguments incorrectly, resulting in errors like "Expecting --> function <-- but found --> '-' <--" when it parsed `--file_path` as code.

**Why it was an issue:** The CLI syntax for passing named parameters wasn't immediately clear from the error messages or documentation. The examples in the tool description showed both `mcporter call xano.validate_xanoscript(file_path: ...)` format and `'{"file_paths": ...}'` format, but neither worked as expected.

**Potential solution:**
- Document the correct mcporter CLI syntax more clearly (e.g., `key=value` format)
- Provide working examples in the CLI help text
- The `file_path=value` syntax worked, but this wasn't obvious from the examples

---
