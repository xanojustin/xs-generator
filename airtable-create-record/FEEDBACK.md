# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 15:47 PST] - file_paths Parameter Parsing Issue

**What I was trying to do:**
Validate multiple .xs files at once using the `file_paths` parameter with comma-separated values.

**What the issue was:**
When calling `validate_xanoscript` with `file_paths="/path/to/file1.xs,/path/to/file2.xs"`, the MCP tool interpreted the comma-separated string as individual characters instead of separate file paths. This resulted in validation errors like "File not found: U", "File not found: s", etc., as each character was treated as a separate file path.

**Why it was an issue:**
This prevented batch validation of multiple files, which is useful for validating entire run jobs with multiple .xs files. I had to fall back to validating each file individually, which is less efficient.

**Potential solution (if known):**
The MCP tool should properly parse the `file_paths` array parameter when passed via CLI. The tool schema defines it as an array of strings, but the CLI parsing seems to treat the comma-separated string as a single string and then splits it character by character. Either fix the CLI argument parsing to properly handle arrays, or provide an alternative method to pass multiple file paths (e.g., multiple `--file-path` flags).

**Workaround used:**
Validated files individually using `file_path` parameter instead of `file_paths`.

---

## [2026-02-16 15:48 PST] - Object Type with Description Block Validation Error

**What I was trying to do:**
Define an input parameter of type `object` with a description block in a function, following the pattern I saw for other types like `text` and `int`.

**Code that failed:**
```xs
input {
  object fields { description = "Record fields to create" }
}
```

**What the issue was:**
The XanoScript validator rejected this syntax with the error: "Expecting: expecting at least one iteration which starts with one of these possible Token sequences... but found: 'description'". The suggestion was to use "json" instead of "object".

**Why it was an issue:**
The documentation mentions `object` as a type name in the quick reference table, but doesn't clearly indicate when to use `object` vs `json`. The syntax for `object` with a description block appears to be invalid or different from other types. This was confusing because `text`, `int`, and other types support the `{ description = "..." }` syntax.

**Potential solution (if known):**
The documentation could be clearer about:
1. The difference between `object` and `json` types
2. When to use each type
3. What syntax is valid for each (e.g., `object` may require a full `schema { }` block instead of just a description)

**Fix applied:**
Changed `object fields { description = "..." }` to `json fields { description = "..." }` which passed validation.

---

## [2026-02-16 15:45 PST] - Documentation Request: Type Compatibility Matrix

**What I was trying to do:**
Understand which input types support which syntax patterns (e.g., description blocks, filters, default values).

**What the issue was:**
The documentation shows individual examples but doesn't provide a comprehensive compatibility matrix showing:
- Which types support `{ description = "..." }` blocks
- Which types support filters (e.g., `filters=trim`)
- Which types support default values (e.g., `?="default"`)
- The difference between `object` and `json` types

**Why it was an issue:**
Without this matrix, developers have to discover through trial and error which syntax patterns work with each type, leading to validation errors and wasted time.

**Potential solution (if known):**
Add a compatibility table to the `types` documentation topic showing:

| Type | Description Block | Filters | Default Value | Schema Required |
|------|------------------|---------|---------------|-----------------|
| text | ✓ | ✓ | ✓ | ✗ |
| int | ✓ | ✓ | ✓ | ✗ |
| bool | ✓ | ? | ? | ✗ |
| decimal | ✓ | ? | ? | ✗ |
| json | ✓ | ? | ? | ✗ |
| object | ? | ? | ? | ✓ (maybe?) |

---

## General Notes

### What Worked Well
1. The `xanoscript_docs` tool is excellent - comprehensive documentation with examples
2. The `validate_xanoscript` tool provides helpful error messages with line/column numbers
3. The MCP is fast and responsive
4. The documentation covers common patterns and mistakes very well

### Suggestions for Improvement
1. **Batch validation**: Fix the `file_paths` array parameter parsing
2. **Type documentation**: Clarify `object` vs `json` and when to use each
3. **IDE support**: Consider adding an LSP mode to the MCP for real-time validation in editors
4. **Error context**: Show more context lines in validation errors (currently shows just the problematic line)

### Overall Experience
Despite the minor issues above, the development experience was smooth. The documentation is comprehensive, and the validation tool caught errors quickly with helpful suggestions. Creating a run job from scratch took about 10 minutes once I understood the syntax patterns.
