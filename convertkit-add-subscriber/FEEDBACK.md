# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 21:20 PST] - Reserved Variable Name Error

**What I was trying to do:**
Create a XanoScript function that returns a response object containing the API result.

**What the issue was:**
Used `var $response` as a variable name inside the stack block, which caused a validation error:
```
[Line 50, Column 13] '$response' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
The documentation mentions that `$response` is reserved at the end of the syntax section, but it's easy to miss. I was using it as an internal variable before assigning to the final `response = ...` block.

**Potential solution (if known):**
- Highlight this more prominently in the quickstart documentation
- Add a linter warning or better error message suggesting alternatives like `$result_data`

---

## [2026-02-14 21:18 PST] - Optional Field Syntax Confusion

**What I was trying to do:**
Define optional input fields using the `?` syntax shown in the documentation examples.

**What the issue was:**
The documentation shows `int age? filters=min:0` as valid syntax, but when I used `text first_name? filters=trim` and `object[]? tags`, the validator gave an error about expecting an identifier instead of `?`.

**Why it was an issue:**
It appears the optional field marker syntax might not work consistently across all field types, or there's a parsing issue when combined with filters or complex types like `object[]`.

**Potential solution (if known):**
- Clarify in the documentation which field types support the `?` optional marker
- Ensure the parser handles optional markers consistently across all types
- Provide examples of optional fields for each type (text?, int?, object[]?, etc.)

---

## [2026-02-14 21:15 PST] - MCP Validate Tool Interface

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool.

**What the issue was:**
Initially tried to pass a file path to the validator, but it requires the actual code content via a `code` parameter. The error message was:
```
Error: 'code' parameter is required
```

**Why it was an issue:**
Had to read the file content and pass it as a parameter instead of just referencing the file path. This makes validation workflows more complex.

**Potential solution (if known):**
- Support both `file` and `code` parameters in the validate tool
- Or provide a clearer error message like: "Use 'code' parameter with file contents, or use 'file' parameter with path"

---

## [2026-02-14 21:22 PST] - Throw Syntax Documentation Gap

**What I was trying to do:**
Throw an error with a structured object containing multiple fields.

**What the issue was:**
Was unsure about the exact syntax for throw - specifically whether to use `:` or `=` for assigning properties.

**Why it was an issue:**
The quickstart documentation shows:
```xs
throw {
  name = "APIError",
  value = "..."
}
```

But some languages use `:` for object properties, so it was ambiguous. I had to experiment to confirm `=` is correct.

**Potential solution (if known):**
- Include a dedicated error handling section in the quickstart with complete throw examples
- Show throw with both simple strings and complex objects

---

## Summary

Overall the XanoScript documentation is comprehensive and the MCP tools work well. The main friction points were:

1. **Reserved words** - Easy to accidentally use `$response` as a variable
2. **Optional field syntax** - Unclear which types support the `?` marker
3. **Validation workflow** - Having to pass code content instead of file paths
4. **Throw syntax** - Minor ambiguity about `=` vs `:` for property assignment

The documentation structure is excellent with the topic-based organization. The quickstart guide was particularly helpful for common patterns.
