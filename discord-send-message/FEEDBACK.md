# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 12:50 PST] - validate_xanoscript code parameter formatting

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool.

**What the issue was:**
The `code` parameter requires the raw XanoScript code as a string, but passing multi-line code via CLI was challenging. Initial attempts using `jq` to JSON-encode the file content resulted in the tool receiving escaped JSON strings (with `\n` literals) rather than the actual code.

Tried approaches that failed:
- `mcporter call xano.validate_xanoscript code="$(cat file.xs | jq -Rs '.')"` - passed JSON-encoded string with escapes
- `mcporter call xano.validate_xanoscript --args @file.json` - @ syntax not supported
- Piping JSON to `--args -` - the `-` was interpreted as a minus sign

**Why it was an issue:**
Spent significant time trying different shell escaping approaches before finding the working syntax: `mcporter call xano.validate_xanoscript code='raw code here'`. For multi-line code, single quotes work but require careful handling of special characters.

**Potential solution (if known):**
Consider accepting a `file_path` parameter as an alternative to `code` - this would allow direct file validation without shell escaping complexity. Many MCP tools offer both options.

---

## [2026-02-13 12:52 PST] - Unclear conditional/if syntax

**What I was trying to do:**
Write a function with optional parameters that conditionally adds fields to a payload object.

**What the issue was:**
First attempt used `if` directly in the stack:
```xs
if ($input.username|strlen > 0) {
  // ...
}
```

This failed validation with: "Expecting --> } <-- but found --> 'if' <--"

Also had issues with filter expressions in conditionals. The syntax `$input.username|strlen > 0` in a precondition required parentheses around the filter expression: `($input.username|strlen) > 0`.

**Why it was an issue:**
The documentation showed conditionals inside a `conditional` block, but it wasn't immediately clear that ALL `if` statements MUST be inside `conditional`. Also unclear when expressions need backticks vs when they work directly.

The correct syntax that finally worked:
```xs
conditional {
  if (`$input.username|strlen > 0`) {
    // ...
  }
}
```

**Potential solution (if known):**
- Clarify in the functions documentation that `if` can only exist inside `conditional` blocks
- Explain when backticks are required (seems to be for any expression with operators?)
- Add examples showing proper filter usage in conditionals

---

## [2026-02-13 12:53 PST] - Missing clear example for optional input handling

**What I was trying to do:**
Handle optional input parameters (text? username) by checking if they have values before using them.

**What the issue was:**
Couldn't find a clear pattern for "if optional input has value, add to object". Tried multiple approaches:
- `if ($input.username != null)`
- `if ($input.username|strlen > 0)`
- `$payload|set:"username":$input.username` (but this always sets, even if null)

The working solution required:
1. Creating a base payload object
2. Using conditional blocks with `merge` to add optional fields
3. Using backtick-wrapped expressions for the condition

**Why it was an issue:**
This is a common pattern (building objects with optional fields) but wasn't clearly documented. The `set` filter seemed like it might work but couldn't find clear docs on its behavior with null values.

**Potential solution (if known):**
Add a documentation section or example showing "Building objects with optional fields" - this would help with API integrations where many fields are optional.

---

## General Feedback

**What's working well:**
- The `xanoscript_docs` tool is comprehensive and well-organized by topic
- Validation errors include line/column numbers which is helpful
- The language server auto-detects object types from code syntax

**Areas for improvement:**
1. **Validation input method**: File path option would be simpler than code string
2. **More conditional examples**: Show real-world patterns like optional field handling
3. **Expression syntax clarity**: Better explain when backticks are required vs optional
4. **Filter chaining in expressions**: Document how filters work inside expressions vs as standalone operations
