# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 14:50 PST] - MCP validate_xanoscript Requires Code Parameter

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool.

**What the issue was:**
The tool requires a `code` parameter containing the actual script content, not a `file_path`. When I tried to pass a file path, I got: "Error: 'code' parameter is required".

**Why it was an issue:**
This required extra scripting to read file contents and pass them to the validation tool. It would be more convenient if the tool could accept either `code` (string) or `file_path` (path to read).

**Potential solution:**
Add a `file_path` parameter as an alternative to `code`, or document that validation requires reading the file content first.

---

## [2026-02-13 14:52 PST] - Object Type Requires Schema Definition

**What I was trying to do:**
Define an input parameter with type `object` for accepting JSON data.

```xs
input {
  object fields
}
```

**What the issue was:**
The validator returned: "Expecting --> { <-- but found --> newline". The `object` type requires a schema definition block with `{ schema { ... } }`.

**Why it was an issue:**
The documentation shows `object` as a valid type, but doesn't clearly indicate that it requires a schema. For flexible JSON input (like API request bodies), this is overly restrictive.

**Potential solution:**
Either allow `object` without a schema for flexible JSON input, or document that `json` type should be used for unstructured data.

---

## [2026-02-13 14:55 PST] - Expression Syntax with Filters and Comparisons

**What I was trying to do:**
Use preconditions with expressions combining filters and comparisons:

```xs
precondition ($input.fields|count > 0) {
  error_type = "inputerror"
  error = "fields object must contain at least one field"
}
```

**What the issue was:**
Got error: "An expression should be wrapped in parentheses when combining filters and tests". The same issue occurred with boolean operators (`&&`).

**Why it was an issue:**
The error message suggests wrapping in parentheses, but that didn't work. Had to use backticks (`` `$input.fields|count > 0` ``) to wrap the expression, which isn't clearly documented.

**Potential solution:**
Update documentation to clearly explain when and how to use backticks for expression wrapping. The error message could be more specific about using backticks.

---

## [2026-02-13 14:58 PST] - Boolean Operators Not Working in Expressions

**What I was trying to do:**
Check if HTTP status is in success range (200-299):

```xs
precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
  error_type = "standard"
  error = "API request failed"
}
```

**What the issue was:**
The `&&` operator caused validation errors even when wrapped in backticks or parentheses. Tried multiple approaches:
- Wrapping in backticks
- Wrapping in parentheses
- Using a separate variable
- Using `conditional` blocks

None of these worked cleanly.

**Why it was an issue:**
Complex conditional logic is common in API handling. Having to work around this limitation makes error handling more verbose and less intuitive.

**Potential solution:**
Document the proper syntax for boolean operators, or provide working examples of complex conditionals in the documentation.

---

## [2026-02-13 15:00 PST] - Conditional Block Syntax Unclear

**What I was trying to do:**
Use a `conditional` block with multiple `if` statements for status code checking:

```xs
conditional {
  if ($api_result.response.status < 200) {
    throw { ... }
  }
  if ($api_result.response.status >= 300) {
    throw { ... }
  }
}
```

**What the issue was:**
Got error: "Expecting: one of these possible Token sequences... but found 'if'". The parser expected `elseif` or `else` after the first `if`, not another `if`.

**Why it was an issue:**
The documentation shows `if`, `elseif`, `else` structure but doesn't indicate that multiple independent `if` statements in one `conditional` block is invalid.

**Potential solution:**
Document that `conditional` blocks require `elseif` for additional conditions, or allow multiple independent `if` statements.

---

## [2026-02-13 15:02 PST] - Input Field Descriptions Not Supported

**What I was trying to do:**
Add descriptions to input fields for better documentation:

```xs
input {
  text base_id filters=trim { description = "The ID of the Airtable base" }
}
```

**What the issue was:**
Got parser error: "Expecting: expecting at least one iteration which starts with one of these possible Token sequences: <[NewlineToken]> but found: 'description'".

**Why it was an issue:**
The documentation shows examples with descriptions in input fields, but this syntax doesn't validate.

**Potential solution:**
Either remove the description examples from documentation or fix the parser to support this syntax.

---

## Summary

The overall experience was challenging due to:
1. **Documentation vs. Reality gaps** - Several documented features didn't validate correctly
2. **Unclear error messages** - Parser errors often didn't clearly indicate the actual problem
3. **Expression syntax complexity** - The rules for when to use backticks, parentheses, etc. are not well documented
4. **Type system confusion** - The difference between `object` (requires schema) and `json` (flexible) wasn't clear

The MCP validation tool itself worked well once I understood it needed the `code` parameter. The main friction was between the documentation examples and what actually validates.
