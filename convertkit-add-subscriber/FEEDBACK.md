# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-16 23:18 PST - MCP Tool Parameter Passing Confusion

**What I was trying to do:**
Call the `validate_xanoscript` tool to validate my .xs files.

**What the issue was:**
The mcporter tool expects parameters in a specific format that wasn't clear. I tried several approaches:
- `mcporter call xano validate_xanoscript --params '{"file_path": "/path"}'` - Error: Unknown topic "--params"
- `mcporter call xano validate_xanoscript '{"file_path": "/path"}'` - Error: parameter required
- `mcporter call xano validate_xanoscript "file_path=/Users/justinalbrecht/xs/..."` - This finally worked

**Why it was an issue:**
The documentation shows JSON parameter examples like `mcporter call xano xanoscript_docs({ topic: "quickstart" })` but this format doesn't work for the validate tool. The working format uses `key=value` strings instead of JSON.

**Potential solution:**
Standardize the parameter passing format across all tools, or update documentation to clarify which format each tool expects.

---

## 2025-02-16 23:20 PST - Input Parameter `optional` Keyword Not Valid

**What I was trying to do:**
Define optional input parameters in a function using the `optional = true` syntax.

**What the issue was:**
I wrote:
```xs
input {
  text first_name { description = "First name", optional = true }
}
```

This caused validation errors:
- "The argument 'optional' is not valid in this context"
- "Expected value of `optional` to be `null`"

**Why it was an issue:**
The documentation mentions input blocks and types but doesn't clearly explain how to handle optional parameters. There's no example showing the correct pattern for optional vs required fields.

**Potential solution:**
Add documentation showing how to handle optional inputs (e.g., by checking string length in the stack or using default values).

---

## 2025-02-16 23:22 PST - Filter Expression Parentheses Required

**What I was trying to do:**
Check if a string has length using `strlen` filter combined with a comparison.

**What the issue was:**
I wrote:
```xs
if ($input.first_name|strlen > 0) {
```

This failed validation with: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:**
The precedence rules for filters vs comparisons weren't clear. I had to change it to:
```xs
if (($input.first_name|strlen) > 0) {
```

**Potential solution:**
Add a clear example in the documentation showing this pattern: `($var|filter) > value` instead of `$var|filter > value`.

---

## 2025-02-16 23:24 PST - `parse.json` vs `json_decode` Filter Confusion

**What I was trying to do:**
Parse a JSON string into an object/array.

**What the issue was:**
I initially tried:
```xs
parse.json {
  value = $input.tags_json
} as $tag_list
```

This failed with: "Expecting --> } <-- but found --> 'parse' <--"

The documentation mentioned `parse.object` and `parse.array` under the schema topic, but I couldn't find the correct syntax for parsing JSON from a string.

After trial and error, I found that the `json_decode` filter works:
```xs
var $tag_list {
  value = $input.tags_json|json_decode
}
```

**Why it was an issue:**
The documentation index mentions `parse.object` and `parse.array` but there's no clear guidance on when to use parse.* operations vs filter operations for JSON handling.

**Potential solution:**
Add a clear section on JSON parsing with examples showing both approaches and when to use each.

---

## 2025-02-16 23:25 PST - Array Type Syntax Documentation

**What I was trying to do:**
Define an array input parameter for tag IDs.

**What the issue was:**
The documentation mentions `type[]` for arrays but I was unsure about the exact syntax. I tried `int[]` which the validator suggested was correct, but the error message was confusing: "Use 'type[]' instead of 'array'" when I wasn't using the word "array".

**Why it was an issue:**
The validator message seemed to suggest I was using a type called "array" when I wasn't. The correct syntax `int[]` worked, but the error was misleading.

**Potential solution:**
Improve error messages to be more contextual - if the user is already using `[]` syntax, don't suggest they use `type[]`.

---

## Summary

Overall the MCP validation tool is extremely helpful for catching syntax errors! The main struggles were around:

1. **Parameter passing format** - Inconsistent between tools
2. **Optional inputs** - No clear documentation on the correct pattern
3. **Filter precedence** - Parentheses required but not obvious
4. **JSON parsing** - Multiple ways to do it, unclear which to use when

The validator's error messages were generally helpful with line/column numbers and suggestions. With better documentation examples, the development experience would be smoother.
